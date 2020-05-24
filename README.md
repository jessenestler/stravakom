# Strava ELT via Python and Postgres

## That's right: ELT, not ETL
This project is my first dive into accessing the Strava API with python and loading/transforming that data inside Postgres. You read that right: I'm playing around with SQL as the project's main data processing language.

### OK, but... why?
On a pure nerd-level, I've been meaning to dip my toes into the open source world of data analysis and visualization for a while. This is my first foray into SQL, and I wanted to fuse this interest with my outdoor activity tracking. Maybe now I won't put off a ride or ski because there'll be a lil' angel on my shoulder saying, "But if you don't go, you won't get to play with the data!" Is that a little fucked up? I'll let you be the judge...

## Requirements

This project makes use of `python 3` for extraction, and `postgres 12` with `postgis 3` for loading, transformation, and analysis.

### Authenticating with Strava

This was a beast to figure out. This [video tutorial](https://www.youtube.com/watch?v=sgscChKfGyg) ended up helping immensely. Once I had all the tokens with proper permission levels, I created a tokens.json file, like so:

```json
{
    "client_id": "my_id",
    "client_secret": "my_secret",
    "refresh_token": "my_refresh_token",
    "grant_type": "refresh_token"
}
```
