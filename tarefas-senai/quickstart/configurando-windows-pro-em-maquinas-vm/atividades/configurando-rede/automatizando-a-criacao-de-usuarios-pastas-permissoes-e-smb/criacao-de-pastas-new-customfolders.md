# Criação de Pastas: New-CustomFolders

Bom, automatizei a criação de pastas no diretório `C:` seguindo o conceito: Cada pasta criada representa um nó dentro da rede de permissões que será configurada posteriormente, garantindo que cada usuário tenha o acesso adequado conforme as políticas estabelecidas.

#### **Pastas Criadas:**

* **C:\publica:** Acesso amplo, leitura e gravação para a maioria dos usuários.
* **C:\trabalho:** Espaço colaborativo para usuários comuns e administradores.
* **C:\documentos:** Repositório de documentos para usuários comuns.
* **C:\confidencial:** Acesso restrito apenas ao administrador.
* **C:\convidados:** Pastas específicas para usuários convidados, com permissões limitadas.

```powershell
# Define as pastas como chaves em uma hash table
$folders = @{
    "C:\publica"      = $true
    "C:\trabalho"     = $true
    "C:\documentos"   = $true
    "C:\confidencial" = $true
    "C:\convidados"   = $true
}

# Cria as pastas se não existirem
foreach ($path in $folders.Keys) {
    if (-not (Test-Path -Path $path)) {
        New-Item -Path $path -ItemType Directory
        Write-Output "Diretório criado: $path"
    } else {
        Write-Output "Diretório já existe: $path"
    }
}
```

#### **Análise Técnica:**

* **O `Test-Path`** valida a existência do diretório antes de tentar criá-lo.
* **Estrutura de Dados via Hash Table:** dado que sou preguiçoso, adicionei novas pastas através da tabela `$folders` com o uso de laços de repetição.&#x20;
