/*
You have access to Facebook's database which includes several tables relevant to user interactions. For this task, you are particularly interested in tables that store data about user posts, friendships, and likes. Calculate the total number of likes made on friend posts on Friday.


The output should contain two different columns 'likes' and 'date'.
*/

--eric
SELECT COUNT(*), likes.date_liked
  FROM (SELECT post_id, user_name AS like_user, date_liked
          FROM likes
         WHERE EXTRACT(DOW FROM date_liked) = 5) AS likes
  LEFT JOIN (SELECT user_name AS post_user, post_id
               FROM user_posts
               ) AS posts
         ON likes.post_id = posts.post_id
      WHERE likes.like_user IN (SELECT CASE WHEN user_name1 = post_user THEN user_name2
                                            WHEN user_name2 = post_user THEN user_name1
                                            ELSE null END AS user_f
                                  FROM friendships)
      GROUP BY likes.date_liked


--strata
WITH friendships_clean AS (
    SELECT DISTINCT user_name1, user_name2
    FROM friendships
),
friendships_expanded AS (
    SELECT user_name1, user_name2 FROM friendships_clean
    UNION ALL
    SELECT user_name2 AS user_name1, user_name1 AS user_name2 FROM friendships_clean
),
likes_posts_joined AS (
    SELECT 
        l.user_name, 
        l.post_id, 
        l.date_liked,
        p.user_name AS poster_name
    FROM likes l
    JOIN user_posts p ON l.post_id = p.post_id
    WHERE l.date_liked IS NOT NULL
),
friends_likes AS (
    SELECT lp.user_name, lp.post_id, lp.date_liked, lp.poster_name
    FROM likes_posts_joined lp
    JOIN friendships_expanded fe ON lp.user_name = fe.user_name1 AND lp.poster_name = fe.user_name2
),
friday_likes AS (
    SELECT post_id, date_liked
    FROM friends_likes
    WHERE EXTRACT(DOW FROM date_liked) = 5
)
SELECT date_liked, COUNT(post_id) AS likes
FROM friday_likes
GROUP BY date_liked
ORDER BY date_liked;

--top vote
select date_liked, count(p.post_id)
from likes l
join user_posts p on l.post_id = p.post_id --This inner join added all the likes and paired the likes with the post by post_id
join friendships f on (l.user_name = f.user_name1 and p.user_name = f.user_name2) --this inner join paired row with a friend combination
                    or (l.user_name = f.user_name2 and p.user_name = f.user_name1) ----this inner join paired row with the other friend combination
where EXTRACT(DOW FROM date_liked::date) = 5
group by date_liked