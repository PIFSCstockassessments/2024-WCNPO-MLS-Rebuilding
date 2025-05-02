select year(if(fr.trip_end_date is null, df.day_fished, fr.trip_end_date)) as report_year 
	, c.species_id
	, vs.display_name 
	, round(sum(c.pounds_caught/2.20462), 0) as catch_kgs
	-- , count(distinct fr.licensee_id) as fisher_count
from hawaii_dar_frds.fishing_report fr 
	join hawaii_dar_frds.day_fished df on df.fishing_report_id = fr.fishing_report_id 
	join hawaii_dar_frds.day_area da on da.day_fished_id = df.day_fished_id 
	join hawaii_dar_frds.area_method am on am.day_area_id = da.day_area_id 
	join hawaii_dar_frds.catch c on c.area_method_id = am.area_method_id 
	left join hawaii_dar_frds.view_species vs on vs.species_id = c.species_id 
where year(if(fr.trip_end_date is null, df.day_fished, fr.trip_end_date)) between 2020 and 2024
	and c.species_id = 9
group by 1, 2
;	

select year(pr.report_date) as report_year
	, p.species_id 
	, vs.display_name 
	, round(sum(p.pounds_bought/2.20462), 0) as sold_kgs 
	-- , count(distinct pr.dealer_licensee_id) as dealer_count
from hawaii_dar_frds.purchase_report pr 
	join hawaii_dar_frds.purchase p on p.purchase_report_id = pr.purchase_report_id 
	left join hawaii_dar_frds.view_species vs on vs.species_id = p.species_id 
where year(pr.report_date) between 2020 and 2024
	and p.species_id = 9
group by 1, 2;


-- Combine catch and dealer data into one summary
select year(hd.REPORT_DATE) as report_year
	, SPECIES_FK as species_id
	, hds.SPECIES_NAME 
	, round(sum(hd.LBS_SOLD/2.20462), 0) as sold_kgs
	, round(sum(hd.EST_LBS_SOLD/2.20462), 0) as est_kgs
	-- , count(distinct hd.DEALER_LIC_FK) as dealer_count
from hawaii_dar_wh.h_drs hd 
	left join hawaii_dar_wh.h_drs_species hds on hds.SPECIES_PK = hd.SPECIES_FK 
where year(hd.REPORT_DATE) between 2020 and 2024
	and SPECIES_FK = 9
	and hd.
group by 1,2;

-- Use dealer integration table to filter for non-longline sale
select a.report_year
	, a.species_id
	, a.display_name
	, a.catch_kgs
	, b.sold_kgs
	, b.sold_est_kgs
	, a.number_caught
from 
	(
		select year(if(fr.trip_end_date is null, df.day_fished, fr.trip_end_date)) as report_year 
			, c.species_id
			, vs.display_name 
			, round(sum(c.pounds_caught/2.20462), 0) as catch_kgs
			, sum(c.number_caught) as number_caught
			-- , count(distinct fr.licensee_id) as fisher_count
		from hawaii_dar_frds.fishing_report fr 
			join hawaii_dar_frds.day_fished df on df.fishing_report_id = fr.fishing_report_id 
			join hawaii_dar_frds.day_area da on da.day_fished_id = df.day_fished_id 
			join hawaii_dar_frds.area_method am on am.day_area_id = da.day_area_id 
			join hawaii_dar_frds.catch c on c.area_method_id = am.area_method_id 
			left join hawaii_dar_frds.view_species vs on vs.species_id = c.species_id 
		where year(if(fr.trip_end_date is null, df.day_fished, fr.trip_end_date)) between 2020 and 2024
			and c.species_id = 9
		group by 1, 2
	) as a
	left join 
	(
		select year(hi.REPORT_DATE) as report_year
			, if(SPECIES_FK = 108, 106, SPECIES_FK) as species_id
			, round(sum(hi.LBS_SOLD/2.20462), 0) as sold_kgs
			, round(sum(hi.EST_LBS_SOLD/2.20462), 0) as sold_est_kgs
			-- , count(distinct hi.DEALER_LIC) as dealer_count
		from hawaii_dar.h_integdealer hi 
		where year(hi.REPORT_DATE) between 2020 and 2024
			and hi.SPECIES_FK = 9
			and hi.FISHERY <> 'LONGLINE'
		group by 1,2
	) as b on b.report_year = a.report_year and b.species_id = a.species_id
;



select year(if(fr.trip_end_date is null, df.day_fished, fr.trip_end_date)) as report_year 
	, df.day_fished 
	, fr.licensee_id 
	, c.species_id
	, vs.display_name
	, c.number_caught 
	, c.pounds_caught
	, c.created_datetime 
	-- , count(distinct fr.licensee_id) as fisher_count
from hawaii_dar_frds.fishing_report fr 
	join hawaii_dar_frds.day_fished df on df.fishing_report_id = fr.fishing_report_id 
	join hawaii_dar_frds.day_area da on da.day_fished_id = df.day_fished_id 
	join hawaii_dar_frds.area_method am on am.day_area_id = da.day_area_id 
	join hawaii_dar_frds.catch c on c.area_method_id = am.area_method_id 
	left join hawaii_dar_frds.view_species vs on vs.species_id = c.species_id 
where year(if(fr.trip_end_date is null, df.day_fished, fr.trip_end_date)) = 2024
	and c.species_id = 9
order by 1,2,3,4
;
