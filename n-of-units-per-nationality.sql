/*
Find the number of apartments per nationality that are owned by people under 30 years old.


Output the nationality along with the number of apartments.


Sort records by the apartments count in descending order.
*/

--my solution
SELECT
    hosts.nationality,
    COUNT(DISTINCT units.unit_id) AS n_apts
FROM airbnb_hosts AS hosts
INNER JOIN airbnb_units AS units
ON hosts.host_id = units.host_id
WHERE hosts.age < 30 AND
      units.unit_type = 'Apartment'
GROUP BY hosts.nationality;

--stratascratch solution
SELECT
    hosts.nationality,
    COUNT(DISTINCT units.unit_id) AS n_apts
FROM airbnb_hosts AS hosts
INNER JOIN airbnb_units AS units
ON hosts.host_id = units.host_id
WHERE hosts.age < 30 AND
      units.unit_type = 'Apartment'
GROUP BY hosts.nationality;