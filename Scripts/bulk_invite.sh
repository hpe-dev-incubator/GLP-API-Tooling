#!/bin/bash
if [[ -z "${CLIENTID}" ]]; then
  read -p "Enter your HPE GreenLake Client ID: " client_id
else
  client_id="${CLIENTID}"
fi
if [[ -z "${CLIENTSECRET}" ]]; then
client_secret=""
pass_var="Enter your HPE GreenLake Client Secret: "      # to take password character wise
while IFS= read -p "$pass_var" -r -s -n 1 letter
do
    if [[ $letter == $'\0' ]]       #  if enter is pressed, exit the loop
    then
        break
    fi
     
    client_secret="${client_secret}$letter"        # store the letter in pass, use pass+="$letter" for more concise and readable.
    pass_var="*"            # in place of password the asterisk (*) will be printed
done
else
  client_secret="${CLIENTSECRET}"
fi

if [[ -z "${CSVFILE}" ]]; then
  read -p "Enter CSV file to read from: " csv_file
else
  csv_file="${CSVFILE}"
fi

# Get a token
access_token="Bearer "`curl -s --location 'https://sso.common.cloud.hpe.com/as/token.oauth2' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id='$client_id'' \
--data-urlencode 'client_secret='$client_secret''  | jq .access_token | xargs`


# Loop over item in CSV file
i=0
while IFS="," read -r email workspace role
do
  echo "email: $email"
  echo "workspaceid: $workspace"
  echo "role: $role"
  echo ""
  body="{
    \"email\": \"$email\",
    \"sendWelcomeEmail\": true}"
    
echo $body

  http_response=$(curl -s -X POST --location "https://global.api.greenlake.hpe.com/identity/v1/users" \
  -H "Authorization: $accesstoken" \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $body)
 
  if [ "$http_response" != "201" ]; then
    echo "Error calling the API"
    echo $http_response
    exit $http_response
  else
    i+=1
  fi
done < <(tail -n +2 $csv_file)

echo "Total users invited: $i"
