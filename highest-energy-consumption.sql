/*
Find the date with the highest total energy consumption from the Meta/Facebook data centers. Output the date along with the total energy consumption across all data centers.
*/


--my solution
WITH energy_sums AS (
SELECT
    date,
    SUM(consumption) AS consumption
FROM (SELECT *
      FROM fb_eu_energy AS eu
      UNION ALL
      SELECT *
      FROM fb_asia_energy AS asia
      UNION ALL
      SELECT *
      FROM fb_na_energy AS na) AS combined
GROUP BY date
)

SELECT 
    date,
    consumption
FROM energy_sums
WHERE consumption = (SELECT MAX(consumption) FROM energy_sums);

--stratascratch
WITH total_energy AS
  (SELECT *
   FROM fb_eu_energy eu
   UNION ALL SELECT *
   FROM fb_asia_energy asia
   UNION ALL SELECT *
   FROM fb_na_energy na),
     energy_by_date AS
  (SELECT date, sum(consumption) AS total_energy
   FROM total_energy
   GROUP BY date
   ORDER BY date ASC),
     max_energy AS
  (SELECT max(total_energy) AS max_energy
   FROM energy_by_date)
SELECT ebd.date,
       ebd.total_energy
FROM energy_by_date ebd
JOIN max_energy me ON ebd.total_energy = me.max_energy