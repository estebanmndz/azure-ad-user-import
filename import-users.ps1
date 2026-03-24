Import-Module Microsoft.Graph.Users

Connect-MgGraph -Scopes User.ReadWrite.All

$users = Import-Csv "users.csv"

foreach ($u in $users) {
    New-MgUser -AccountEnabled $true `
        -DisplayName $u.DisplayName `
        -UserPrincipalName $u.UserPrincipalName `
        -PasswordProfile @{ Password = $u.Password; ForceChangePasswordNextSignIn = $false }
}
