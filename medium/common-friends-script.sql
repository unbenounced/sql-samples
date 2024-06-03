/*
You are analyzing a social network dataset at Google. Your task is to find mutual friends between two users, Karl and Hans. There is only one user named Karl and one named Hans in the dataset.


The output should contain 'user_id' and 'user_name' columns.
*/

--eric
SELECT hans_karl_friends.friend_id, u.user_name
  FROM (SELECT friend_id, COUNT(friend_id)
          FROM friends
         WHERE user_id IN (SELECT user_id
                             FROM users
                            WHERE user_name IN ('Hans', 'Karl'))
         GROUP BY 1
        HAVING COUNT(friend_id) > 1) AS hans_karl_friends
 INNER JOIN users AS u
    ON hans_karl_friends.friend_id = u.user_id

--strata
with cte as(SELECT friend_id FROM friends
WHERE user_id IN (SELECT user_id FROM users WHERE user_name = 'Karl')
INTERSECT
SELECT friend_id FROM friends
WHERE user_id IN (SELECT user_id FROM users WHERE user_name = 'Hans'))

SELECT cte.friend_id AS user_id, users.user_name
FROM cte join users ON friend_id = user_id