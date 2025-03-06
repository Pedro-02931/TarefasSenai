# Validação da Conectividade SMB: Restart-SMBServiceAndTestConnectivity

Após configurar os compartilhamentos SMB, é fundamental garantir que o serviço **LanmanServer** (responsável pelo SMB) esteja operando corretamente. Além disso, a conectividade na porta **445** precisa ser testada para validar o acesso remoto aos compartilhamentos.

```powershell
function Restart-SMBServiceAndTestConnectivity {
    Restart-Service -Name "LanmanServer"
    Test-NetConnection -ComputerName localhost -Port 445
}
```

* O `Restart-Service` reinicia o serviço **LanmanServer**, aplicando todas as novas configurações de compartilhamento e permissões.
* O `Test-NetConnection` valida a conectividade na porta **445**, essencial para o funcionamento do SMB. Se o teste falhar, pode indicar problemas no firewall ou nas permissões de rede.
