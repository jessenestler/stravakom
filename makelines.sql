-- Make line fatures out of the GPS streams, and project
-- to CO North State Plane (epsg: 2876) for now.
select 	    act.*,
		    ST_MakeLine(
			  ST_Transform(gps.shape::geometry, 2876)
			  order by gps.seconds_from_start
		    ) as geom,
		    ST_Length(
			  ST_MakeLine(
				  ST_Transform(gps.shape::geometry, 2876)
			  	  order by gps.seconds_from_start
			  )
		  	)/5280 as shape_length
    from	sandbox.streams gps
    join	sandbox.activity act using(activity_id)
group by	act.activity_id
order by	act.activity_start desc;