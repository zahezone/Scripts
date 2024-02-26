function ConnectToTennant {
    param (
        [Parameter (Mandatory = $true)] [String]$TenantID
    )
    
    $ApplicationId         = '128860ea-76fa-4a64-a570-5bb12acfe05a'
    $ApplicationSecret     = 'CpGpZfmczL8we5szeg/CyvH4lKg3YMCI+HlFoWJRV8A=' | Convertto-SecureString -AsPlainText -Force
    #$TenantID              = '85881429-e6fd-450e-aee4-f1e6a24aa384'
    $RefreshToken          = '0.AUEALDIlvn-Ew0agmRsDZX7xNupgiBL6dmRKpXBbsSrP4FpBAHU.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P9DA8JMCG_-t_RmOsJfmL1Tds7h8wEOEIFro-n9s83pqbyjWr4X2g7BedBtx1rjXhe9VlaSTR7QbdsOl8TYAboMFkC5idP5d4tOFo7TS8Ha57xf_gv09YaQrsObbcYXSzBzg_-M_M1M6yaVWVTINVwA8FU-N45HQ_XLW2Fhm-PIvoSZzb3_OoVEwrDb73jb-ysUcBHJW85UfiZIvqjX8REgAVUJyQiIxFxOAoJTmFFSFNGc74-8cGV7YH0BIAIR6vU2H1LdbwDRbrnBF_EP83ffTU8ZxTF8dGPbj71xw86rs3Pq2wQz6w2v49mxb8p5-T9ysJODXZiL5HWyUDVmOSyhWajtN4aww6bgacazssqS_cYePzRTfbU1usfgrxkt2jyAWlOFf9vxH5nFX6yyT1U496rb7VYgch19kHsz-usx4T_XYVacTNHbzIL71MNhgq7nI6UVN4XErTaaV1VX3qF74dIlmB4vod6Oi1nO5PEIlxBoOCaVLRpoPTXuEwmaaTH4vbkU-VpnP4QhU3eAznPcLS6buw2vrxWx_f8zXCZyFAzKioE_zWSKTT0ca0V9qnQQU3_SjS8uhntftZPzvUbqM2Qrw7S_cL96AQrGoB2nFqKhL5zS9Abl28xx-3ramXdCf9mXAyxUWSy1cYg6Q43cEu3Dcvvwe-ApxtX__76At5MgMCWGxq8g0hUdPqZyiLqLxnwPFwuONFqSuvHqryRndg_qxNmGJ1XaxOZRV7r5Q3W6P8hT2BC90X6znr-ENn_yF131CijhoRnBVP65_ANn9BaS3xd2VN5dq_hdxp7-7GkzO3F7fDZQ_nQI_26JEiPQhY_aCseReYNlP7Ig8pbpH77jmJmR'
    $ExchangeRefreshToken  = '0.AUEALDIlvn-Ew0agmRsDZX7xNhY8x6Djp2RFmpUr30c4NxZBAHU.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P8r4FjMcpnaSMt86xcC8heLeCtlDLKiC9GNPuleLW0dhyj3dWaocPLb6-l2VGL9FaUxCeVzg3ACYYuixfiiB3MBq9lDfKm6BuW6pwnQlTrLEjMMslFh5O2awb3V7M3C240O3hIv-cCcr2MEfdue0__GlSO4G-P_haPvGBQAoJnO7pi3xIV6IAREztuAcRFHnVURAGvG-lP8P0TDS5xqXCmlDI5U9pmYaEdYko8SFY8dLUUronG0KXTJ9XorT2Yx8048u1iKgl_TmIesKGcbulGnsZx6T07KEzaZV9Aq_JZw8cSXg0otIvttgiW3OFKiJIAeBNkZb_9qx710Oc1VkQFA7Ixw0BWzQBX74E35uIg65H6jpgOuFe2q_GQYzB7TI_Pe-s7o33KEw9pBb-yeSyw8E9DP-Pmb2ZgHjw7eybjtd8ht-JEUzq-MtoeYfkFjSIDRIhmOjE9uehLsx1SiAGaWbh2ZjkwWfVcOOya93nKYgPH09A4OgGxd4oKvoUWxwouzrVl6dmBUm_WXsXnFnVk5hBIS1cyes2S57pCn-Wbmg80rJ-HvFndDe_NjrBkcADubMajP-tohuJg3xpp1hhFRcP62PIaz6j9KwyaZOyFTN99mdzDI8mX5MLQV_3K6qmtqfOZ4upqsWbjOFA38b9ugYIegwKdNhCD5DgFTEcMhtZJMLKqrnxo3f5UjVCEj5RSdbqK22RySdRhag2oza3VV179291q7A9CAOhAFWg8W1s_axIo3MvdmraQ9T5rQGf9rXzDxOy9pXORdatY5r87Mz65dxd-q-_Nqwp2trb2gkCu0BLPATIv2LC3LbiVLDcU64P1L7Q6QutA'
    $credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)

    $aadGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.windows.net/.default' -ServicePrincipal -Tenant $tenantID
    $graphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes 'https://graph.microsoft.com/.default' -ServicePrincipal -Tenant $tenantID

    Connect-AzureAD -AadAccessToken $aadGraphToken.AccessToken -AccountId 'admin.sholzberger@ip2me.com.auget' -MsAccessToken $graphToken.AccessToken -TenantId $tenantID

    # https://www.cyberdrain.com/connect-to-exchange-online-automated-when-mfa-is-enabled-using-the-secureapp-model/  
}

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

function SecurityDefaults {
    param (
        [Parameter (Mandatory = $true)] [String]$defaultDomainName
    )
    ######### Secrets #########
    $ApplicationId = '128860ea-76fa-4a64-a570-5bb12acfe05a'
    $ApplicationSecret = 'CpGpZfmczL8we5szeg/CyvH4lKg3YMCI+HlFoWJRV8A=' | ConvertTo-SecureString -Force -AsPlainText
    $RefreshToken = '0.AUEALDIlvn-Ew0agmRsDZX7xNupgiBL6dmRKpXBbsSrP4FpBAHU.AgABAAEAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P9DA8JMCG_-t_RmOsJfmL1Tds7h8wEOEIFro-n9s83pqbyjWr4X2g7BedBtx1rjXhe9VlaSTR7QbdsOl8TYAboMFkC5idP5d4tOFo7TS8Ha57xf_gv09YaQrsObbcYXSzBzg_-M_M1M6yaVWVTINVwA8FU-N45HQ_XLW2Fhm-PIvoSZzb3_OoVEwrDb73jb-ysUcBHJW85UfiZIvqjX8REgAVUJyQiIxFxOAoJTmFFSFNGc74-8cGV7YH0BIAIR6vU2H1LdbwDRbrnBF_EP83ffTU8ZxTF8dGPbj71xw86rs3Pq2wQz6w2v49mxb8p5-T9ysJODXZiL5HWyUDVmOSyhWajtN4aww6bgacazssqS_cYePzRTfbU1usfgrxkt2jyAWlOFf9vxH5nFX6yyT1U496rb7VYgch19kHsz-usx4T_XYVacTNHbzIL71MNhgq7nI6UVN4XErTaaV1VX3qF74dIlmB4vod6Oi1nO5PEIlxBoOCaVLRpoPTXuEwmaaTH4vbkU-VpnP4QhU3eAznPcLS6buw2vrxWx_f8zXCZyFAzKioE_zWSKTT0ca0V9qnQQU3_SjS8uhntftZPzvUbqM2Qrw7S_cL96AQrGoB2nFqKhL5zS9Abl28xx-3ramXdCf9mXAyxUWSy1cYg6Q43cEu3Dcvvwe-ApxtX__76At5MgMCWGxq8g0hUdPqZyiLqLxnwPFwuONFqSuvHqryRndg_qxNmGJ1XaxOZRV7r5Q3W6P8hT2BC90X6znr-ENn_yF131CijhoRnBVP65_ANn9BaS3xd2VN5dq_hdxp7-7GkzO3F7fDZQ_nQI_26JEiPQhY_aCseReYNlP7Ig8pbpH77jmJmR'
    ######### Secrets #########
    $CustomerTenant = $defaultDomainName
    ########################## Script Settings  ############################
    $Baseuri = "https://graph.microsoft.com/beta"
    #write-host "Generating token to log into Azure AD." -ForegroundColor Green
    $credential = New-Object System.Management.Automation.PSCredential($ApplicationId, $ApplicationSecret)
    $CustGraphToken = New-PartnerAccessToken -ApplicationId $ApplicationId -Credential $credential -RefreshToken $refreshToken -Scopes "https://graph.microsoft.com/.default" -ServicePrincipal -Tenant $CustomerTenant
    $Header = @{
        Authorization = "Bearer $($CustGraphToken.AccessToken)"
    }

    $body = '{ "isEnabled": false }'
        (Invoke-RestMethod -Uri "$baseuri/policies/identitySecurityDefaultsEnforcementPolicy" -Headers $Header -Method patch -Body $body -ContentType "application/json")

    $SecureDefaultsState = (Invoke-RestMethod -Uri "$baseuri/policies/identitySecurityDefaultsEnforcementPolicy" -Headers $Header -Method get -ContentType "application/json")

    if ($SecureDefaultsState.IsEnabled -eq $true) {
        write-host "Secure Defaults are enabled for $CustomerTenant. Disabling now..."-ForegroundColor Yello
        $body = '{ "isEnabled": false }'
        (Invoke-RestMethod -Uri "$baseuri/policies/identitySecurityDefaultsEnforcementPolicy" -Headers $Header -Method patch -Body $body -ContentType "application/json")
    }
    else {
        write-host "Secure Defaults is disabled for $CustomerTenant Taking no action.." -ForegroundColor Green
        
    }

}
# This script will connect to all delegated Office 365 tenants and check whether the Unified Audit Log is enabled. If it's not, it will create an Exchange admin user with a standard password. Once it's processed, you'll need to wait a few hours (preferably a day), then run the second script. The second script connects to your customers' Office 365 tenants via the new admin users and enables the Unified Audit Log ingestion. If successful, the second script will also remove the admin users created in this script. #&amp;gt;
 
#-------------------------------------------------------------
 
# Here are some things you can modify:
 
# This is your partner admin user name that has delegated administration permission
 
$UserName = "admin.sholzberger@ip2me.com.au"
 
# IMPORTANT: This is the default password for the temporary admin users. Don't leave this as Password123, create a strong password between 8 and 16 characters containing Lowercase letters, Uppercase letters, Numbers and Symbols.
 
$NewAdminPassword = "Password123"
 
# IMPORTANT: This is the default User Principal Name prefix for the temporary admin users. Don't leave this as gcitsauditadmin, create something UNIQUE that DOESNT EXIST in any of your tenants already. If it exists, it'll be turned into an admin and then deleted.
 
$NewAdminUserPrefix = "rbc.supportadmin"
 
# This is the path for the exported CSVs. You can change this, though you'll need to make sure the path exists. This location is also referenced in the second script, so I recommend keeping it the same.
 
$CreatedAdminsCsv = "C:\temp\CreatedAdmins.csv"
 
$UALCustomersCsv = "C:\temp\UALCustomerStatus.csv"
 
# Here's the end of the things you can modify.
 
#-------------------------------------------------------------
 
# This script block gets the Audit Log config settings
 
$ScriptBlock = {Get-AdminAuditLogConfig}
 
$Cred = get-credential -Credential $UserName
 
# Connect to Azure Active Directory via Powershell
 
Connect-MsolService -Credential $cred
 
$Customers = Get-MsolPartnerContract -All
 
$CompanyInfo = Get-MsolCompanyInformation 
 
Write-Host "Found $($Customers.Count) customers for $($CompanyInfo.DisplayName)"
 
Write-Host " "
Write-Host "----------------------------------------------------------"
Write-Host " "
 
foreach ($Customer in $Customers) {
 
    Write-Host $Customer.Name.ToUpper()
    Write-Host " "
 
    # Get license report
 
    #Write-Host "Getting license report:"
 
    $CustomerLicenses = Get-MsolAccountSku -TenantId $Customer.TenantId
 
    foreach($CustomerLicense in $CustomerLicenses) {
 
        #Write-Host "$($Customer.Name) is reporting $($CustomerLicense.SkuPartNumber) with $($CustomerLicense.ActiveUnits) Active Units. They've assigned $($CustomerLicense.ConsumedUnits) of them."
 
    }
 
    if($CustomerLicenses.Count -gt 0){
 
        #Write-Host " "
 
        # Get the initial domain for the customer.
 
        $InitialDomain = Get-MsolDomain -TenantId $Customer.TenantId | Where-Object {$_.IsInitial -eq $true}
 
        # Construct the Exchange Online URL with the DelegatedOrg parameter.
 
        #$DelegatedOrgURL = "https://ps.outlook.com/powershell-liveid?DelegatedOrg=" + $InitialDomain.Name
 
        #Write-Host "Getting UAL setting for $($InitialDomain.Name)"
 
        # Invoke-Command establishes a Windows PowerShell session based on the URL,
        # runs the command, and closes the Windows PowerShell session.
 
        #$AuditLogConfig = Invoke-Command -ConnectionUri $DelegatedOrgURL -Credential $Cred -Authentication Basic -ConfigurationName Microsoft.Exchange -AllowRedirection -ScriptBlock $ScriptBlock -HideComputerName
 
 
        # If the Unified Audit Log isn't enabled, log the status and create the admin user.
 
        
 
            #$UALDisabledCustomers += $Customer
 
            #$UALCustomersExport =@()
 
            <#$UALCustomerExport = @{
 
                TenantId = $Customer.TenantId
                CompanyName = $Customer.Name
                DefaultDomainName = $Customer.DefaultDomainName
                UnifiedAuditLogIngestionEnabled = $AuditLogConfig.UnifiedAuditLogIngestionEnabled
                UnifiedAuditLogFirstOptInDate = $AuditLogConfig.UnifiedAuditLogFirstOptInDate
                DistinguishedName = $AuditLogConfig.DistinguishedName
            } #>
 
            #$UALCustomersExport += New-Object psobject -Property $UALCustomerExport
            #$UALCustomersExport | Select-Object TenantId,CompanyName,DefaultDomainName,UnifiedAuditLogIngestionEnabled,UnifiedAuditLogFirstOptInDate,DistinguishedName | Export-Csv -notypeinformation -Path $UALCustomersCSV -Append
 
            # Build the User Principal Name for the new admin user
 
            $NewAdminUPN = -join($NewAdminUserPrefix,"@",$($InitialDomain.Name))
 
            Write-Host " "
            Write-Host "Creating RBC Support Admin for $($Customer.Name). Creating a user with UPN: $NewAdminUPN ..."
            #Write-Host "Adding $($Customer.Name) to CSV to enable UAL in second script."
            
            $NewAdminPassword = [System.Web.Security.Membership]::GeneratePassword(20,6)
            $secpasswd = ConvertTo-SecureString $NewAdminPassword -AsPlainText -Force
            $NewAdminCreds = New-Object System.Management.Automation.PSCredential ($NewAdminUPN, $secpasswd)

            if (Get-MsolUser -TenantID $Customer.TenantID  -UserPrincipalName $NewAdminUPN){
                Write-Host "The user $NewAdminUPN already exists.  Resetting password..."
                Set-MsolUserPassword -TenantID $Customer.TenantID -UserPrincipalName $NewAdminUPN -NewPassword $NewAdminPassword -ForceChangePassword $false
            } else {
                New-MsolUser -TenantId $Customer.TenantId -DisplayName "RBC Support Admin" -UserPrincipalName $NewAdminUPN -Password $secpasswd -ForceChangePassword $false 
            }

            Write-Host " Checking Security Permissions..."
            try {
                Add-MsolRoleMember -TenantId $Customer.TenantId -RoleName "Exchange Recipient Administrator" -RoleMemberEmailAddress $NewAdminUPN
                Add-MsolRoleMember -TenantId $Customer.TenantId -RoleName "Global Reader" -RoleMemberEmailAddress $NewAdminUPN
            }
            catch {
                Write-Host "  $NewAdminUPN is already part of the required security groups..."
            }
            finally {
                $Error.Clear()
            }
            
            Write-Host "  Setting MFA Properties..."
            $mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
            $mf.RelyingParty = "*"
            $mfa = @($mf)

            $m1 = New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationMethod
            $m1.IsDefault = $true
            $m1.MethodType="OneWaySMS"
            Set-MsolUser -TenantId $Customer.TenantId -UserPrincipalName $NewAdminUPN -AlternateEmailAddresses "ip2me@rbcgroup.com.au" -MobilePhone "+61447782853" -StrongAuthenticationRequirements $mfa -StrongAuthenticationMethods $m1

            #Write-Host "Connecting to $($Customer.Name)"
            
            Connect-MgGraph -TenantId $Customer.TenantId -Scopes UserAuthenticationMethod.ReadWrite.All, User.Read.All
            Select-MgProfile -Name beta

            $policyID = (Get-MgUserAuthenticationPhoneMethod -userid $NewAdminUPN).Id
            Update-MgUserAuthenticationPhoneMethod -userid $NewAdminUPN -PhoneAuthenticationMethodId $policyID -phoneType "mobile" -phoneNumber +61447782853
            #New-MgUserAuthenticationPhoneMethod -UserId $NewAdminUPN -phoneType "mobile" -phoneNumber +61447782853
            Disconnect-MgGraph

            Write-Host "  Saving Password to PasswordState..."
            PasswordToPasswordState -PWListID 2093 -UserName $NewAdminUPN -Passwd $NewAdminPassword -Title "$($Customer.Name) O365 Credentials"

            SecurityDefaults -defaultDomainName $($InitialDomain.Name)

            Write-Host "Setting up conditional access policies..."
            ConnectToTennant -TenantID $Customer.TenantId
            
            $CurrentPolicies = Get-AzureADMSConditionalAccessPolicy
            $CurrentPolicies.DisplayName

            foreach ($policy in $CurrentPolicies) {
               #Write-Host "Removing Existing Policy $policy.Name"
               Remove-AzureADMSConditionalAccessPolicy -PolicyId $policy.PolicyId 
            }

            $ClientIP = '14.202.89.166/32'

            #$ClientIP = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.IpRange]
            #New-AzureADMSNamedLocationPolicy -OdataType “#microsoft.graph.ipNamedLocation” -DisplayName "Client Office IP" -IsTrusted $True -IpRanges $ClientIP


            $ipRanges = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.IpRange]
            $ipRanges.Add('103.66.220.0/24')
            $ipRanges.Add('103.106.144.0/24')
            New-AzureADMSNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "ip2me APNIC Range" -IsTrusted $True -IpRanges $ipRanges

            $otherTrustedIPs  = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.IpRange]
            $otherTrustedIPs.Add('14.202.89.166/32')
            New-AzureADMSNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "Other Trusted IP's" -IsTrusted $True -IpRanges $otherTrustedIPs

            #$ClientOffice = Get-AzureADMSNamedLocationPolicy | Where-Object {$_.DisplayName -eq "Client Office IP"}
            #$APNIC = Get-AzureADMSNamedLocationPolicy | Where-Object {$_.DisplayName -eq "ip2me APNIC Range"}

            $Roles 

            #CA Conditions
            $CAConditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
            $CAConditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
            $CAConditions.Applications.IncludeApplications = "All"
            $CAConditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
            $CAConditions.Users.IncludeRoles = "62e90394-69f5-4237-9190-012177145e10","194ae4cb-b126-40b2-bd5b-6091b380977d","f28a1f50-f6e7-4571-818b-6a12f2af6b6c","29232cdf-9323-42fd-ade2-1d097af3e4de","b1be1c3e-b65d-4f19-8427-f6fa0d97feb9","729827e3-9c14-49f7-bb1b-9608f156bbb8","b0f54661-2d74-4c50-afa3-1ec803f12efe","fe930be7-5e62-47db-91af-98c3a49a38b1","c4e39bd9-1100-46d3-8c65-fb160da0071f","9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3","158c047a-c907-4556-b7ef-446551a6b5f7","966707d0-3269-4727-9be2-8c3a10f19b9d","7be44c8a-adaf-4e2a-84d6-ab2649e08a13","e8611ab8-c189-46e8-94e1-60213ab1f814"
            $CAConditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
            $CAConditions.Locations.IncludeLocations = "All"
            $CAConditions.Locations.ExcludeLocations = "AllTrusted"

            #CA Controls
            $CAControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
            $CAControls._Operator = "OR"
            $CAControls.BuiltInControls = "Mfa"

            New-AzureADMSConditionalAccessPolicy -DisplayName "MFA for Admin Access" -State "Enabled" -Conditions $CAConditions -GrantControls $CAControls

            Write-Host "Polices enabled..."
 
            <#$AdminProperties = @{
                TenantId = $Customer.TenantId
                CompanyName = $Customer.Name
                DefaultDomainName = $Customer.DefaultDomainName
                UserPrincipalName = $NewAdminUPN
                Action = "ADDED"
            }
 
            $CreatedAdmins = @()
            $CreatedAdmins += New-Object psobject -Property $AdminProperties
 
            $CreatedAdmins | Select-Object TenantId,CompanyName,DefaultDomainName,UserPrincipalName,Action | Export-Csv -notypeinformation -Path $CreatedAdminsCsv -Append
 
            Write-Host " " #>
            
 
        
 
    }
 
Write-Host " "
Write-Host "----------------------------------------------------------"
Write-Host " "
 
}
 
Write-Host "Admin Creation Completed for tenants without Unified Audit Logging, please wait 12 hours before running the second script."
 
Write-Host " "