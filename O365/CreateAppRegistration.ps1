<#param(
    [Parameter(Mandatory=$true)]
    [string]$AppName,

    [Parameter(Mandatory=$true)]
    [string]$CertificatePath,

    [Parameter(Mandatory=$true)]
    [string]$CsvFilePath
)#>

# Install and import the required module
#Install-Module -Name Az -AllowClobber -Force -Scope CurrentUser
#Import-Module Az

# Connect to Azure AD
#Connect-AzAccount

$AppName = "ScottTest7.zahezone.com.au"
$CertificatePath = "C:\Temp\SSL.Cer"
$CsvFilePath = "C:\Temp\example.csv"

# Create a new App Registration
$application = New-AzADApplication -DisplayName $AppName -IdentifierUris "$AppName"

# Upload SSL certificate to "Certificates & Secrets" section
#$certContent = Get-Content $CertificatePath -Raw
#$cert = New-AzADAppCredential -ApplicationId $application.ApplicationId -CertValue $certContent -StartDate (Get-Date) -EndDate (Get-Date).AddYears(1)

# Read API permissions from CSV and assign them
$apiPermissions = Import-Csv $CsvFilePath
foreach ($permission in $apiPermissions) {
    # Find the service principal for Microsoft Graph using its App ID
    $graphServicePrincipal = Get-AzADServicePrincipal -ApplicationId "00000003-0000-0000-c000-000000000000"  # Microsoft Graph's App ID

    # Check if the service principal is found
    if ($graphServicePrincipal) {
        # Assign the specified role to the service principal
        $apiRole = $graphServicePrincipal.AppRole | Where-Object { $_.Value -eq $permission.RoleName }
        if ($apiRole) {
            $appRoleId = $apiRole.Id
            New-AzureADServiceAppRoleAssignment -ObjectId $graphServicePrincipal.Id -PrincipalId $application.Id -ResourceId $graphServicePrincipal.Id -Id $apiRole.Id #New-AzureADServiceAppRoleAssignment -Id $appRoleId -PrincipalId $application.AppId -ResourceId $graphServicePrincipal.Id
        } else {
            Write-Host "Role '$($permission.RoleName)' not found for Microsoft Graph."
        }
    } else {
        Write-Host "Microsoft Graph service principal not found."
    }
}

# Grant Admin Consent for required permissions
Get-AzADServicePrincipal -ObjectId $application.ApplicationId | New-AzureADServiceAppRoleAssignment -RoleDefinitionId "00000000-0000-0000-0000-000000000000"

# Return values
Write-Output "Application (Client) ID: $($application.ApplicationId)"
Write-Output "Directory (Tenant) ID: $($application.DirectoryId)"