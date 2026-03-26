param(
    [Parameter(Mandatory=$true)]
    [string]$CsvPath
)

# =========================
# CONFIG
# =========================
$logFile = "import.log"

function Log {
    param([string]$message)

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "$timestamp - $message"

    Write-Host $entry
    $entry | Out-File -FilePath $logFile -Append
}

# =========================
# VALIDACIÓN CSV
# =========================
if (!(Test-Path $CsvPath)) {
    Log "❌ CSV no encontrado: $CsvPath"
    exit
}

# =========================
# CONEXIÓN A GRAPH
# =========================
Log "🔐 Conectando a Microsoft Graph..."
try {
    Connect-MgGraph -Scopes "User.ReadWrite.All" -ErrorAction Stop
} catch {
    Log "❌ Error conectando a Microsoft Graph"
    Log $_
    exit
}

# =========================
# IMPORTAR CSV
# =========================
$users = Import-Csv $CsvPath

if (-not $users) {
    Log "⚠️ CSV vacío o sin datos"
    exit
}

Log "📥 Usuarios cargados: $($users.Count)"

# =========================
# PROCESAMIENTO
# =========================
foreach ($u in $users) {

    # Validación de campos
    if (-not $u.DisplayName -or -not $u.UserPrincipalName -or -not $u.Password) {
        Log "⚠️ Datos incompletos. Usuario omitido."
        continue
    }

    try {
        # Comprobar si existe
        $existingUser = Get-MgUser -Filter "userPrincipalName eq '$($u.UserPrincipalName)'" -ErrorAction SilentlyContinue

        if ($existingUser) {
            Log "⚠️ Usuario ya existe: $($u.UserPrincipalName)"
            continue
        }

        # Crear usuario
        New-MgUser -AccountEnabled $true `
            -DisplayName $u.DisplayName `
            -UserPrincipalName $u.UserPrincipalName `
            -PasswordProfile @{
                Password = $u.Password
                ForceChangePasswordNextSignIn = $true
            } `
            -MailNickname ($u.UserPrincipalName.Split("@")[0])

        Log "✅ Usuario creado: $($u.UserPrincipalName)"

    } catch {
        Log "❌ Error creando usuario: $($u.UserPrincipalName)"
        Log $_
    }
}

Log "🎯 Proceso de importación finalizado"
