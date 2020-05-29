-- Make raw line fatures out of the GPS streams
drop table if exists sandbox.raw_lines;
create table sandbox.raw_lines as (
	select 	    act.*,
				ST_MakeLine(
				  gps.shape::geometry
				  order by gps.seconds_from_start
				) as geom
		from	sandbox.streams gps
		join	sandbox.activity act using(activity_id)
	group by	act.activity_id
);

create index raw_lines_idx on sandbox.raw_lines using gist(geom);