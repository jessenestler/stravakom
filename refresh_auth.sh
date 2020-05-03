#! /bin/sh
curl -s -X POST https://www.strava.com/oauth/token \
-d @tokens.json \
-H "Content-Type: application/json" |\
jq -r ".access_token"