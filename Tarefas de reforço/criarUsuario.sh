#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "Usuário root necessário"
    exit 1
fi

: <<'COMENTARIO'
+ Tabela
- Usado array associativos para mapear sobrenomes e senhas de forma estruturada, permitindo acesso a dados sem necessidade de lista ou loops ineficientes.
- Pensa nele como um dicionário onde você não acessa os valores por um índice numérico (0, 1, 2...), mas sim por uma chave de texto.
- Particularmente prefiro mapear informações relacionadas, tipo sobrenome e senha, de um jeito organizado e eficiente, sem ter que ficar varrendo listas gigantescas.
- Cada linha dentro dos parênteses representa um elemento do array, no formato ["chave"]="valor". 
- No caso, a chave é o nome do usuário e o valor é uma string concatenando o nome, um caractere separador (":") e o hash da senha gerado no passo anterior.

+ Segurança
- O comando openssl passwd -6 "$password" pega o valor da variável password ("pmota") e aplica uma função de hash SHA-512 (indicado pelo -6).
-  Dado que o hash é unidirecional é extremamente difícil (computacionalmente falando, quase impossível(embora você possa aumentar a escala quantica de computação e cotornar isso, mas teriam de me pagar para fazer)) pegar o hash gerado e descobrir a senha original. 
- Isso é fundamental para segurança: em vez de guardar a senha no sistema, a gente guarda o pass_hash, que é uma representação segura dela. Se um invasor conseguir acesso ao sistema, ele terá os hashes, mas não as senhas em texto plano.
# Considerando que é mais um script de teste, vou deixar um texto plano mesmo
COMENTARIO 
declare -A users
pass_hash=$(openssl passwd -6 "pmota")  
users=(
    ["cesar"]="Vargas:$pass_hash"
    ["marcela"]="Lin:$pass_hash"
    ["roger"]="Guedes:$pass_hash"
    ["luan"]="Santana:$pass_hash"
    ["ana"]="Fagundes:$pass_hash" 
    ["bruna"]="Cardoso:$pass_hash"
    ["diego"]="Maradona:$pass_hash"
    ["marta"]="Silva:$pass_hash"
    ["ronaldo"]="Cristiano:$pass_hash"
    ["neymar"]="Jr:$pass_hash"
)



: <<'COMENTARIO'
+ Laço
- A variável user vai iterar sobre as chaves do array associativo users.
- A sintaxe ${!usuarios[@]} expande para a lista de todas as chaves (os nomes).
- Cada iteração do loop, a variável usuario vai receber um desses nomes.

+ Leitura de Dados
- A função IFS (Internal Field Separator) é usada para definir o caractere que separa os campos em uma string.
- O comando read é usado para ler os dados
    + O `-r` impede a interpretação de caracteres especiais como \n e \t como boa prática de segurança e o `-a` indica que os dados devem ser armazenados em um array.
    + O `<<<` é uma forma de "heredoc" (ou "here string") que permite passar uma string de várias linhas como entrada para um comando.
    + Após a leitura, o conteúdo é segmentado em duas variaveis e adiciona os usuários recursivamente
COMENTARIO

for user in "${!users[@]}"; do    
    IFS=':' read -ra user_info <<< "${user[$users]}"
    name="${user_info[0]}"
    pass="${user_info[1]}"
    useradd -m -s /bin/bash -p "$pass" "$name"
done

: <<'COMENTARIO'
+ Ordenação
- O `mapfile` lê as linhas da entrada padrão (no caso o printf) em um array
    + O `-t` remove o caractere newline de cada elemento do array.
    + A variável `user_list` recebe um array indexado com cada usuário separado.
- O objetivo é a coleta da lista de nomes de usuários que eram as chaves do nosso array associativo e as atribui em um array linear e sequencial chamado user_list. Isso facilita a aplicação do algoritmo de embaralhamento.

+ Embaralhamento
- Usado o método Fisher-Yates Shuffle que é um algoritmo simples para embaralhar uma lista de elementos de forma "aleatória".
    + A variável `i` é inicializada com o índice do ultimo elemento(user_list-1), e vai diminuindo até chegar em 0 através da condicional.
    + A variável `j` gera um indice aleatório através da variável `RANDOM`, onde o ao dividir o numero aleatório pelo i + 1, o resto da divisão é um número entre 0 e i.
- A troca de posições é feita através de uma variável temporária.
    + A varíavel `temp` recebe o valor do ultimo elemento na posição i (o último elemento na porção não embaralhada).
    + O valor do ultimo elemento na posição i é substituído pelo valor do elemento na posição j (um elemento aleatório na porção não embaralhada)
    + O valor do elemento na posição j é substituído pelo valor da variável temporária (o valor do último elemento na porção não embaralhada)
COMENTARIO

mapfile -t user_list < <(printf '%s\n' "${!users[@]}")  # Converte a hashtable em lista
for ((i=${#user_list[@]}-1; i>0; i--)); do
    j=$((RANDOM % (i+1)))  # Gera um índice aleatório
    temp=${user_list[i]}  # Troca posições na lista
    user_list[i]=${user_list[j]}
    user_list[j]=$temp
done
selected=("${user_list[@]:0:5}")  # Seleciona os primeiros 5

: <<'COMENTARIO'
- Essa sessão do script tá focada na organização do espaço para os usuários que foram selecionados aleatoriamente na etapa anterior. 
- É como se estivéssemos preparando o terreno, criando as casinhas e colocando algumas ferramentas básicas pra galera começar a trabalhar.

- O loop for é usado para iterar sobre cada usuário randomizado e cria a varíavel last_name
    - O `cut` é usado para extrair o sobrenome do usuário.
    - A opção `-d` especifica o caractere delimitador (neste caso, o caractere ':').
    - A opção `-f1` especifica o número do campo que você deseja extrair.
    - É usado novamente o heredoc.

- No caso, o desafio era criar manualmente um diretório com o sobre nome de cada usuário, e colocar dois arquivos que representariam os pais, mas dado que prefiro codar essa merda do que fingir me importar com a galera, então so cloquei dois arquivos aleatórios.
    +  o uso do -p garante que, se alguma pasta pai no caminho não existir, ele será criada automaticamente.
    + Além disso, se pasta já existir, nenhhum erro será gerado.
    + O `chown` é usado para ajustar o dono do diretório para o usuário especificado.

- O laço for é usado para criar dois arquivos temporários de forma segura.
    + O `mktemp` é usado para criar um nome de arquivo aleatório.
    + O `touch` e o chown é usado para criar o arquivo e ajustar permissões.

COMENTARIO

for users in "${selected[@]}"; do
    last_name=$(cut -d':' -f1 <<< "${users[$user]}") 
    last_name_dir="/home/$user/$last_name"
    mkdir -p "$last_name_dir" && chown "$user" "$last_name"  


    for i in {1..2}; do
        arquivo=$(mktemp -u "$$last_name_dir/XXXXXXXXXX")  
        touch "$arquivo"
        chown "$usuario" "$arquivo" 
    done
done
