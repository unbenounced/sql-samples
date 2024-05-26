/*
Find the monthly active users for January 2021 for each account. Your output should have account_id and the monthly count for that account.
*/

--my solution
SELECT account_id, 
       COUNT(DISTINCT user_id)
  FROM sf_events
 WHERE date_trunc('month', date) = '2021-01-01' 
 GROUP BY account_id;

 --strata
 SELECT account_id,
       count(DISTINCT user_id) AS users_count
FROM sf_events
WHERE EXTRACT(MONTH
              FROM date) = 1
  AND EXTRACT(YEAR
              FROM date) = 2021
GROUP BY account_id