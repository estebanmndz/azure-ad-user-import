param(
    [Parameter(Mandatory=$true)]
    [string]$CsvPath
)

Import-Module Microsoft.Graph.Users

# Conexión a Microsoft Graph
Connect-MgGraph -Scopes User.ReadWrite.All

# Importar usuarios
if (!(Test-Path $CsvPath)) {
    Write-Host "❌ CSV no encontrado: $CsvPath"
    exit
}

$users = Import-Csv $CsvPath

foreach ($u in $users) {

    # Validación básica
    if (-not $u.DisplayName -or -not $u.UserPrincipalName -or -not $u.Password) {
        Write-Host "⚠️ Datos incompletos para un usuario. Saltando..."
        continue
    }

    try {
        # Comprobar si el usuario ya existe
        $existingUser = Get-MgUser -Filter "userPrincipalName eq '$($u.UserPrincipalName)'" -ErrorAction SilentlyContinue

        if ($existingUser) {
            Write-Host "⚠️ Usuario ya existe: $($u.UserPrincipalName)"
            continue
        }

        # Crear usuario
        New-MgUser -AccountEnabled $true `
            -DisplayName $u.DisplayName `
            -UserPrincipalName $u.UserPrincipalName `
            -PasswordProfile @{
                Password = $u.Password
                ForceChangePasswordNextSignIn = $true
            }

        Write-Host "✅ Usuario creado: $($u.UserPrincipalName)"

    } catch {
        Write-Host "❌ Error creando usuario: $($u.UserPrincipalName)"
        Write-Host $_
    }
}
