
$user =  "admin@possibleinvestments.onmicrosoft.com" #Read-Host "Please provide username that will be used for migration..."


Connect-ExchangeOnline

Enable-OrganizationCustomization
Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -Automapping $false -User $user
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User $user


Connect-AzureAD

$app = New-AzureADMSApplication -DisplayName "RBC - MigrationWiz" -SignInAudience AzureADMultipleOrgs
$msalonly = 'msal'+$app.AppId+'://auth'
Set-AzureADMSApplication -ObjectId $app.Id -PublicClient @{RedirectUris = "urn:ietf:wg:oauth:2.0:oob"} -IsFallbackPublicClient $true 
Add-AzADAppPermission -ObjectId $app.Id -ApiId 00000002-0000-0ff1-ce00-000000000000 -PermissionId 3b5f3d61-589b-4a3c-a359-5dd4b5ee5bd5