# 👤 Azure AD User Import Automation (Microsoft Graph)

![Azure](https://img.shields.io/badge/Azure-Entra%20ID-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-Automation-black)
![IAM](https://img.shields.io/badge/IAM-Identity-green)

> 💡 Automate bulk user provisioning in Microsoft Entra ID using PowerShell with validation and duplicate checks

---

## 🧠 Overview

This project automates the creation of multiple users in Microsoft Entra ID (Azure AD) using a CSV file and PowerShell.

It includes validation, duplicate detection, and error handling to simulate real-world identity provisioning processes.

**Technologies used:**

* Microsoft Entra ID (Azure AD)
* Microsoft Graph PowerShell
* CSV data processing

---

## 🎯 Objective

The goal of this project is to:

* Automate user provisioning
* Reduce manual onboarding effort
* Ensure consistency and validation
* Avoid duplicate user creation

---

## 📂 Input Data (CSV)

The script reads user data from a CSV file with the following fields:

* DisplayName
* UserPrincipalName
* Password

---

## 🏗️ Execution Flow

```id="k0v2sf"
[CSV File]
        ↓
[Validate File]
        ↓
[Connect to Microsoft Graph]
        ↓
[Validate User Data]
        ↓
[Check Existing Users]
        ↓
[Create New Users]
        ↓
[Output Results]
```

---

## ⚙️ Key Features

* Bulk user creation
* CSV-based input
* Input validation
* Duplicate user detection
* Error handling with try/catch
* Uses Microsoft Graph (modern API)

---

## 🧩 How It Works

The script performs:

1. Validates CSV file existence
2. Connects to Microsoft Graph
3. Imports user data
4. Validates required fields
5. Checks if user already exists
6. Creates new users
7. Displays results

---

## 🔐 Security Considerations

* Requires permissions: `User.ReadWrite.All`
* Passwords are handled via CSV (not recommended for production)
* Recommended to use secure password generation or identity workflows

---

## 🌍 Real-World Use Case

This script can be used to:

* Onboard employees in bulk
* Migrate users into Entra ID
* Automate identity provisioning processes
* Support enterprise IAM workflows

---

## ▶️ Usage

```powershell id="2fl9si"
Connect-MgGraph -Scopes "User.ReadWrite.All"

.\import-users.ps1 -CsvPath "users.csv"
```

---

## 📊 Example Output

```id="m92vpk"
✅ Usuario creado: john.doe@company.com
⚠️ Usuario ya existe: jane.smith@company.com

Import completed
```

---

## 🚀 Future Improvements

* Logging to file
* Assign licenses automatically
* Add users to groups
* Secure password handling
* Integration with HR systems

---

## 📌 Key Takeaways

This project demonstrates:

* Identity and access management (IAM) automation
* Bulk operations in Microsoft Entra ID
* Use of Microsoft Graph API
* Real-world cloud onboarding practices

---
