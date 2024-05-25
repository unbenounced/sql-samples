/* 
The marketing manager wants you to evaluate how well the previously ran advertising campaigns are working.


Particularly, they are interested in the promotion IDs from the online_promotions table.


Find the percentage of orders with promotion IDs from the online_promotions table applied.
*/

--eric 
SELECT  100.0 * COUNT(b.promotion_id) / COUNT(*) AS perc_promotion_id
  FROM online_orders AS a
  LEFT JOIN online_promotions AS b
    ON a.promotion_id = b.promotion_id

--strata
SELECT ((COUNT(p.promotion_id) / CAST(COUNT(*) AS decimal)) * 100.0) AS percentage
FROM online_orders AS s
LEFT OUTER JOIN online_promotions AS p ON s.promotion_id = p.promotion_id;