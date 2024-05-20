/*
How many paid users had any calls in Apr 2020?
*/

--my solution
SELECT
    COUNT(DISTINCT user_id) AS aprils_paid_users
FROM rc_calls
WHERE date_trunc('month', date)::date  = '2020-04-01' 
      AND user_id IN (SELECT user_id
                      FROM rc_users
                      WHERE status = 'paid');

--strata
SELECT count(DISTINCT user_id)
FROM rc_calls
WHERE date BETWEEN '2020-04-01' AND '2020-04-30'
  AND user_id in
    (SELECT user_id
     FROM rc_users
     WHERE status = 'paid')