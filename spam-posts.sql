/*
Calculate the percentage of spam posts in all viewed posts by day. A post is considered a spam if a string "spam" is inside keywords of the post. Note that the facebook_posts table stores all posts posted by users. The facebook_post_views table is an action table denoting if a user has viewed a post.
*/

--my solution
SELECT
    COUNT(*) FILTER(WHERE post_keywords ILIKE '%spam%') * 100.0 / COUNT(*) AS pecent_spam_viewed,
    posts.post_date
FROM facebook_posts AS posts
INNER JOIN facebook_post_views AS views
ON posts.post_id = views.post_id
GROUP BY posts.post_date;

/* stratascratch
SELECT spam_summary.post_date,
       (n_spam/n_posts::float)*100 AS spam_share
FROM
  (SELECT post_date,
          sum(CASE
                  WHEN v.viewer_id IS NOT NULL THEN 1
                  ELSE 0
              END) AS n_posts
   FROM facebook_posts p
   JOIN facebook_post_views v ON p.post_id = v.post_id
   GROUP BY post_date) posts_summary
LEFT JOIN
  (SELECT post_date,
          sum(CASE
                  WHEN v.viewer_id IS NOT NULL THEN 1
                  ELSE 0
              END) AS n_spam
   FROM facebook_posts p
   JOIN facebook_post_views v ON p.post_id = v.post_id
   WHERE post_keywords ilike '%spam%'
   GROUP BY post_date) spam_summary ON spam_summary.post_date = posts_summary.post_date
*/