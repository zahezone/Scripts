Write-Host "Checking for MSGraph module..."

$Module = Get-Module -Name "Microsoft.Graph.Identity.DirectoryManagement" -ListAvailable

if ($Module -eq $null) {
    
        Write-Host "MSGraph module not found, installing MSGraph"
        Install-Module -name Microsoft.Graph.Identity.DirectoryManagement
    
    }
Connect-MgGraph -Scopes "Directory.Read.All","Domain.Read.All","Domain.ReadWrite.All","Directory.AccessAsUser.All"
#Enter the Admin credentials from "Become a tenant Admin in GoDaddy"
 
Get-MgDomain
#See that the domain is “federated”#

Update-MgDomain -DomainId "carabergmannproperties.au" -Authentication Managed