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

for (( ; ; ))
do
  d=`date -v "-1M" -u +"%Y-%m-%dT%H:%M:%S.00Z"`
  echo Last check at \(UTC\): $d
  echo '---------------------'

  # Get a token
  access_token="Bearer "`curl -s --location 'https://sso.common.cloud.hpe.com/as/token.oauth2' \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'grant_type=client_credentials' \
  --data-urlencode 'client_id='$client_id'' \
  --data-urlencode 'client_secret='$client_secret''  | jq .access_token | xargs`
  
  # Fetch audit logs since last minute
  curl -s --location "https://global.api.greenlake.hpe.com/audit-log/v1beta1/search?filter=startTime%20eq%20'$d'" \
  --header 'Accept: application/json' \
  --header "Authorization: $access_token" | jq '.items[] | { auditCreatedAt: .auditCreatedAt, username: .username, description: .description, ipAddress: .additionalInfo.ipAddress }'

  # Wait a minute and check again
  sleep 60
done