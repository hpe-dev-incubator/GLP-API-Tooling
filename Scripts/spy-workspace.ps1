if ($Env:CLIENTID -eq $null) {
    $ClientID = read-host "Enter your HPE GreenLake Client ID" 
}
else {
    $ClientID = $Env:CLIENTID 
}

if ($Env:CLIENTSECRET -eq $null) {
    $secClientSecret = read-host  "Enter your HPE GreenLake Client Secret" -AsSecureString
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secClientSecret)
    $ClientSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr) 
}
else {
    $ClientSecret = $Env:CLIENTSECRET
}

$headers = @{} 

$body = "grant_type=client_credentials&client_id=" + $ClientID + "&client_secret=" + $ClientSecret

While ($true) {

    # Get a Token
    $headers = @{} 
    $headers["Content-Type"] = "application/x-www-form-urlencoded"
    $response = Invoke-webrequest "https://sso.common.cloud.hpe.com/as/token.oauth2" -Method POST -Headers $headers -Body $body

    # Capturing API Access Token
    $AccessToken = ($response.Content  | Convertfrom-Json).access_token

    # Headers creation
    $headers = @{} 
    $headers["Authorization"] = "Bearer $AccessToken"
    $headers["Accept"] = "application/json"

    $d=((Get-Date).AddMinutes(-1)).ToUniversalTime()

    $sd=$d.tostring('yyyy-MM-ddTHH:mm:ss.00Z')
    write-host "Last check at (UTC): " $sd
    write-host "--------------------"

    # Fetch audit logs since last minute
    $response = Invoke-webrequest "https://global.api.greenlake.hpe.com/audit-log/v1beta1/search?filter=startTime%20eq%20'$sd'" -Method GET -Headers $headers 
    $my_json=$response | ConvertFrom-Json

    foreach ($i in $my_json.items){
        write-host "auditCreatedAt:" $i.auditCreatedAt
        write-host "username: " $i.username 
        write-host "description: " $i.description 
        write-host "ipAddress: " $i.additionalInfo.ipAddress
        write-host "--------------"
    }

    # Wait 1 minute and check again
    start-sleep -Seconds 60
}