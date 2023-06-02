
#Required Modules

#Install-Module AzureAD
#Install-Module MSOnline
#Install-module Microsoft.Graph.Identity.Signins

Import-Module  AzureAD

Connect-AzureAD

$domain = "rbc.support@rbcgroupau.onmicrosoft.com"

$PasswordProfile=New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.ForceChangePasswordNextLogin = $false
$PasswordProfile.Password="3Rv0y1q39/chsy"
New-AzureADUser -DisplayName "RBC Support Admin" -GivenName "RBC Support" -SurName "Admin" -UserPrincipalName $domain -PasswordProfile $PasswordProfile -MailNickName rbc.support -AccountEnabled $true

Connect-MsolService

Set-AzureADUser -ObjectId $domain -OtherMails @("ip2me@rbcgroup.com.au") -Mobile "+61447782853" -TelephoneNumber "+61447782853" 
Add-MsolRoleMember -RoleMemberEmailAddress $domain -RoleName "Exchange Recipient Administrator"
Add-MsolRoleMember -RoleMemberEmailAddress $domain -RoleName "Global Reader"


    $mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $mf.RelyingParty = "*"
    $mfa = @($mf)
    Set-MsolUser -UserPrincipalName $domain -StrongAuthenticationRequirements $mfa

    $m1.IsDefault = $true
    $m1.MethodType="OneWaySMS"
  
set-msoluser -Userprincipalname rbc.support@rbcgroupau.onmicrosoft.com -StrongAuthenticationMethods $m1
New-MgUserAuthenticationPhoneMethod -UserId rbc.support@rbcgroupau.onmicrosoft.com -phoneType "mobile" -phoneNumber +61447782853
