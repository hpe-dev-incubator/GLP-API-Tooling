from time import sleep
from oauthlib.oauth2 import BackendApplicationClient       
from requests.auth import HTTPBasicAuth       
from requests_oauthlib import OAuth2Session       
from datetime import datetime, timedelta
import requests
import json
import os
import pwinput

client_id = os.environ.get("CLIENTID", "")
client_secret = os.environ.get("CLIENTSECRET", "")

if client_id == "":
    client_id = input("Enter your HPE GreenLake Client ID: ")

if client_secret == "":
    client_secret = pwinput.pwinput("Enter your HPE GreenLake Client Secret: ")


client = BackendApplicationClient(client_id)       
oauth = OAuth2Session(client=client)       
auth = HTTPBasicAuth(client_id,client_secret)  

# Get a Token
try:
    token = oauth.fetch_token(token_url='https://sso.common.cloud.hpe.com/as/token.oauth2', auth=auth)       
except:
    print("Error retrieving access token.")
    exit()

my_token = "Bearer " + token["access_token"]

# Loop until CTRL-C or token expires (2 hours)
while True:

    # Get date in right format
    now = datetime.utcnow() + timedelta(minutes = -1)
    date = now.strftime("%Y-%m-%dT%H:%M:%S.00Z")
    print("Last check at (UTC): ", date)
    print('-------------------')

    # Build headers
    my_headers = {
        'accept': 'application/json',
        'Authorization': my_token,
    }
    my_url = "https://global.api.greenlake.hpe.com/audit-log/v1beta1/logs?filter=createdAt%20ge%20'" + date + "'"

    # Fetch audit logs since last minute
    response = requests.get(url=my_url, headers=my_headers)
    try:
        response.raise_for_status()
    except:
        print("Error calling the API or token has expired!")
        exit()
        
    # Process json response 
    json = response.json() 

    e = 0
    while (e < json['count']):
        print('createdAt: '+ json['items'][e]['createdAt'])
        print('username: ' + json['items'][e]['user']['username'])
        print('description: ' + json['items'][e]['description'])
        try:
            print('ipAddress: ' + json['items'][e]['additionalInfo']['ipAddress'])
        except: {
            print('ipAddress:')
        }

        print('-----------')
        e = e + 1 

    sleep(60)