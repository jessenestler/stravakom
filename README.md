## Strava Segment Analysis
This project is my first dive into both the Strava API and data science fundamentals. I'm an avid mountain biker, and when I ride, I often wonder what goes into K/QOM times on certain downhill segments: does the bike type or brand matter? What about total weekly miles, or maybe riding the segment so often that the trail is committed to memory? These are the kinds of questions I hope to answer, and I would ultimately like to use the answers to see if I could improve my own times on some of my favorite trails.

### Requirements

This project makes use of conda environments to manage python packages, and it also uses environment variables to store Strava API tokens. To make sure you can run these analyses, be sure to register with Strava to receive your access tokens. I used [this tutorial](https://towardsdatascience.com/how-to-hide-your-api-keys-in-python-fb2e1a61b0a0) to set up my keys as environment variables.

This project also makes use of PostgreSQL and the PostGIS extension to perform any spatial analysis tasks.