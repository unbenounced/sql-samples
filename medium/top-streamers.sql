/*
List the top 10 users who accumulated the most sessions where they had more streaming sessions than viewing. Return the user_id, number of streaming sessions, and number of viewing sessions.
*/

--eric
SELECT user_id, streamer, viewer
FROM (SELECT user_id,
       SUM(streamer) AS streamer, SUM(viewer) AS viewer,
       RANK() OVER(ORDER BY SUM(streamer) - SUM(viewer) DESC)
        FROM (SELECT user_id, session_type,
                     SUM(CASE WHEN session_type = 'streamer' THEN 1 ELSE 0 END) AS streamer,
                     SUM(CASE WHEN session_type = 'viewer' THEN 1 ELSE 0 END) AS viewer
                FROM twitch_sessions
               GROUP BY user_id, session_type) AS a
       GROUP BY user_id
      HAVING SUM(streamer) > SUM(viewer)
     ) AS b
WHERE rank <= 10;

--strata
WITH cte AS
  (SELECT user_id,
          count(CASE
                    WHEN session_type='streamer' THEN 1
                    ELSE NULL
                END) AS streaming,
          count(CASE
                    WHEN session_type='viewer' THEN 1
                    ELSE NULL
                END) AS VIEW
   FROM twitch_sessions
   GROUP BY user_id
   HAVING count(CASE
                    WHEN session_type='streamer' THEN 1
                    ELSE NULL
                END) > count(CASE
                                 WHEN session_type='viewer' THEN 1
                                 ELSE NULL
                             END)) ,
     cte_ranking AS
  (SELECT *,
          rank() OVER (
                       ORDER BY (streaming + VIEW) DESC) AS rnk
   FROM cte)
SELECT user_id,
       streaming,
       VIEW
FROM cte_ranking
WHERE rnk <=10