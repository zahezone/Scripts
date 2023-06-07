

function PasswordToPasswordState {
    param (
        [Parameter (Mandatory = $true)] [String]$PWListID,    
        [Parameter (Mandatory = $true)] [String]$UserName,
        [Parameter (Mandatory = $true)] [String]$Passwd,
        [Parameter (Mandatory = $true)] [String]$Title,
        [Parameter (Mandatory = $false)] [String]$Description,
        [Parameter (Mandatory = $false)] [String]$URL
    )
        $SecretID = "RsNZu9qd6tp1YmyAEziW"
        $SecretKey = "e0APsDLU21B3QohvIdfESqcFGuTVOZ"

        #$PasswordListID = 2093


        #Don't change below
        $MRAPPURL = "https://mrapprest.ip2me.com.au/api/v1"
        $AuthHeader = @{
            SecretID  = $SecretID
            SecretKey = $SecretKey
        }
        $Token = Invoke-RestMethod -Method Post -Uri "https://mrapprest.ip2me.com.au/v1/auth" -Body $($AuthHeader | ConvertTo-Json) -ContentType "application/json"

        $Header = @{
            Authorization = "Bearer $($Token.token)"
        }
        #You can change below
        $PassBody = @{
            PasswordListID = $PWListID
            Title = $Title
            Username = $UserName
            Password = $Passwd
            Description = $Description
            URL = $URL
        }

        $NewPass = Invoke-RestMethod -Uri "$MRAPPURL/passwordstate/password" -Headers $Header -Method POST -ContentType "application/json" -Body $($PassBody | ConvertTo-Json)
}

Import-Module  AzureAD

Connect-AzureAD

$NewAdminUserPrefix = "rbc.supportadmin"

$InitialDomain = Get-MsolDomain | Where-Object {$_.IsInitial -eq $true} 
$NewAdminUPN = -join($NewAdminUserPrefix,"@",$($InitialDomain.Name))

$PasswordProfile=New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.ForceChangePasswordNextLogin = $false
$PasswordProfile.Password= [System.Web.Security.Membership]::GeneratePassword(20,6)
New-AzureADUser -DisplayName "RBC Support Admin" -GivenName "RBC Support" -SurName "Admin" -UserPrincipalName $NewAdminUPN -PasswordProfile $PasswordProfile -MailNickName rbc.support -AccountEnabled $true 

Connect-MsolService

Set-AzureADUser -ObjectId $NewAdminUPN -OtherMails @("ip2me@rbcgroup.com.au") -Mobile "+61447782853" -TelephoneNumber "+61447782853" 
Add-MsolRoleMember -RoleMemberEmailAddress $NewAdminUPN -RoleName "Exchange Recipient Administrator"
Add-MsolRoleMember -RoleMemberEmailAddress $NewAdminUPN -RoleName "Global Reader"

Connect-MgGraph -Scopes UserAuthenticationMethod.ReadWrite.All, User.Read.All
Select-MgProfile -Name beta

    $mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $mf.RelyingParty = "*"
    $mfa = @($mf)
    Set-MsolUser -UserPrincipalName $domain -StrongAuthenticationRequirements $mfa

    $m1 = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
    $m1.IsDefault = $true
    $m1.MethodType="OneWaySMS"
  
set-msoluser -Userprincipalname $NewAdminUPN -StrongAuthenticationMethods $m1
New-MgUserAuthenticationPhoneMethod -UserId $NewAdminUPN -phoneType "mobile" -phoneNumber +61447782853

Write-Host "  Saving Password to PasswordState..."
$CompName = Get-MsolCompanyInformation

PasswordToPasswordState -PWListID 2093 -UserName $NewAdminUPN -Passwd $NewAdminPassword -Title "$CompName.DisplayName) O365 Credentials"