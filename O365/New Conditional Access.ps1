#Connect-AzureAD
<#
$ClientIP = '14.202.89.166/32'

$ClientSubnet = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.IpRange]
New-AzureADMSNamedLocationPolicy -OdataType “#microsoft.graph.ipNamedLocation” -DisplayName "Client Office IP" -IsTrusted $True -IpRanges $ClientIP


$ipRanges = New-Object -TypeName System.Collections.Generic.List[Microsoft.Open.MSGraph.Model.IpRange]
$ipRanges.Add('103.66.220.0/24')
$ipRanges.Add('103.106.144.0/24')
New-AzureADMSNamedLocationPolicy -OdataType "#microsoft.graph.ipNamedLocation" -DisplayName "ip2me APNIC Range" -IsTrusted $True -IpRanges $ipRanges

#>

#$ClientOffice = Get-AzureADMSNamedLocationPolicy | Where-Object {$_.DisplayName -eq "Client Office IP"}
#$APNIC = Get-AzureADMSNamedLocationPolicy | Where-Object {$_.DisplayName -eq "ip2me APNIC Range"}

$Roles 

#CA Conditions
$CAConditions = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessConditionSet
$CAConditions.Applications = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessApplicationCondition
$CAConditions.Applications.IncludeApplications = "All"
$CAConditions.Users = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessUserCondition
$CAConditions.Users.IncludeRoles = "62e90394-69f5-4237-9190-012177145e10","194ae4cb-b126-40b2-bd5b-6091b380977d","f28a1f50-f6e7-4571-818b-6a12f2af6b6c","29232cdf-9323-42fd-ade2-1d097af3e4de","b1be1c3e-b65d-4f19-8427-f6fa0d97feb9","729827e3-9c14-49f7-bb1b-9608f156bbb8","b0f54661-2d74-4c50-afa3-1ec803f12efe","fe930be7-5e62-47db-91af-98c3a49a38b1","c4e39bd9-1100-46d3-8c65-fb160da0071f","9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3","158c047a-c907-4556-b7ef-446551a6b5f7","966707d0-3269-4727-9be2-8c3a10f19b9d","7be44c8a-adaf-4e2a-84d6-ab2649e08a13","e8611ab8-c189-46e8-94e1-60213ab1f814"
#$CAConditions.Users.IncludeUsers = "All Admins"
#$CAConditions.Users.ExcludeUsers = ‘22561a78-a72e-4d39-898d-cd7c57c84ca6’
$CAConditions.Locations = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessLocationCondition
$CAConditions.Locations.IncludeLocations = "All"
$CAConditions.Locations.ExcludeLocations = "AllTrusted"

#CA Controls
$CAControls = New-Object -TypeName Microsoft.Open.MSGraph.Model.ConditionalAccessGrantControls
$CAControls._Operator = "OR"
$CAControls.BuiltInControls = "Mfa"

New-AzureADMSConditionalAccessPolicy -DisplayName "CloudApps-MFA-CorpWide" -State "Disabled" -Conditions $CAConditions -GrantControls $CAControls

