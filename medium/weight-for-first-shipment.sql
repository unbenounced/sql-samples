/*
Write a query to find the weight for each shipment's earliest shipment date. Output the shipment id along with the weight.
*/

--mine
SELECT shipment_id, weight
FROM (SELECT shipment_id, weight,
             RANK() OVER(PARTITION BY  shipment_id ORDER BY shipment_date)
        FROM amazon_shipment) AS a
WHERE rank = 1;

--strata
WITH cte AS
  (SELECT shipment_id,
          MIN(shipment_date) AS min_date
   FROM amazon_shipment
   GROUP BY 1)
SELECT cte.shipment_id,
       weight
FROM amazon_shipment
JOIN cte ON amazon_shipment.shipment_id = cte.shipment_id
WHERE min_date = shipment_date