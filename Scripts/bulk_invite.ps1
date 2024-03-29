# Step 1 - Reading the parameter from the command line.  
Param($XLFile)

if ($Null -eq $XLFile)
{
    if ($env:XLFile -eq $Null)
    {
        $XLFile = read-host "Enter name of the Excel file" 
    }
}

# Step 2 – Importing data from the 2 sheets of my spreadsheet.
$tokens =@{}
$invited=@{}

if ($XLFile)
{
    $users_excel  =   import-excel -path $XLFile -dataonly -worksheetname Users
    $workspaces_excel = Import-Excel -path $XLFile -dataonly -worksheetname Workspaces  

    # Step 3 – Iterating over the Workspaces sheet to collect client secrets, and retrieve access tokens
    foreach ($workspace in $workspaces_excel ) {   
        $client_id = $workspace.'Client Id'    
        if ($tokens[$client_id] -eq $null) {
            # We don't have a token for this client_id yet
            # We need to ask the Client secret for this workspace
            $workspace_name = $workspace.'Workspace Name'
            $client_id = $workspace.'Client Id'

            $secClientSecret = read-host  "Enter HPE GreenLake Client Secret for Workspace $workspace_name" -AsSecureString
            $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secClientSecret)
            $secret = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
                        
            # use Client Id and Client Secret to retrieve a token
            $body = "grant_type=client_credentials&client_id=" + $client_id + "&client_secret=" + $secret
            $headers = @{} 
            $headers["Content-Type"] = "application/x-www-form-urlencoded"
            
            try {
                $response = Invoke-webrequest "https://sso.common.cloud.hpe.com/as/token.oauth2" -Method POST -Headers $headers -Body $body
                # store the token for future use
                $AccessToken = ($response.Content  | Convertfrom-Json).access_token
                $tokens.Add($client_id,$AccessToken)
            }
            catch {
                Write-Host "Error retrieving access token for workspace $workspace_name!" -ForegroundColor Red 
                exit
            }
        }
    }
    # Step 4 – Iterating over Users sheet to invite each of them.
    $invited.Add($client_id,0)
    foreach ($user in $users_excel ) {
        $workspace_name = $user.'Workspace Name'
        # Get client id from workspace name
        $result = $workspaces_excel | Where-Object { $_.'Workspace Name'  -eq $workspace_name }
        if ($result.Count -eq 0)
        {
            Write-Host "Workspace not found for user " $user.email -ForegroundColor Red
            exit
        }
        $client_id = $result[0].'Client Id'
        
        Write-Host "Inviting user" $user.email "to workspace " $workspace_name
        $AccessToken = $tokens[$client_id]

        # Create header for next API calls 
        $headers = @{} 
        $headers["Authorization"] = "Bearer $AccessToken"
        $headers["Accept"] = "application/json"
        $headers["Content-Type"] = "application/json"
        
        # Build body for next API call         
        $_body = @{
            "email"             = $user.email
            "sendWelcomeEmail"  = $true
        }
        
        $Body = $_body | ConvertTo-Json
        
        # Call GLP API to invite user
        try {
            $response = Invoke-webrequest -Uri "https://global.api.greenlake.hpe.com/identity/v1/users" -Method POST -Headers $headers -Body $Body
            $invited[$client_id]++
        }
        catch {
            Write-Host "Error sending invite for" $user.Email"! Already onboarded?"  -ForegroundColor Red
            Write-Host $Error[0]  -ForegroundColor Red
            continue
        }  
        sleep 30
    }
}
else 
{
    write-host 'Mailing list file not provided nor found....'
    exit
}
Write-host "Done processing Excel file $XLFile!"  -ForegroundColor Green

# Step 5: Displaying list of users invited in each workspace
foreach ($workspace in $workspaces_excel ) {
    $workspace_name = $workspace.'Workspace Name'
    $client_id = $workspace.'Client Id'
    # Create header for next API calls 
    $headers = @{} 
    $AccessToken = $tokens[$client_id]
    $headers["Authorization"] = "Bearer $AccessToken"
    $headers["Accept"] = "application/json"
    $headers["Content-Type"] = "application/json"
    try {
        $response = Invoke-webrequest "https://global.api.greenlake.hpe.com/identity/v1/users?filter=&limit=300&offset=0" -Method GET -Headers $headers
    }
    catch {
        Write-Host "Cannot get list of users!!"  -ForegroundColor Red
        exit
    }
    $invited_users=$invited[$client_id]
    Write-Host $invited_users "user(s) invited to workspace" $workspace_name  -ForegroundColor Green
    Write-Host "List of users in workspace:" $workspace_name  -ForegroundColor Green
    
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
    
}

