# Scripts

{% code overflow="wrap" %}
```powershell
<# 
    Script: Configure-FolderPermissions.ps1
    Description: Automatiza a criação de pastas e a configuração de permissões NTFS
    utilizando hash tables para melhor estrutura e manutenção.
#>

# Definição das pastas e permissões em uma hash table
$folders = @{
    "C:\Compras" = @{
        "inheritance" = "r"
        "permissions" = @(
            @{ group = "GCompras"; access = "M" } # Modify (Leitura e Gravação)
            @{ group = "GRH"; access = "R" }      # Read (Somente leitura)
            @{ group = "GInformatica"; access = "R" } # Read (Somente leitura)
        )
    }
    "C:\RH" = @{
        "inheritance" = "r"
        "permissions" = @(
            @{ group = "GRH"; access = "M" } # Modify (Leitura e Gravação)
            @{ group = "GCompras"; access = "M" } # Modify (Leitura e Gravação)
        )
        "denies" = @(
            @{ group = "GInformatica"; access = "F" } # Full Control negado
        )
    }
    "C:\Informatica" = @{
        "inheritance" = "r"
        "permissions" = @(
            @{ group = "GInformatica"; access = "M" } # Modify (Leitura e Gravação)
        )
        "denies" = @(
            @{ group = "GRH"; access = "F" } # Full Control negado
            @{ group = "GCompras"; access = "F" } # Full Control negado
        )
    }
}

# Função para garantir que as pastas existem
function Ensure-Folder {
    param([string]$FolderPath)
    
    if (-not (Test-Path -Path $FolderPath)) {
        Write-Host "Pasta '$FolderPath' não encontrada. Criando..."
        New-Item -Path $FolderPath -ItemType Directory | Out-Null
    }
}

# Função para aplicar permissões NTFS com base na hash table
function Set-FolderPermissions {
    param([string]$FolderPath, [hashtable]$Config)

    Write-Host "Configurando permissões na pasta '$FolderPath'..."

    # Remove a herança para evitar permissões pré-existentes conflitantes
    icacls $FolderPath /inheritance:$($Config.inheritance)

    # Aplica permissões concedidas
    if ($Config.ContainsKey("permissions")) {
        foreach ($perm in $Config.permissions) {
            icacls $FolderPath /grant "$($perm.group):(OI)(CI)$($perm.access)"
        }
    }

    # Aplica permissões negadas, se houver
    if ($Config.ContainsKey("denies")) {
        foreach ($deny in $Config.denies) {
            icacls $FolderPath /deny "$($deny.group):(OI)(CI)$($deny.access)"
        }
    }
}

# Itera sobre as pastas definidas na hash table e aplica as configurações
foreach ($folder in $folders.Keys) {
    Ensure-Folder -FolderPath $folder
    Set-FolderPermissions -FolderPath $folder -Config $folders[$folder]
}

Write-Host "Configuração de permissões concluída."

```
{% endcode %}
