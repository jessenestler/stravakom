import os
import re
import json
import requests

# Retrieve refresh tokens from tokens.json
with open("tokens.json", "r") as token_file:
    tokens = json.load(token_file)

# Refresh strava's access token
resp = requests.post("https://www.strava.com/oauth/token", data=tokens)
access_token = resp.json()['access_token']

# Retrieve which activities have already been downloaded and/or pipelined
# into postgres
logged = []
dirs = ['./data/', './data/ingested/']
for d in dirs:
    for f in os.listdir(d):
        result = re.search('([0-9]+)', f)
        if result:
            logged.append(result.group())

# Retrieve the most recent activities
resp = requests.get("https://www.strava.com/api/v3/athlete/activities",
                    params={"access_token": access_token})
raw_activities = resp.json()
activities = {str(a['id']): {"properties": a}
              for a in raw_activities if str(a['id']) not in logged}

# Get rid of the "map" data that contains an encoded polyline
# We don't need it and it messes up Postgres ingestion
for v in activities.values():
    del v["properties"]["map"]

# Bundle activities with their respective time, altitude, moving, and GPS
# streams and export to json files
for act_id, contents in activities.items():
    # Extract from Strava API
    resp = requests.get(f"https://www.strava.com/api/v3/activities/{act_id}/streams",
                        params={"access_token": access_token,
                                "keys": "time,latlng,altitude,moving"})
    raw_streams = resp.json()

    # Group records from all streams
    streams = {s["type"]: s["data"] for s in raw_streams}
    try:
        zipped = list(zip(streams["time"], streams["moving"],
                          streams["altitude"], streams["latlng"]))
    except KeyError:  # don't save the activity if it doesn't have a GPS stream
        continue
    contents["streams"] = zipped

    # Export to json
    with open(f"./data/Activity_{act_id}.json", "w") as act_file:
        json.dump(contents, act_file)
