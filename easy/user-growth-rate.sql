/*
Find the growth rate of active users for Dec 2020 to Jan 2021 for each account. The growth rate is defined as the number of users in January 2021 divided by the number of users in Dec 2020. Output the account_id and growth rate.
*/

--eric
SELECT account_id,
       SUM(CASE 
       WHEN date = '2021-01-01' THEN 1 
       ELSE 0 END)::float /
       SUM(CASE 
       WHEN date = '2020-12-01' THEN 1 
       ELSE 0 END)::float AS growth_rate
  FROM (SELECT DISTINCT date_trunc('month', date) AS date, account_id, user_id
        FROM sf_events
        WHERE date BETWEEN '2020-12-01' AND '2021-01-31') AS a
 GROUP BY 1;

--strata
SELECT account_id,
       COUNT(DISTINCT (CASE
                           WHEN date BETWEEN '2021-01-01' AND '2021-01-31' THEN user_id
                           ELSE NULL
                       END))::float / COUNT(DISTINCT (CASE
                                                          WHEN date BETWEEN '2020-12-01' AND '2020-12-31' THEN user_id
                                                          ELSE NULL
                                                      END))::float
FROM sf_events
GROUP BY 1