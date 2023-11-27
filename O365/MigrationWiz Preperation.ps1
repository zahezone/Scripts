
$user = Read-Host "Please provide username that will be used for migration..."

Get-Mailbox -ResultSize Unlimited | Add-MailboxPermission -AccessRights FullAccess -Automapping $false -User admin@NexusCarecomau.onmicrosoft.com