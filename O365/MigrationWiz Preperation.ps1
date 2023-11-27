
$user =  "admin@NexusCarecomau.onmicrosoft.com" #Read-Host "Please provide username that will be used for migration..."

Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -Automapping $false -User $user
Enable-OrganizationCustomization
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User $user