/*
Write a query that returns the rate_type, loan_id, loan balance , and a column that shows with what percentage the loan's balance contributes to the total balance among the loans of the same rate type.
*/
--eric
SELECT a.loan_id, a.rate_type, a.balance, 
       a.balance / b.sum * 100.0 AS balance_share 
  FROM submissions AS a
 INNER JOIN (SELECT rate_type,
                    SUM(balance)
             FROM submissions
             GROUP BY rate_type) AS b
   ON a.rate_type = b.rate_type;
--strata
SELECT s1.loan_id,
       s1.rate_type,
       sum(s1.balance) AS balance,
       sum(s1.balance)::decimal/total_balance*100 AS balance_share
FROM submissions s1
LEFT JOIN
  (SELECT rate_type,
          sum(balance) AS total_balance
   FROM submissions
   GROUP BY rate_type) s2 ON s1.rate_type = s2.rate_type
GROUP BY s1.loan_id,
         s1.rate_type,
         s2.total_balance
ORDER BY s1.rate_type, s1.loan_id