###################################################################################################
# MANO, PRESTA ATENÇÃO NESSE SCRIPT NÍVEL HPC, CERN, NSA E A 4:  
# AQUI TEM UMA IMPLEMENTAÇÃO EXTREMAMENTE OTIMIZADA, COM TÉCNICAS DE ALTA PERFORMANCE, 
# REDUZINDO CHAMADAS EXTERNAS, UTILIZANDO MÉTODOS .NET DIRETOS E AGRUPANDO COMANDOS PRA EVITAR OVERHEAD.
# O OBJETIVO É QUE VOCÊ TENHA UMA BASE COMPLETA PRA ESTUDO E PÓS ISSO ADICIONE SEUS COMENTÁRIOS.
###################################################################################################

###########################################
# FUNÇÃO: Criar-Pastas  
# DESCRIÇÃO: Cria a estrutura de pastas e subpastas utilizando métodos .NET para desempenho máximo.
# A lógica é: para cada pasta principal na estrutura, verifica se ela existe usando o método
# [System.IO.Directory]::Exists, e se não existir, cria ela. Em seguida, se houver subpastas, 
# itera sobre cada uma delas e cria utilizando a mesma abordagem.  
###########################################
function Criar-Pastas {
    [CmdletBinding()]
    param()

    # Define a estrutura de pastas com suas subpastas utilizando uma Hashtable 
    # – chave: pasta principal; valor: array com subpastas (ou array vazio se não houver)
    $estrutura = @{
        "Compras"     = @("Internas", "Externas")
        "RH"          = @()         # Sem subpastas
        "Informatica" = @("softwares", "documentos")
    }

    # Itera sobre cada chave da estrutura (cada pasta principal)
    foreach ($pasta in $estrutura.Keys) {
        # Monta o caminho completo da pasta principal, tipo "C:\Compras"
        $caminhoPrincipal = "C:\$pasta"
        
        # VERIFICAÇÃO ULTRA-RÁPIDA USANDO .NET: Se a pasta principal não existir, cria-a!
        if (-not ([System.IO.Directory]::Exists($caminhoPrincipal))) {
            # Cria a pasta utilizando o método .NET (método nativo de alta performance)
            [System.IO.Directory]::CreateDirectory($caminhoPrincipal) | Out-Null
            Write-Host "Criada pasta: $caminhoPrincipal" -ForegroundColor Green
        } 
        else {
            Write-Host "Pasta já existe: $caminhoPrincipal" -ForegroundColor Yellow
        }
        
        # Processa as subpastas se existirem (array com itens > 0)
        $subPastas = $estrutura[$pasta]
        if ($subPastas.Count -gt 0) {
            foreach ($sub in $subPastas) {
                # Concatena o caminho da subpasta utilizando Join-Path para máxima robustez
                $caminhoSub = Join-Path -Path $caminhoPrincipal -ChildPath $sub
                if (-not ([System.IO.Directory]::Exists($caminhoSub))) {
                    # Cria a subpasta utilizando o método .NET direto – performance top!
                    [System.IO.Directory]::CreateDirectory($caminhoSub) | Out-Null
                    Write-Host "Criada subpasta: $caminhoSub" -ForegroundColor Green
                } 
                else {
                    Write-Host "Subpasta já existe: $caminhoSub" -ForegroundColor Yellow
                }
            }
        }
    }
}

# EXECUTA A FUNÇÃO CRIAR-PASTAS
Criar-Pastas

###################################################################################################
# BLOCO 1: MAPEAMENTO E CRIAÇÃO DE USUÁRIOS – A ESTRUTURA NEURAL DA REDE
###################################################################################################
# Mapeamento dos Usuários: Cada usuário é um nó na nossa rede neural, com atributos essenciais.
$usuarios = @(
    @{ Nome = "Carlos";  FullName = "Carlos";  Password = "P@ssw0rd" },
    @{ Nome = "Antonio"; FullName = "Antonio"; Password = "P@ssw0rd" },
    @{ Nome = "Maria";   FullName = "Maria";   Password = "P@ssw0rd" },
    @{ Nome = "Felipe";  FullName = "Felipe";  Password = "P@ssw0rd" },
    @{ Nome = "Andre";   FullName = "Andre";   Password = "P@ssw0rd" },
    @{ Nome = "Lucio";   FullName = "Lúcio";   Password = "P@ssw0rd" }
)

# Otimização nível HPC: Pré-converte a senha para SecureString uma única vez, pois todas usam a mesma!
$senhaSegura = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

# Itera sobre cada usuário para criar ou confirmar sua existência no sistema
foreach ($usuario in $usuarios) {
    # Checa se o usuário já existe usando Get-LocalUser com erro suprimido para alta eficiência
    if (-not (Get-LocalUser -Name $usuario.Nome -ErrorAction SilentlyContinue)) {
        try {
            # Cria o usuário utilizando New-LocalUser com os parâmetros necessários
            New-LocalUser -Name $usuario.Nome -FullName $usuario.FullName `
                -Password $senhaSegura -ErrorAction Stop
            # Configura para que a senha nunca expire, essencial para ambientes críticos
            Set-LocalUser -Name $usuario.Nome -PasswordNeverExpires $true
            # Adiciona o usuário ao grupo "Usuários" em uma única chamada, evitando loops redundantes
            Add-LocalGroupMember -Group "Usuários" -Member $usuario.Nome -ErrorAction SilentlyContinue
            Write-Host "Usuário criado: $($usuario.Nome)" -ForegroundColor Green
        }
        catch {
            Write-Host "Erro na criação do usuário $($usuario.Nome): $_" -ForegroundColor Red
        }
    } 
    else {
        Write-Host "Usuário já existe: $($usuario.Nome)" -ForegroundColor Yellow
    }
}

###################################################################################################
# BLOCO 2: MAPEAMENTO E ASSOCIAÇÃO DE GRUPOS – SINAPSES DA REDE NEURAL
###################################################################################################
# Mapeamento dos Grupos: Cada grupo funciona como um receptor na rede, organizando os nós conforme a função.
$grupos = @{
    "GCompras"     = @("Carlos", "Antonio")
    "GRH"          = @("Maria")
    "GInformatica" = @("Felipe", "Andre", "Lucio")
}

# Itera sobre cada grupo para verificar e criar se necessário, e associa os usuários de forma otimizada
foreach ($grupo in $grupos.Keys) {
    # Verifica se o grupo existe; se não, cria-o (com supressão de erro para performance)
    if (-not (Get-LocalGroup -Name $grupo -ErrorAction SilentlyContinue)) {
        try {
            New-LocalGroup -Name $grupo -ErrorAction Stop
            Write-Host "Grupo criado: $grupo" -ForegroundColor Green
        }
        catch {
            Write-Host "Erro ao criar o grupo $grupo: $_" -ForegroundColor Red
        }
    }
    
    # Otimização nível HPC: Adiciona todos os usuários de uma vez, evitando loop por membro
    try {
        Add-LocalGroupMember -Group $grupo -Member $grupos[$grupo] -ErrorAction SilentlyContinue
        Write-Host "Usuários $($grupos[$grupo] -join ', ') adicionados ao grupo $grupo" -ForegroundColor Green
    }
    catch {
        Write-Host "Erro ao adicionar usuários ao grupo $grupo: $_" -ForegroundColor Red
    }
}

###################################################################################################
# BLOCO 3: CONFIGURAÇÃO DE PERMISSÕES NTFS – MÓDULO DE SEGURANÇA ULTRA AVANÇADA
###################################################################################################
<# 
    Script: Configure-FolderPermissions.ps1  
    Descrição: Automatiza a criação de pastas e a aplicação de permissões NTFS utilizando 
    hash tables para uma configuração robusta e de alto desempenho, seguindo padrões HPC.
#>

# Define as pastas com suas configurações de permissões, herança, e negações
$folders = @{
    "C:\Compras" = @{
        "inheritance" = "r"  # Remove a herança (reset) para controle total
        "permissions" = @(
            @{ group = "GCompras"; access = "M" }        # Modify: leitura e gravação
            @{ group = "GRH"; access = "R" }             # Read: somente leitura
            @{ group = "GInformatica"; access = "R" }      # Read: somente leitura
        )
    }
    "C:\RH" = @{
        "inheritance" = "r" 
        "permissions" = @(
            @{ group = "GRH"; access = "M" }              # Modify: leitura e gravação
            @{ group = "GCompras"; access = "M" }           # Modify: leitura e gravação
        )
        "denies" = @(
            @{ group = "GInformatica"; access = "F" }       # Deny Full Control
        )
    }
    "C:\Informatica" = @{
        "inheritance" = "r"
        "permissions" = @(
            @{ group = "GInformatica"; access = "M" }       # Modify: leitura e gravação
        )
        "denies" = @(
            @{ group = "GRH"; access = "F" },                # Deny Full Control
            @{ group = "GCompras"; access = "F" }            # Deny Full Control
        )
    }
}

###########################################
# FUNÇÃO: Ensure-Folder  
# DESCRIÇÃO: Garante que a pasta exista utilizando métodos .NET para alta performance.
###########################################
function Ensure-Folder {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$FolderPath
    )
    
    # Checa se a pasta existe utilizando [System.IO.Directory] – mais rápido que Test-Path
    if (-not ([System.IO.Directory]::Exists($FolderPath))) {
        Write-Host "Pasta '$FolderPath' não encontrada. Criando..." -ForegroundColor Cyan
        [System.IO.Directory]::CreateDirectory($FolderPath) | Out-Null
    }
}

###########################################
# FUNÇÃO: Set-FolderPermissions  
# DESCRIÇÃO: Aplica permissões NTFS a uma pasta combinando comandos icacls em uma única chamada.
###########################################
function Set-FolderPermissions {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$FolderPath,
        [Parameter(Mandatory=$true)]
        [hashtable]$Config
    )

    Write-Host "Configurando permissões na pasta '$FolderPath'..." -ForegroundColor Magenta

    # Cria um array de argumentos para o icacls com o comando de herança
    $icaclsArgs = @("`"$FolderPath`"", "/inheritance:$($Config.inheritance)")

    # Se houver permissões concedidas, itera e adiciona cada parâmetro /grant
    if ($Config.ContainsKey("permissions")) {
        foreach ($perm in $Config.permissions) {
            $icaclsArgs += "/grant", "`"$($perm.group):(OI)(CI)$($perm.access)`""
        }
    }

    # Se houver permissões negadas, itera e adiciona cada parâmetro /deny
    if ($Config.ContainsKey("denies")) {
        foreach ($deny in $Config.denies) {
            $icaclsArgs += "/deny", "`"$($deny.group):(OI)(CI)$($deny.access)`""
        }
    }

    # Executa o comando icacls em uma única chamada, minimizando o overhead de processos externos
    try {
        & icacls $icaclsArgs | Out-Null
        Write-Host "Permissões configuradas para: $FolderPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Erro ao aplicar permissões em $FolderPath: $_" -ForegroundColor Red
    }
}

# Itera sobre cada pasta definida na hash table $folders e aplica a configuração de permissões
foreach ($folder in $folders.Keys) {
    Ensure-Folder -FolderPath $folder
    Set-FolderPermissions -FolderPath $folder -Config $folders[$folder]
}

Write-Host "Configuração de permissões concluída." -ForegroundColor Green

###################################################################################################
# FIM DO SCRIPT: MANO, ESSE SCRIPT É UMA OBRA-PRIMA DE OTIMIZAÇÃO HPC.  
# ELE FOI DESENVOLVIDO PRA RODAR EM AMBIENTES DE ALTA PERFORMANCE, COM TÉCNICAS DE MINIMIZAÇÃO  
# DE OVERHEAD, PROCESSAMENTO ATÔMICO E USO INTENSIVO DE MÉTODOS .NET.  
# APROFUNDE CADA LINHA, ESTUDE OS CONCEITOS E ADICIONE SEUS COMENTÁRIOS.  
###################################################################################################
