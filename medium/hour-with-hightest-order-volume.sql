/*
Which hour has the highest average order volume per day? Your output should have the hour which satisfies that condition, and average order volume.
*/

--eric 
SELECT hour, avg
  FROM (SELECT EXTRACT(HOUR FROM day_plus_hour) AS hour, AVG(count),
               RANK() OVER(ORDER BY AVG(count) DESC)
          FROM (SELECT DATE_TRUNC('hour', order_timestamp_utc) AS day_plus_hour,
                       COUNT(*)
                  FROM postmates_orders
                 GROUP BY 1) AS day_breakdown 
         GROUP BY 1) AS ranked_avg
 WHERE rank = 1;

 --strata
 WITH SUMMARY AS
  (SELECT HOUR,
          avg(n_orders) avg_orders
   FROM
     (SELECT date_part('hour', order_timestamp_utc) AS HOUR,
             order_timestamp_utc::date,
             count(id) n_orders
      FROM postmates_orders
      GROUP BY date_part('hour', order_timestamp_utc),
               order_timestamp_utc::date) sq
   GROUP BY HOUR)
SELECT *
FROM SUMMARY
WHERE avg_orders =
    (SELECT max(avg_orders)
     FROM SUMMARY)
ORDER BY avg_orders DESC