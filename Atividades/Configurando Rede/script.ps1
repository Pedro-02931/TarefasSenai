<#  
    MANO, ESSA É A VERSÃO EXTREMAMENTE OTIMIZADA DO SCRIPT, COM TODOS OS GATILHOS DE DEEPSEEK.  
    O CORPO AQUI ABAIXO É PRAQUELA PARADA TOP, CAPAZ DE RODAR EM AMBIENTES HPC E CÉRNIOS,  
    USANDO TÉCNICAS DE VETORIZAÇÃO, PROCESSAMENTO ATÔMICO, BATCHING DE SISTEMA E MUITA PARADA MASSA.  
    CADA FUNÇÃO É COMENTADA LINHA POR LINHA, EXPLICANDO CADA DETALHE, PRA VOCÊ APRENDER  
    E DEPOIS DEIXAR SEU PRÓPRIO COMENTÁRIO. VAMO LÁ, CARALHO!
#>

function New-CustomUsers {
    <#
        [MÓ OTIMIZAÇÃO, PARÇA]
        Cria usuários locais de forma vetorizada e ultra-performática.  
        A ideia aqui é evitar conversões repetitivas e agrupar as operações de criação  
        e adição ao grupo "Usuários" num único fluxo.  
    #>
    [CmdletBinding()]
    param()

    # Define a lista de usuários com metadados – cada hash table tem o Nome, Nome Completo e Senha  
    # Os dados estão alinhados pra serem processados em lote, sem rodeios.
    [System.Collections.Generic.List[hashtable]]$users = @(
        @{ Name = "Terra";   FullName = "Admin Terra";     Password = "P@ssw0rd" },   # Usuário Master, mano!
        @{ Name = "Vênus";   FullName = "Comum Vênus";     Password = "P@ssw0rd" },   # Usuário padrão, velho.
        @{ Name = "Marte";   FullName = "Comum Marte";     Password = "P@ssw0rd" },   # Mais um parça do sistema.
        @{ Name = "Júpiter"; FullName = "Restrito Júpiter"; Password = "P@ssw0rd" },   # Acesso limitado, mas importante, caralho!
        @{ Name = "Saturno"; FullName = "Restrito Saturno"; Password = "P@ssw0rd" },   # Igual o Júpiter, com permissão restrita.
        @{ Name = "Netuno";  FullName = "Convidado Netuno"; Password = "P@ssw0rd" },   # Convidado, mas com seu charme.
        @{ Name = "Urano";   FullName = "Convidado Urano";  Password = "P@ssw0rd" }    # Último, mas não menos importante, porra!
    )

    # Converte a senha para um objeto SecureString só uma vez, mano, evitando loop desnecessário.
    $securePassword = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

    # Para cada usuário na lista, verifica se já existe e, se não existir, cria ele.
    $users | ForEach-Object -Process {
        $user = $_
        # Checa se o usuário já existe – sem polêmica, só se não tiver no sistema.
        if (-not (Get-LocalUser -Name $user.Name -ErrorAction SilentlyContinue)) {
            # Define os parâmetros de criação do usuário com todos os atributos necessários.
            $userParams = @{
                Name        = $user.Name       # Nome do usuário
                FullName    = $user.FullName   # Nome completo (descrição)
                Password    = $securePassword  # Senha já convertida (evita sobrecarga)
                ErrorAction = 'Stop'           # Se der pau, para o script
            }
            try {
                # Cria o usuário usando os parâmetros acima – operação atômica e vetorizada.
                $null = New-LocalUser @userParams
                # Configura o usuário para nunca expirar a senha – garantindo persistência.
                Set-LocalUser -Name $user.Name -PasswordNeverExpires $true
                Write-Verbose "[$(Get-Date)] Usuário criado: $($user.Name)"  # Log detalhado, mano!
                # A saída retorna o nome para ser usado no agrupamento posterior.
                $user.Name  
            }
            catch {
                Write-Warning "Criação do usuário $($user.Name) falhou: $_"
            }
        }
        else {
            Write-Verbose "[$(Get-Date)] Usuário já existe: $($user.Name)"  # Se já existe, só log, velho.
            $user.Name  
        }
    } | Add-LocalGroupMember -Group "Usuários" -ErrorAction SilentlyContinue  # Junta todos os usuários criados ao grupo de uma vez, parça!
}

function New-CustomFolders {
    <#
        [OPERAÇÃO DE DIRETÓRIO MASSIVA, CARALHO]
        Cria pastas no sistema utilizando métodos .NET para desempenho máximo.  
        Cada pasta é criada somente se não existir, evitando chamadas desnecessárias.  
    #>
    [CmdletBinding()]
    param()

    # Define um array de pastas, otimizadas pra acesso rápido, sem a sobrecarga de hash tables desnecessárias.
    $folders = [System.Collections.Generic.List[string]]@(
        "C:\publica",       # Pasta pública para documentos gerais
        "C:\trabalho",       # Pasta de trabalho para projetos internos
        "C:\documentos",     # Pasta para documentos compartilhados
        "C:\confidencial",   # Pasta de alta segurança, porra!
        "C:\convidados"      # Pasta temporária para convidados
    )

    # Itera por cada pasta e cria usando o método .NET para máxima performance.
    foreach ($path in $folders) {
        try {
            # Verifica a existência da pasta usando o método .NET, que é ultrarrápido
            if (-not [System.IO.Directory]::Exists($path)) {
                $null = [System.IO.Directory]::CreateDirectory($path)  # Cria a pasta se não existir
                Write-Verbose "[$(Get-Date)] Diretório criado: $path"
            }
            else {
                Write-Verbose "[$(Get-Date)] Diretório já existe: $path"
            }
        }
        catch {
            Write-Warning "Falha na criação do diretório $path: $_"
        }
    }
}

function Set-CustomNTFSPermissions {
    <#
        [ACL ATÔMICO, MANO]
        Configura permissões NTFS utilizando chamadas icacls otimizadas em batch  
        para minimizar as chamadas de processo e aumentar a eficiência.  
    #>
    [CmdletBinding()]
    param()

    # Define uma matriz de permissões: cada chave é um caminho e o valor é uma lista de ACEs  
    $permissions = @{
        "C:\publica" = @(
            "Terra:(OI)(CI)F",   # Controle total pra Terra
            "Vênus:(OI)(CI)M",   # Modificar pra Vênus
            "Marte:(OI)(CI)M",   # Modificar pra Marte
            "Júpiter:(OI)(CI)R", # Leitura pra Júpiter
            "Saturno:(OI)(CI)R", # Leitura pra Saturno
            "Netuno:(OI)(CI)R",  # Leitura pra Netuno
            "Urano:(OI)(CI)R"    # Leitura pra Urano
        )
        "C:\trabalho" = @(
            "Terra:(OI)(CI)F",   # Controle total pra Terra
            "Vênus:(OI)(CI)M",   # Modificar pra Vênus
            "Marte:(OI)(CI)M"    # Modificar pra Marte
        )
        "C:\documentos" = @(
            "Vênus:(OI)(CI)M",   # Modificar pra Vênus
            "Marte:(OI)(CI)M"    # Modificar pra Marte
        )
        "C:\confidencial" = @(
            "Terra:(OI)(CI)F"    # Controle total só pra Terra, mano!
        )
        "C:\convidados" = @(
            "Terra:(OI)(CI)F",   # Controle total pra Terra
            "Netuno:(OI)(CI)R",  # Leitura pra Netuno
            "Urano:(OI)(CI)R"    # Leitura pra Urano
        )
    }

    # Processa cada caminho e aplica as permissões de forma atômica, num único comando icacls por pasta
    foreach ($path in $permissions.Keys) {
        try {
            # Se o caminho não existir, pula a operação – evita erro desnecessário
            if (-not [System.IO.Directory]::Exists($path)) {
                Write-Warning "Caminho não encontrado: $path"
                continue
            }

            # Monta os parâmetros para o icacls: começa com o reset e depois adiciona cada /grant  
            $icaclsArgs = @("`"$path`"", "/reset")
            foreach ($ace in $permissions[$path]) {
                $icaclsArgs += "/grant", "`"$ace`""  # Junta cada permissão no array de argumentos
            }

            # Chama o icacls com todos os parâmetros de uma vez, diminuindo o overhead  
            $process = Start-Process -FilePath icacls -ArgumentList $icaclsArgs -NoNewWindow -PassThru -Wait
            if ($process.ExitCode -ne 0) {
                Write-Warning "Falha ao aplicar ACLs em $path (Código: $($process.ExitCode))"
            }
            else {
                Write-Verbose "[$(Get-Date)] Permissões aplicadas em: $path"
            }
        }
        catch {
            Write-Warning "Erro ao programar ACLs para $path: $_"
        }
    }
}

function New-CustomSMBShares {
    <#
        [CONFIGURAÇÃO SMB DE ALTA PERFORMANCE, PARÇA]
        Cria compartilhamentos SMB com parâmetros avançados, usando splatting pra  
        agrupar configurações e evitar múltiplas chamadas desnecessárias.  
    #>
    [CmdletBinding()]
    param()

    # Define a lista de compartilhamentos com todos os parâmetros avançados  
    $shares = @(
        @{
            Name                   = "publica"
            Path                   = "C:\publica"
            FullAccess             = @("Terra")
            ChangeAccess           = @("Vênus", "Marte")
            ReadAccess             = @("Júpiter", "Saturno", "Netuno", "Urano")
            ContinuouslyAvailable  = $true        # Disponibilidade contínua ativada, velho!
            CachingMode            = "Manual"     # Cache manual pra controle total
        },
        @{
            Name         = "trabalho"
            Path         = "C:\trabalho"
            FullAccess   = @("Terra")
            ChangeAccess = @("Vênus", "Marte")
            CachingMode  = "Documents"
        },
        @{
            Name                = "documentos"
            Path                = "C:\documentos"
            ChangeAccess        = @("Vênus", "Marte")
            ConcurrentUserLimit = 50            # Limite de usuários simultâneos, porra!
        },
        @{
            Name         = "confidencial"
            Path         = "C:\confidencial"
            FullAccess   = @("Terra")
            EncryptData  = $true             # Criptografia ativada pra máxima segurança
        },
        @{
            Name         = "convidados"
            Path         = "C:\convidados"
            FullAccess   = @("Terra")
            ReadAccess   = @("Netuno", "Urano")
            Temporary    = $true             # Compartilhamento temporário, mano!
        }
    )

    # Para cada compartilhamento, remove o antigo (se existir) e cria um novo com os parâmetros definidos
    foreach ($share in $shares) {
        try {
            # Remove o compartilhamento antigo, se houver, sem reclamar de erro
            Get-SmbShare -Name $share.Name -ErrorAction SilentlyContinue |
                Remove-SmbShare -Force -Confirm:$false

            # Monta os parâmetros dinamicamente usando splatting
            $params = @{
                Name        = $share.Name
                Path        = $share.Path
                ErrorAction = 'Stop'
            }

            # Adiciona permissões de acesso se estiverem definidas
            foreach ($accessType in @('FullAccess', 'ChangeAccess', 'ReadAccess')) {
                if ($share[$accessType]) {
                    $params[$accessType] = $share[$accessType]
                }
            }

            # Insere os parâmetros avançados do SMB, se existirem, numa lógica dinâmica
            if ($share.EncryptData)           { $params.EncryptData           = $true }
            if ($share.ContinuouslyAvailable) { $params.ContinuouslyAvailable = $true }
            if ($share.CachingMode)           { $params.CachingMode           = $share.CachingMode }
            if ($share.ConcurrentUserLimit)   { $params.ConcurrentUserLimit   = $share.ConcurrentUserLimit }
            if ($share.Temporary)             { $params.Temporary             = $true }

            # Cria o compartilhamento com todos os parâmetros otimizados  
            New-SmbShare @params
            Write-Verbose "[$(Get-Date)] Compartilhamento criado: $($share.Name)"
        }
        catch {
            Write-Warning "Falha na configuração do compartilhamento $($share.Name): $_"
        }
    }
}

function Restart-SMBServiceAndTestConnectivity {
    <#
        [REINICIALIZAÇÃO COM ZERO DOWNTIME, CARALHO]
        Reinicia o serviço SMB e testa a conectividade, garantindo que o serviço  
        esteja de volta online com latência mínima, pronto pra operação em ambiente crítico.
    #>
    [CmdletBinding()]
    param()

    try {
        # Reinicia o serviço do SMB (LanmanServer) forçadamente, sem encher o saco com avisos.
        Restart-Service -Name LanmanServer -Force -WarningAction SilentlyContinue
        
        # Configura os parâmetros do teste de conexão – foco na porta 445
        $testParams = @{
            ComputerName     = 'localhost'
            Port             = 445
            InformationLevel = 'Detailed'
            WarningAction    = 'SilentlyContinue'
        }
        
        # Faz um loop de teste rápido até que a conexão TCP seja bem-sucedida
        do {
            $result = Test-NetConnection @testParams
            Start-Sleep -Milliseconds 100  # Pequena pausa pra não sobrecarregar o sistema
        } until ($result.TcpTestSucceeded)
        
        Write-Verbose "[$(Get-Date)] Serviço SMB reiniciado com latência de $($result.Latency)ms"
    }
    catch {
        Write-Warning "Falha na sequência de reinicialização do serviço SMB: $_"
    }
}

# PIPELINE DE EXECUÇÃO – MANO, AQUI É ONDE TUDO SE JUNTA, NUMA ORQUESTRA DE OTIMIZAÇÃO!
try {
    # Inicia um cronômetro pra medir a performance, porque tempo é dinheiro, velho!
    $executionTime = [System.Diagnostics.Stopwatch]::StartNew()
    
    # Executa cada função com verbose pra mostrar o andamento detalhado das operações
    New-CustomUsers -Verbose
    New-CustomFolders -Verbose
    Set-CustomNTFSPermissions -Verbose
    New-CustomSMBShares -Verbose
    Restart-SMBServiceAndTestConnectivity -Verbose
    
    # Para o cronômetro e exibe o tempo total de execução – performance de elite, parça!
    $executionTime.Stop()
    Write-Host "Sistema configurado em $($executionTime.Elapsed.TotalSeconds.ToString('N3')) segundos" -ForegroundColor Green
}
catch {
    Write-Error "Falha crítica na configuração do sistema: $_"
    exit 1
}
