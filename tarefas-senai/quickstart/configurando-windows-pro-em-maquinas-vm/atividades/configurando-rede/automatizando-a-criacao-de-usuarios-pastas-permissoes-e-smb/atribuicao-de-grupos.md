# Atribuição de grupos

Bom, aparentemente o Windows, quando eu crio usuários no PowerShell, por default, não atrela a um grupo padrão, então para completar a atividade só usei um laço de interação para atrelar ao grupo "Usuários"

```
# Lista de usuários a serem atribuídos ao grupo "Usuários"
$users = @("Terra", "Vênus", "Marte", "Júpiter", "Saturno", "Netuno", "Urano")

# Itera sobre cada usuário e adiciona ao grupo "Usuários"
foreach ($user in $users) {
    Add-LocalGroupMember -Group "Usuários" -Member $user -ErrorAction SilentlyContinue
    Write-Host "Usuário $user adicionado ao grupo 'Usuários'."
}

```
