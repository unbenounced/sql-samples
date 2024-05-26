/*
Write a query that returns binary description of rate type per loan_id. The results should have one row per loan_id and two columns: for fixed and variable type.
*/

--eric ** I did not need to get the rate. I just needed to get the count
SELECT loan_id,
       COUNT(*) / 1.0 * SUM(CASE
           WHEN rate_type = 'fixed' THEN 1
           ELSE 0 END) AS fixed,
        COUNT(*) / 1.0 * SUM(CASE
           WHEN rate_type = 'variable' THEN 1
           ELSE 0 END) AS variable
  FROM submissions
 GROUP BY 1;

 --strata
 SELECT loan_id,
       count(CASE
                 WHEN (rate_type='fixed') THEN id
                 ELSE NULL
             END) AS fixed,
       count(CASE
                 WHEN (rate_type='variable') THEN id
                 ELSE NULL
             END) AS VARIABLE
FROM submissions
GROUP BY loan_id