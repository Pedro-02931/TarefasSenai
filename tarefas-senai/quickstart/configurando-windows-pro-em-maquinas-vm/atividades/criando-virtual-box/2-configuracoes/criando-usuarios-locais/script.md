# Script

{% code overflow="wrap" %}
```powershell
# 1. Mapeamento dos Usuários: O Grafo Neural
$usuarios = @(
    @{ Nome = "Carlos";  FullName = "Carlos";  Password = "P@ssw0rd" },
    @{ Nome = "Antonio"; FullName = "Antonio"; Password = "P@ssw0rd" },
    @{ Nome = "Maria";   FullName = "Maria";   Password = "P@ssw0rd" },
    @{ Nome = "Felipe";  FullName = "Felipe";  Password = "P@ssw0rd" },
    @{ Nome = "Andre";   FullName = "Andre";   Password = "P@ssw0rd" },
    @{ Nome = "Lucio";   FullName = "Lúcio";   Password = "P@ssw0rd" }
)
# Cada usuário é um nó na nossa rede, com atributos que determinam
# como ele se conecta aos grupos e responde aos comandos do sistema.

# 2. Criação dos Usuários: O Ciclo Sináptico
foreach ($usuario in $usuarios) {
    if (-not (Get-LocalUser -Name $usuario.Nome -ErrorAction SilentlyContinue)) {
        # Cria o usuário se ele não existir (colapso da função de onda)
        New-LocalUser -Name $usuario.Nome -FullName $usuario.FullName `
            -Password (ConvertTo-SecureString $usuario.Password -AsPlainText -Force)
        # Define que a senha nunca expira para o usuário recém-criado
        Set-LocalUser -Name $usuario.Nome -PasswordNeverExpires $true
        Add-LocalGroupMember -Group "Usuários" -Member $usuario.Nome # Correção por que não adicionava
        Write-Host "Usuário criado: $($usuario.Nome)"
    } else {
        Write-Host "Usuário já existe: $($usuario.Nome)"
    }
}

# 3. Mapeamento dos Grupos: Sinapses da Rede Neural
$grupos = @{
    "GCompras"     = @("Carlos", "Antonio")
    "GRH"          = @("Maria")
    "GInformatica" = @("Felipe", "Andre", "Lucio")
}
# Cada grupo é como um receptor específico da rede, conectando os nós (usuários)
# conforme as necessidades de cada departamento ou função.

# 4. Associação de Usuários aos Grupos: Sincronização Neural
foreach ($grupo in $grupos.Keys) {
    # Verifica se o grupo já existe; se não, cria o grupo
    if (-not (Get-LocalGroup -Name $grupo)) {
        New-LocalGroup -Name $grupo
        Write-Host "Grupo criado: $grupo"
    }
    
    # Adiciona cada usuário definido para o grupo sem verificar se já está associado
    foreach ($usuario in $grupos[$grupo]) {
        Add-LocalGroupMember -Group $grupo -Member $usuario -ErrorAction SilentlyContinue
        Write-Host "Usuário $usuario adicionado ao grupo $grupo"
    }
}


```
{% endcode %}
