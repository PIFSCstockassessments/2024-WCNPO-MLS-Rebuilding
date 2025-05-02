-- PICDR-113559 Requesting annual striped marlin catch data for the American Samoa longline fleet
-- Requested by Jon Brodziak
--
-- Collect annual striped marlin catch biomass and numbers of retained striped marlin
-- for American Samoa longline fleet in the WCPFC convention area north (WCPFC-N) and 
-- south (WCPFC-S) of the equator for the years, 2020-2024.  
-- The longitudinal eastern boundary of the WCPFC convention area is 150 degrees West.  
-- We need an annual total catch biomass in kilograms and 
-- total number of retained fish caught of striped marlin by year 
-- north and south of the equator.
--
SELECT HDR_LANDYR LANDING_YEAR,
BS_QUAD BEGIN_SET_QUADRANT,
SPECIES,
ENGLISH_NAME,
SUM(NVL(NUMKEPT,0)) NUMBER_RETAINED,
SUM(NVL(KEPT_LBS,0)) RETAINED_LBS,
SUM(NVL(KEPT_LBS,0)*0.4535923) RETAINED_KG,
--'LLDS.LLDS_DETAIL_20250224AS' FROM_FILE
--FROM LLDS.LLDS_DETAIL_20250224AS
'LLDS.LLDS_DETAIL_20250315AS' FROM_FILE
FROM LLDS.LLDS_DETAIL_20250315AS
WHERE
HDR_LANDYR BETWEEN '2020' AND '2024'
 AND SPECIES = ' 2'
-- AND BS_LON <= -150.0
-- AND BS_LAT > 0.0
-- AND BS_QUAD = 'WCPFC-N'
 GROUP BY HDR_LANDYR,
 BS_QUAD,
 SPECIES,
 ENGLISH_NAME
 ORDER BY HDR_LANDYR;
 
 
 
 
 