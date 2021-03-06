if [[ "$(ls ./data/*.json 2> /dev/null)" ]]; then
    newfiles="yes"
    for file in ./data/*.json
    do
        cat $file | psql -d strava -c 'COPY sandbox.ingested_data (data) from stdin;'
        mv $file ./data/ingested
    done
else
    newfiles="no"
fi