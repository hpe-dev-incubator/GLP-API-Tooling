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

# Get a Token
$headers = @{} 
$headers["Content-Type"] = "application/x-www-form-urlencoded"

try {
    $response = Invoke-webrequest "https://sso.common.cloud.hpe.com/as/token.oauth2" -Method POST -Headers $headers -Body $body
}
catch {
    Write-Host "Error retrieving access token!" 
    exit
}



# Capturing API Access Token
$AccessToken = ($response.Content  | Convertfrom-Json).access_token

# Headers creation
$headers = @{} 
$headers["Authorization"] = "Bearer $AccessToken"
$headers["Accept"] = "application/json"

# Loop until CTRL-C or token expires (2 hours)
While ($true) {
    $d=((Get-Date).AddMinutes(-1)).ToUniversalTime()

    $sd=$d.tostring('yyyy-MM-ddTHH:mm:ss.00Z')
    write-host "Last check at (UTC): " $sd
    write-host "--------------------"

    # Fetch audit logs since last minute
    try {
        $response = Invoke-webrequest "https://global.api.greenlake.hpe.com/audit-log/v1beta1/logs?filter=createdAt%20ge%20'$sd'" -Method GET -Headers $headers 
    }
    catch {
        write-host "Error calling the API or token has expired!"
        exit
    }
 
    # Process json response 
    $my_json =$response | ConvertFrom-Json
    $my_items = $my_json.items

    $my_items_sorted = $my_items | Sort-Object -Property createdAt


    foreach ($i in $my_items_sorted){
        write-host "createdAt:" $i.createdAt
        write-host "username: " $i.user.username 
        write-host "description: " $i.description 
        write-host "ipAddress: " $i.additionalInfo.ipAddress
        write-host "--------------"
    }

    # Wait 1 minute and check again
    start-sleep -Seconds 60
}
