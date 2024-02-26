# Import System.Web assembly
Add-Type -AssemblyName System.Web
# Generate random password
[System.Web.Security.Membership]::GeneratePassword(15,6)