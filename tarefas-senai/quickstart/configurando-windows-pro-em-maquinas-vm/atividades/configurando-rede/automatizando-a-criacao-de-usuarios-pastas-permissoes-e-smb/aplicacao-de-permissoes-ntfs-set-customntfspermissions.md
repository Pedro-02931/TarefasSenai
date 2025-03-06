# Aplicação de Permissões NTFS: Set-CustomNTFSPermissions

O sistema de arquivos NTFS (New Technology File System) permite a configuração detalhada de permissões em nível de pasta e arquivo através de alocação de blocos e metadados.&#x20;

Essas permissões são aplicadas diretamente aos blocos do sistema de arquivos de acordo com o espaço de alocação do sistema formatados, o que permite um controle preciso sobre quem pode acessar, modificar ou visualizar cada recurso.&#x20;

Usei a função `Set-CustomNTFSPermissions` automatiza essa tarefa utilizando o utilitário **icacls e tabelas**, garantindo que as permissões sejam atribuídas corretamente a cada pasta criada anteriormente.

#### **Permissões Definidas:**

Bom, segui como a atividade orientou: Cada pasta tem um conjunto específico de permissões:

* **Pasta "publica":** Controle total para o administrador, leitura e gravação para usuários comuns e apenas leitura para restritos e convidados.
* **Pasta "trabalho":** Controle total para o administrador e leitura/gravação para usuários comuns.
* **Pasta "documentos":** Apenas leitura e gravação para usuários comuns.
* **Pasta "confidencial":** Acesso exclusivo ao administrador.
* **Pasta "convidados":** Controle total para o administrador e leitura para usuários convidados.

```powershell
# Define as permissões para cada pasta em uma hash table
$permissions = @{
    "C:\publica" = @(
        "Terra:(OI)(CI)F",
        "Vênus:(OI)(CI)M",
        "Marte:(OI)(CI)M",
        "Júpiter:(OI)(CI)R",
        "Saturno:(OI)(CI)R",
        "Netuno:(OI)(CI)R",
        "Urano:(OI)(CI)R"
    )
    "C:\trabalho" = @(
        "Terra:(OI)(CI)F",
        "Vênus:(OI)(CI)M",
        "Marte:(OI)(CI)M"
    )
    "C:\documentos" = @(
        "Vênus:(OI)(CI)M",
        "Marte:(OI)(CI)M"
    )
    "C:\confidencial" = @(
        "Terra:(OI)(CI)F"
    )
    "C:\convidados" = @(
        "Terra:(OI)(CI)F",
        "Netuno:(OI)(CI)R",
        "Urano:(OI)(CI)R"
    )
}

# Aplica as permissões utilizando o icacls
foreach ($path in $permissions.Keys) {
    icacls $path /reset
    foreach ($permission in $permissions[$path]) {
        icacls $path /grant:r $permission
        Write-Output "Permissão aplicada: $permission em $path"
    }
}
```

#### **Análise Detalhada:**

* O comando `icacls $path /reset` redefine as permissões do diretório, removendo heranças ou permissões pré-existentes que poderiam interferir no novo modelo de controle de acesso.
* Cada permissão é aplicada através do comando `icacls $path /grant:r $permission`, onde `:r` indica que as permissões anteriores serão substituídas pelas novas.
* **Parâmetros de Permissão:**
  * `(OI)` (Object Inherit): Permissões aplicáveis a arquivos dentro da pasta.
  * `(CI)` (Container Inherit): Permissões aplicáveis a subpastas dentro da pasta.
  * `(IO)` (Inherit Only): Aplicável apenas aos objetos filhos, não ao próprio diretório.
  * **F** (Full control): Controle total, incluindo gerenciamento de permissões.
  * **M** (Modify): Permissão de leitura, gravação e modificação de arquivos.
  * **R** (Read): Somente leitura, impedindo qualquer alteração no conteúdo.
