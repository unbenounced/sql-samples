/*
Calculate each user's average session time. A session is defined as the time difference between a page_load and page_exit. For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit, with an obvious restriction that load time event should happen before exit time event . Output the user_id and their average session time.
*/

--my solution
SELECT
    page_load.user_id,
    AVG(exit_load.latest_page_exit - page_load.earliest_page_load)
FROM (SELECT
        user_id,
        DATE(timestamp) AS day,
        timestamp AS earliest_page_load,
        RANK() OVER(PARTITION BY user_id, DATE(timestamp) ORDER BY timestamp DESC)
      FROM facebook_web_log
      WHERE action = 'page_load') AS page_load
INNER JOIN (SELECT
                user_id,
                DATE(timestamp) AS day,
                timestamp AS latest_page_exit,
                RANK() OVER(PARTITION BY user_id, DATE(timestamp) ORDER BY timestamp ASC)
            FROM facebook_web_log
            WHERE action = 'page_exit') AS exit_load
ON page_load.user_id = exit_load.user_id AND
   page_load.day = exit_load.day
WHERE page_load.rank = 1 AND
      exit_load.rank = 1
GROUP BY page_load.user_id;

--stratascratch
WITH ordered_actions AS (
    SELECT user_id, timestamp, action,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY timestamp) as seq_num
    FROM facebook_web_log
    WHERE action IN ('page_load', 'page_exit')
),
matched_sessions AS (
    SELECT
        a.user_id,
        a.timestamp AS load_time,
        b.timestamp AS exit_time,
        b.timestamp - a.timestamp AS session_duration
    FROM ordered_actions a
    JOIN ordered_actions b ON a.user_id = b.user_id AND a.seq_num = b.seq_num - 1
    WHERE a.action = 'page_load' AND b.action = 'page_exit'
)
SELECT user_id, AVG(session_duration) AS avg_session_duration
FROM matched_sessions
GROUP BY user_id;