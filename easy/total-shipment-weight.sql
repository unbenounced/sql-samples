/*
Calculate the total weight for each shipment and add it as a new column. Your output needs to have all the existing rows and columns in addition to the  new column that shows the total weight for each shipment. One shipment can have multiple rows.
*/

--eric 
SELECT amazon_shipment.*, tw.total_weight
  FROM amazon_shipment
 INNER JOIN (SELECT shipment_id, SUM(weight) AS total_weight 
               FROM amazon_shipment
           GROUP BY shipment_id) AS tw
 ON amazon_shipment.shipment_id = tw.shipment_id;

--strata
WITH cte AS
  (SELECT shipment_id,
          sum(weight) AS total_weight
   FROM amazon_shipment
   GROUP BY 1)
SELECT amazon_shipment.*,
       total_weight
FROM amazon_shipment
JOIN cte ON amazon_shipment.shipment_id = cte.shipment_id