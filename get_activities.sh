#! /bin/sh
my_token=$(. refresh_auth.sh)

# Get activity information
if [[ ! -f activities.json ]]
then
    curl -s -X GET https://www.strava.com/api/v3/athlete/activities \
    -d access_token=$my_token >\
    activities.json
fi

# Parse each activity into a new file by ID
c=$(jq '. | length' activities.json)
for x in $(seq 0 $(($c-1)))
do
    act_id=$(jq -r " .[$x] | .id" activities.json)
    if [[ ! -f ./data/$act_id'_activity.json' ]]
    then
        echo "Extracting metadata for Activity $act_id..."
        jq ".[$x]" activities.json >\
        ./data/$act_id'_activity.json'
    else
        echo "Activity information already exists for $act_id"
    fi
done