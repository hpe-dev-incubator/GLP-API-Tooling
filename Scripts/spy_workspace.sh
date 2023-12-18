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

# Get a token
access_token="Bearer "`curl -s --location 'https://sso.common.cloud.hpe.com/as/token.oauth2' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id='$client_id'' \
--data-urlencode 'client_secret='$client_secret''  | jq .access_token | xargs`


# Loop until CTRL-C or token expires (2 hours)
for (( ; ; ))
do
  d=`date -v "-1M" -u +"%Y-%m-%dT%H:%M:%S.00Z"`
  echo Last check at \(UTC\): $d
  echo '---------------------'


  # Fetch audit logs since last minute
  http_response=$(curl -s -o out.json -w "%{http_code}" --location "https://global.api.greenlake.hpe.com/audit-log/v1beta1/logs?filter=startTime%20ge%20'$d'" \
  --header 'Accept: application/json' \
  --header "Authorization: $access_token")

  if [ "$http_response" != "200" ]; then
      echo "Error calling the API or token has expired!"
      exit $http_response
  else
      cat out.json | jq '.items[] | { createdAt: .createdAt, username: .user.username, description: .description, ipAddress: .additionalInfo.ipAddress}'
  fi  

  # Wait a minute and check again
  sleep 60
done