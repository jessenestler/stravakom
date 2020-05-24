-- insert activity info into sandbox.activity
-- the "activity_loaded" boolean field ensures we only insert new activities
with activity as (
	   update 	sandbox.ingested_data
		  set 	activity_loaded = true
  	    where 	activity_loaded = false
	returning 	data->'properties' as prop
)
insert into sandbox.activity
select	(prop->>'id')::bigint,
		(prop->>'name'),
		(prop->>'type'),
		(prop->>'start_date')::timestamptz,
		(prop->>'commute')::bool,
		(prop->>'gear_id'),
		(prop->>'athlete_count')::int,
		(prop->>'pr_count')::int,
		(prop->>'achievement_count')::int,
		(prop->>'kilojoules')::numeric
from	activity;

-- insert streams into sandbox.streams
-- the "streams_loaded" boolean field ensures we only insert new streams
with streams as (
	   update 	sandbox.ingested_data
		  set 	streams_loaded = true
 	    where 	streams_loaded = false
	returning 	(data->'properties'->'id')::bigint as act_id,
				data->'streams' as s
)
insert into sandbox.streams
select 	act_id,
		(jsonb_array_elements(s)->0)::int,
		(jsonb_array_elements(s)->1)::bool,
		(jsonb_array_elements(s)->2)::numeric,
		(jsonb_array_elements(s)->3->0)::numeric,
		(jsonb_array_elements(s)->3->1)::numeric
from streams;
