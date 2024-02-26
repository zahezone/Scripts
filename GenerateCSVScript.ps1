# Define the data to be written to the CSV file
$csvData = @"
ServicePrincipalName,RoleName
Microsoft.Graph,User.Read
Microsoft.Graph,Group.Read.All
Microsoft.Graph,Mail.Read
"@

# Specify the path where you want to save the CSV file
$csvFilePath = "C:\Temp\example.csv"

# Write the data to the CSV file
$csvData | Out-File -FilePath $csvFilePath -Force -Encoding UTF8

Write-Host "CSV file created at: $csvFilePath"
