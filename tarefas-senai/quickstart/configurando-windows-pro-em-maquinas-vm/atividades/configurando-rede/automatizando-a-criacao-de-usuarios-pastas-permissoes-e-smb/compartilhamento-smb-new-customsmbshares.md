# Compartilhamento SMB: New-CustomSMBShares

O protocolo **SMB (Server Message Block)** é amplamente utilizado para compartilhamento de arquivos e pastas em redes Windows. No caso automatizei a criação de compartilhamentos SMB garante que os usuários remotos possam acessar os recursos conforme as permissões definidas anteriormente. Fiz de forma modular seguindo as regras da atividade.

### **Lógica de Compartilhamento:**

Cada compartilhamento é definido com um nome, caminho e permissões específicas de acesso. A função `Remove-ExistingSMBShare` é chamada antes de criar um novo compartilhamento, garantindo que não haja conflitos de nome ou permissões. ~~Isso me deu uma dor de cabeça rsrsrs~~

{% code overflow="wrap" %}
```powershell
function Remove-ExistingSMBShare {
    param (
        [string]$ShareName
    )
    # O Get-SmbShare verifica se o compartilhamento já existe, evitando exceções desnecessárias.
    if (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue) {
        Remove-SmbShare -Name $ShareName -Force
        Write-Output "Compartilhamento removido: $ShareName"
    }
}
```
{% endcode %}

***

#### **Criação dos Compartilhamentos:**

```powershell
function New-CustomSMBShares {
    $shares = @(
        @{ Name = "publica";     Path = "C:\publica";     FullAccess = @("Terra"); ChangeAccess = @("Vênus","Marte"); ReadAccess = @("Júpiter","Saturno","Netuno","Urano") },
        @{ Name = "trabalho";    Path = "C:\trabalho";    FullAccess = @("Terra"); ChangeAccess = @("Vênus","Marte"); ReadAccess = @() },
        @{ Name = "documentos";  Path = "C:\documentos";  FullAccess = @();       ChangeAccess = @("Vênus","Marte"); ReadAccess = @() },
        @{ Name = "confidencial";Path = "C:\confidencial";FullAccess = @("Terra"); ChangeAccess = @();               ReadAccess = @() },
        @{ Name = "convidados";  Path = "C:\convidados";  FullAccess = @("Terra"); ChangeAccess = @();               ReadAccess = @("Netuno","Urano") }
    )

    foreach ($share in $shares) {
        Remove-ExistingSMBShare -ShareName $share.Name
        New-SmbShare -Name $share.Name -Path $share.Path -FullAccess $share.FullAccess -ChangeAccess $share.ChangeAccess -ReadAccess $share.ReadAccess
        Write-Output "Compartilhamento criado: $($share.Name) em $($share.Path)"
    }
}
```

* Usando tabelas, o script pode ser facilmente ajustado para adicionar ou remover compartilhamentos sem a necessidade de alterar a lógica do código.
* &#x20;As permissões de `FullAccess`, `ChangeAccess` e `ReadAccess` são atribuídas diretamente via `New-SmbShare`, garantindo consistência entre as permissões NTFS e o acesso via rede.
* A função `Remove-ExistingSMBShare` é sempre chamada antes da criação do novo compartilhamento, eliminando riscos de conflito.
