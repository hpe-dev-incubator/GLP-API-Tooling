Param($MailXL)

if ($Null -eq $MailXL)
{
    if ($env:MAILXL -eq $NULL)
    {
        $MailXL = read-host "Enter name of the Excel file" 
    }
}

if ($Env:CLIENTID -eq $null) {
    $ClientID = read-host "Enter your HPE GreenLake Client ID" 
}
else {
    $ClientID = $Env:CLIENTID 
}

if ($Env:CLIENTSECRET -eq $null) {
    $secClientSecret = read-host  "Enter your HPE GreenLake Client Secret" -AsSecureString
}
else {
    $secClientSecret = $Env:CLIENTSECRET | ConvertTo-SecureString -AsPlainText -force
}

$bstr               = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secClientSecret)
$ClientSecret       = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr) 
$headers            = @{} 

$body               = "grant_type=client_credentials&client_id=" + $ClientID + "&client_secret=" + $ClientSecret

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
$headers                    = @{} 
$headers["Authorization"]   = "Bearer $AccessToken"
$headers["Accept"]          = "application/json"
$headers["Content-Type"]    = "application/json"




# --------------------- Invite users
if ($MAILXL)
{
    $excel  =   import-excel -path $MAILXL -dataonly    
    $invited = 0
    foreach ($_m in $excel )
    {
        if ($_m.email.Contains('@'))
        {
            $_body = @{
                "email"             = $_m.email
                "sendWelcomeEmail"  = $true
            }
            $Body   = $_body | ConvertTo-Json
            try {
                $response = Invoke-webrequest "https://global.api.greenlake.hpe.com/identity/v1/users" -Method POST -Headers $headers -Body $Body
                $invited++
            }
            catch {
                Write-Host "Error sending invite !" 
                exit
            }                
        }
    }
}
else 
{
    write-host 'Mailing list file not provided nor found....'
}

# ------------------------ Query GL to get list of users
try {
    $response = Invoke-webrequest "https://global.api.greenlake.hpe.com/identity/v1/users?filter=&limit=300&offset=0" -Method GET -Headers $headers
}
catch {
    Write-Host "Cannot get list of users!!" 
    exit
}

Write-Host $invited " users invited"
Write-Host "List of users in workspace:"

$_list                     = $response.Content | ConvertFrom-Json
if ($null -ne $_list)
{
    $_users_list        =  [System.Collections.ArrayList]::new()

    foreach ($_u in $_list.Items)
    {

          $_users_list        += @{
              'Username'      = $_u.Username
              'Status'        = $_u.userStatus
              'id'            = $_u.Id
                }
        }
    
}

$_users_list | select Username, Status | ft -AutoSize

