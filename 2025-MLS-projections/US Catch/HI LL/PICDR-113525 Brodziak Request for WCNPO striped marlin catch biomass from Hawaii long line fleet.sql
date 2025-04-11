-- PICDR-113525 Request for WCNPO striped marlin catch biomass from Hawaii long line fleet
-- Requested by Jon Brodziak
--
-- Collect annual striped marlin landed catch biomass for US Hawaii longline fleet 
-- in WCPFC convention area north of equator for the years, 2020-2024, 
-- noting that 2024 data are not complete.  
-- WCPFC longitudinal eastern boundary is 150 degrees West.  
-- We need an annual total catch biomass in kilograms for striped marlin by year.
--
SELECT HDR_LANDYR LANDING_YEAR,
BS_QUAD BEGIN_SET_QUADRANT,
SPECIES,
ENGLISH_NAME,
SUM(NVL(KEPT_LBS,0)) RETAINED_LBS,
SUM(NVL(KEPT_LBS,0)*0.4535923) RETAINED_KG,
'LLDS.LLDS_DETAIL_20250224HI' FROM_FILE
FROM LLDS.LLDS_DETAIL_20250224HI
WHERE
HDR_LANDYR BETWEEN '2020' AND '2024'
 AND SPECIES = ' 2'
-- AND BS_LON <= -150.0
-- AND BS_LAT > 0.0
 AND BS_QUAD = 'WCPFC-N'
 GROUP BY HDR_LANDYR,
 BS_QUAD,
 SPECIES,
 ENGLISH_NAME
 ORDER BY HDR_LANDYR;
 
 
 
 
 