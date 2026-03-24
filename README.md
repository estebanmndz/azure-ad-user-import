### 🧾 README.md

```md
# Importación de Usuarios a Entra ID (Azure AD)

Crea usuarios automáticamente leyendo un CSV.

## Ejecución
```powershell
Connect-MgGraph -Scopes User.ReadWrite.All
./import-users.ps1
