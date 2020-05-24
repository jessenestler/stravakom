# run the strava api scraper via python and conda
/Users/jessenestler/anaconda3/envs/stravakom_env/bin/python strava_api.py

# add contents of each file to the sandbox.ingested_data table
if [[ "$(ls ./data/*.json)" ]]; then
    for file in ./data/*.json
    do
        cat $file | psql -d strava -c 'COPY sandbox.ingested_data (data) from stdin;'
        mv $file ./data/ingested
    done
else
    echo "No new activities to pipeline"
fi
