#! /bin/sh
my_token=$(. refresh_auth.sh)

# Get activity streams
for act_id in $(jq -r ".[] | .id" activities.json)
do
    if [[ ! -f ./data/$act_id'_stream.json' ]]
    then
        echo "Creating Activity Stream for $act_id..."
        # save each activity stream
        curl -X GET https://www.strava.com/api/v3/activities/$act_id/streams \
        -d access_token=$my_token \
        -d keys=time,latlng,altitude,moving \
        > ./data/$act_id'_stream.json'
    else
        echo "Activity Stream for $act_id has already been saved..."
    fi
done