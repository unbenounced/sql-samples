/*
Return the total number of comments received for each user in the 30 or less days before 2020-02-10. Don't output users who haven't received any comment in the defined time period.

*/

--my solution
SELECT 
    user_id,
    SUM(number_of_comments)
FROM fb_comments_count
WHERE created_at BETWEEN DATE '2020-02-10' - 30 AND '2020-02-10'
GROUP BY user_id;

--strata
SELECT user_id,
       sum(number_of_comments) AS number_of_comments
FROM fb_comments_count
WHERE created_at BETWEEN '2020-02-10'::date - 30 * INTERVAL '1 day' AND '2020-02-10'::date
GROUP BY user_id