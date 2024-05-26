/*
Return a distribution of users activity per day of the month. By distribution we mean the number of posts per day of the month.
*/

--my solution
SELECT 
    date_part('day', post_date),
    COUNT(*)
FROM facebook_posts
GROUP BY 1;

--strata
SELECT date_part('day', post_date),
       count(*)
FROM facebook_posts
GROUP BY date_part('day', post_date)