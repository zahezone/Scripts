
$user =  "admin@NexusCarecomau.onmicrosoft.com" #Read-Host "Please provide username that will be used for migration..."

Enable-OrganizationCustomization
Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -Automapping $false -User $user
New-ManagementRoleAssignment -Role "ApplicationImpersonation" -User $user