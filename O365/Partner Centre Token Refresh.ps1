$client_id = "0b44d725-6295-48b7-8ccf-869f7aa20d28"
$client_secret = "33955695-f1ba-4595-a1a7-36710ad10d69"
$tenant_id = "be25322c-847f-46c3-a099-1b03657ef136"
$secpasswd = ConvertTo-SecureString $client_secret -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ($client_id, $secpasswd)
 
$token = New-PartnerAccessToken -Credential $mycreds -Resource https://api.partnercenter.microsoft.com -TenantId $tenant_id
$refreshToken = $token.RefreshToken
$refreshToken | out-file C:\temp\refreshToken.txt