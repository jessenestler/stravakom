-- Make line fatures out of the GPS streams
select 	    act.*,
		    ST_MakeLine(
			  gps.shape::geometry
			  order by gps.seconds_from_start
		    ) as geom
    from	sandbox.streams gps
    join	sandbox.activity act using(activity_id)
group by	act.activity_id
order by	act.activity_start desc;