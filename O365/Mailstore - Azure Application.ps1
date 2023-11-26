

$adAppAccess = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
    ResourceAppId  = "00000003-0000-0000-c000-000000000000";
    ResourceAccess =
    [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
        Id   = "7ab1d382-f21e-4acd-a863-ba3e13f7da61";
        Type = "Role"
    },
    [Microsoft.Open.AzureAD.Model.ResourceAccess]@{ 
        Id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d";
        Type = "Scope"
    }
    
}

$Office365ExchangeOnlineAppAccess = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
    ResourceAppId  = "00000002-0000-0ff1-ce00-000000000000";
    ResourceAccess =
    [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
        Id   = "dc890d15-9560-4a4c-9b7f-a736ec74ec40";
        Type = "Role"
    }
}

<#$partnerCenterAppAccess = [Microsoft.Open.AzureAD.Model.RequiredResourceAccess]@{
    ResourceAppId  = "fa3d9a0c-3fb0-42cc-9193-47c7ecd2edbd";
    ResourceAccess =
    [Microsoft.Open.AzureAD.Model.ResourceAccess]@{
        Id   = "1cebfa2a-fb4d-419e-b5f9-839b4383e05a";
        Type = "Scope"
    }
}#>

$SessionInfo = Get-AzureADCurrentSessionInfo

Write-Host -ForegroundColor Green "Creating the Azure AD application and related resources..."

New-AzureADApplication -AvailableToOtherTenants $true -DisplayName "mail2me Demo 10" -RequiredResourceAccess $adAppAccess, $Office365ExchangeOnlineAppAccess #, $partnerCenterAppAccess -ReplyUrls @("urn:ietf:wg:oauth:2.0:oob","https://localhost","http://localhost")





$cer = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 #create a new certificate object
$cer.Import("C:\Temp\Test.cer") 
$bin = $cer.GetRawCertData()
$base64Value = [System.Convert]::ToBase64String($bin)
$bin = $cer.GetCertHash()
$base64Thumbprint = [System.Convert]::ToBase64String($bin)
$keyid = [System.Guid]::NewGuid().ToString() 
New-AzureADApplicationKeyCredential -ObjectId "3f2acc32-7661-473d-bde9-4390d1b6daba" -CustomKeyIdentifier $base64Thumbprint -Type AsymmetricX509Cert -Usage Verify -Value $base64Value

New-AzureADApplicationPasswordCredential -ObjectId "3f2acc32-7661-473d-bde9-4390d1b6daba"