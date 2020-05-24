drop schema if exists sandbox cascade;

create schema sandbox;

/*
ingestion table
adapted from https://info.crunchydata.com/blog/fast-csv-and-json-ingestion-in-postgresql-with-copy
*/
create table sandbox.ingested_data
(
	id int generated by default as identity primary key,
	ingested_dt timestamp default current_timestamp,
	data jsonb not null,
	loaded bool default false not null
);

create index ingested_data_idx on sandbox.ingested_data using gin(data);