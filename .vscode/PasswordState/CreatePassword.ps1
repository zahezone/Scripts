$SecretID = "RsNZu9qd6tp1YmyAEziW"
$SecretKey = "e0APsDLU21B3QohvIdfESqcFGuTVOZ"

$PasswordListID = 2093


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
    PasswordListID = $PasswordListID
    Title = "Testing Title"
    Username = "username"
    Password = "asdasdads"
    Description = "Desc"
    URL = "https://asd"
  }

  $NewPass = Invoke-RestMethod -Uri "$MRAPPURL/passwordstate/password" -Headers $Header -Method POST -ContentType "application/json" -Body $($PassBody | ConvertTo-Json)