# Criação Automática de Usuários: New-CustomUser

Ao invés de adicionar cada usuário manualmente, o script cria uma rotina que lê uma lista de usuários pré-definidos usando hash table para criar um vetor que carrega vetor dentro de vetor (falando como um humano, imagina uma tabela com colunas e linhas)

A criação automatizada também garante padronização, especialmente em ambientes corporativos onde a consistência das credenciais de acesso e políticas de senha são cruciais. Nesse caso, todos os usuários são criados com uma senha padrão e configurados para que a senha nunca expire, o que é ideal para ambientes de teste e laboratório.

#### **Usuários a serem criados:**

* **Admin:** Terra (Controle total sobre o sistema)
* **Comuns:** Vênus, Marte (Acesso moderado a determinadas pastas)
* **Restritos:** Júpiter, Saturno (Permissão apenas para leitura em algumas pastas)
* **Convidados:** Netuno, Urano (Acesso extremamente limitado, apenas leitura em áreas específicas)

```powershell
# Define os usuários e suas informações em uma hash table
$users = @(
    @{ Name = "Terra";   FullName = "Admin Terra";     Password = "P@ssw0rd" },
    @{ Name = "Vênus";   FullName = "Comum Vênus";     Password = "P@ssw0rd" },
    @{ Name = "Marte";   FullName = "Comum Marte";     Password = "P@ssw0rd" },
    @{ Name = "Júpiter"; FullName = "Restrito Júpiter"; Password = "P@ssw0rd" },
    @{ Name = "Saturno"; FullName = "Restrito Saturno"; Password = "P@ssw0rd" },
    @{ Name = "Netuno";  FullName = "Convidado Netuno"; Password = "P@ssw0rd" },
    @{ Name = "Urano";   FullName = "Convidado Urano";  Password = "P@ssw0rd" }
)

# Itera sobre os usuários e cria cada um, se não existir
foreach ($user in $users) {
    if (-not (Get-LocalUser -Name $user.Name)) {
        New-LocalUser -Name $user.Name -FullName $user.FullName `
        -Password (ConvertTo-SecureString $user.Password -AsPlainText -Force)
        
        Set-LocalUser -Name $user.Name -PasswordNeverExpires $true
        Write-Host "Usuário criado: $($user.Name)"
    } else {
        Write-Host "Usuário já existe: $($user.Name)"
    }
}
```

#### **Pontos-Chave:**

* A variável `$users` é uma coleção de objetos para evitar a necessidade de múltiplas chamadas ao `New-LocalUser`, centralizando os dados em uma única estrutura, veja ela como uma tabela, em que a chave é a coluna, e o valor é a lista.
* O `Get-LocalUser` é usada para verificar se o usuário já existe no sistema antes de tentar criá-lo.&#x20;
* A senha é convertida em uma `SecureString` utilizando o `ConvertTo-SecureString`. [Nunca que uma empresa não usaria uma tabela sem criptografia basica rsrsrs](https://g1.globo.com/economia/tecnologia/noticia/2021/01/28/vazamento-de-dados-de-223-milhoes-de-brasileiros-o-que-se-sabe-e-o-que-falta-saber.ghtml)
* O comando `Set-LocalUser -PasswordNeverExpires $true` foi definido por ser um ambiente controlado.
