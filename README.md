# ✅ **4. azure-ad-user-import — README.md**

```md
# 👥 Azure AD Bulk User Import (PowerShell)

Este script importa usuarios en Azure AD (Entra ID) desde un archivo CSV,
ideal para automatizar altas masivas.

## ✅ Características

- Lectura de CSV
- Creación automática de usuarios
- Password inicial configurable
- Compatible con Microsoft Graph PowerShell

## 📁 Ejemplo CSV
DisplayName,UserPrincipalName,Password
Juan Perez,juan@empresa.com,P@ss1234!
Maria Lopez,maria@empresa.com,P@ss1234!

## ▶️ Ejecución

```powershell
Connect-MgGraph -Scopes User.ReadWrite.All
./import-users.ps1
