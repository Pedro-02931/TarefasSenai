# Formatando e Instalando o Windows 7 pelo CMD

Bom, apesar dos instaladores atuais serem simples e intuitivo, isso conflita com minha vontade de viver fazendo tudo complexo, então decidi executar a atividade de formatação e instalação executando um conjuno de comandos.

A primeira etapa consiste na formatação do disco a ser intalado, onde pode ser configurado pelo Diskpart que é uma ferramenta nativa, em que basicamente seleciono o disco e crio as partições formatando no formato NTFS.

Em seguida basta usar o dism para executar o `:\sources\install.wim` no disco alvo, mas explicarei mais detalhadamente a seguir.
