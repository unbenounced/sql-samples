/*
Write a query that joins this submissions table to the loans table and returns the total loan balance on each user’s most recent ‘Refinance’ submission. Return all users and the balance for each of them.
*/

--eric
SELECT a.user_id, b.balance
  FROM (SELECT id, user_id, created_at,
      RANK() OVER(PARTITION BY user_id ORDER BY created_at)
          FROM loans
          WHERE type = 'Refinance'
          AND status = 'offer_accepted') AS a
 INNER JOIN submissions AS b
    ON a.id = b.loan_id
 WHERE a.rank = 1;

 --strata
 SELECT l.user_id, balance
FROM
  (SELECT DISTINCT id, user_id, created_at,
                   max(created_at) OVER (PARTITION BY user_id,
                                                      TYPE) most_recent
   FROM loans
   WHERE TYPE = 'Refinance') l
INNER JOIN submissions s ON l.id = s.loan_id
WHERE most_recent = created_at