/*
Count the number of users who made more than 5 searches in August 2021.
*/

--eric
SELECT COUNT(*) AS n_users
FROM (
      SELECT user_id, COUNT(*)
        FROM fb_searches
       WHERE DATE_TRUNC('month', date) = '2021-08-01'
       GROUP BY user_id
      HAVING COUNT(*) > 5
     ) AS fb

--strata
SELECT count(user_id) AS result
FROM
  (SELECT user_id,
          count(search_id) AS august_searches
   FROM fb_searches
   WHERE date BETWEEN '2021-08-01' AND '2021-08-31'
   GROUP BY user_id) a
WHERE august_searches > 5