/*
Write a query that'll identify returning active users. A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. Output a list of user_ids of these returning active users.
*/

--my solution
SELECT DISTINCT user_id
FROM (SELECT
         user_id,
         created_at,
         LAG(created_at) OVER(PARTITION BY user_id ORDER BY created_at) AS previous_order
      FROM amazon_transactions
      ) AS lag_added
WHERE created_at - previous_order <= 7;

--stratascratch
SELECT DISTINCT(a1.user_id)
FROM amazon_transactions a1
JOIN amazon_transactions a2 ON a1.user_id=a2.user_id
AND a1.id <> a2.id
AND a2.created_at::date-a1.created_at::date BETWEEN 0 AND 7
ORDER BY a1.user_id