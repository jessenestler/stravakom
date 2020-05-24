# extract strava data through the python api scraper
/Users/jessenestler/anaconda3/envs/stravakom_env/bin/python extract.py

# load contents of each file into Postgres
. load.sh

# transform the data inside the database
if [[ "$newfiles" == "yes" ]]; then
    psql -f transform.sql
else
    echo "No new activities to pipeline"
fi
