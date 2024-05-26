/*
What cities recorded the largest growth and biggest drop in order amount between March 11, 2019, and April 11, 2019. Just compare order amounts on those two dates. Your output should include the names of the cities and the amount of growth/drop.
*/

--eric 
WITH cte AS (SELECT b.name AS city,
                    SUM(CASE WHEN DATE_TRUNC('day', a.order_timestamp_utc) = '2019-04-11' THEN amount ELSE 0 END) -
                    SUM(CASE WHEN DATE_TRUNC('day', a.order_timestamp_utc) = '2019-03-11' THEN amount ELSE 0 END) AS growth
               FROM postmates_orders AS a
              INNER JOIN postmates_markets AS b
                 ON a.city_id = b.id
              WHERE DATE_TRUNC('day', a.order_timestamp_utc) = '2019-03-11'
                 OR DATE_TRUNC('day', a.order_timestamp_utc) = '2019-04-11'
              GROUP BY b.name)


SELECT city, growth
  FROM cte
 WHERE growth IN (SELECT MAX(growth) FROM cte)
    OR growth IN (SELECT MIN(growth) FROM cte)
 ORDER BY growth DESC;

 --strata
 WITH cte1 AS
  (SELECT m.name,
          o.order_timestamp_utc::date,
         lag(sum(amount), 1) over(PARTITION BY name
                                                 ORDER BY o.order_timestamp_utc::date DESC) - sum(amount) AS amount_difference
   FROM postmates_orders o
   INNER JOIN postmates_markets m ON o.city_id = m.id
   GROUP BY 1,
            2)
SELECT name, amount_difference
FROM cte1
WHERE amount_difference =
    (SELECT max(amount_difference)
     FROM cte1)
  OR amount_difference =
    (SELECT min(amount_difference)
     FROM cte1)