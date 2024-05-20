/*
Return a list of users with status free who didn’t make any calls in Apr 2020.
*/

--my solution
SELECT user_id
  FROM rc_users
 WHERE status = 'free'
   AND user_id NOT IN 
       (SELECT user_id
        FROM rc_calls
        WHERE date_trunc('month', date) = '2020-04-01');

--strata
SELECT DISTINCT user_id
FROM rc_users
WHERE status = 'free'
  AND user_id not in
    (SELECT user_id
     FROM rc_calls
     WHERE date  BETWEEN '2020-04-01' AND '2020-04-30'
     )