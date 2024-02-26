param(
    [string]$ClientId,
    [string]$ClientSecret,
    [string]$TenantId,
    [string]$EnterpriseAppId,
    [string]$CertificatePath
)

# Function to authenticate with Azure AD and get access token
function Get-AccessToken {
    param (
        [string]$ClientId,
        [string]$ClientSecret,
        [string]$TenantId
    )

    $tokenEndpoint = "https://login.microsoftonline.com/$TenantId/oauth2/token"
    
    $body = @{
        grant_type    = "client_credentials"
        client_id     = $ClientId
        client_secret = $ClientSecret
        resource      = "https://graph.microsoft.com"
    }

    $response = Invoke-RestMethod -Uri $tokenEndpoint -Method POST -Body $body

    return $response.access_token
}

# Function to connect to an Enterprise App and upload certificate
function Connect-And-UploadCertificate {
    param (
        [string]$ClientId,
        [string]$ClientSecret,
        [string]$TenantId,
        [string]$EnterpriseAppId,
        [string]$CertificatePath
    )

    $accessToken = Get-AccessToken -ClientId $ClientId -ClientSecret $ClientSecret -TenantId $TenantId

    # Connect to Enterprise App
    $enterpriseApp = Get-MgGraphApplication -ApplicationId $EnterpriseAppId -AccessToken $accessToken

    # Upload certificate
    $certData = Get-Content -Path $CertificatePath -Raw
    Set-MgGraphApplication -ApplicationId $EnterpriseAppId -PublicKeyCertificate $certData -AccessToken $accessToken

    Write-Output "Certificate uploaded successfully for Enterprise App with ID: $EnterpriseAppId"
}

# Example usage
#Connect-And-UploadCertificate -ClientId "YourClientId" -ClientSecret "YourClientSecret" -TenantId "YourTenantId" -EnterpriseAppId "YourEnterpriseAppId" -CertificatePath "Path\to\YourCertificate.cer"
