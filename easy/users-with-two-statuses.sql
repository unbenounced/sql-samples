/*
Find users who are both a viewer and streamer.
*/

--my solution
SELECT user_id
FROM twitch_sessions
WHERE session_type = 'streamer'
INTERSECT
SELECT user_id
FROM twitch_sessions
WHERE session_type = 'viewer';

--strata
SELECT user_id
FROM twitch_sessions
GROUP BY user_id
HAVING count(DISTINCT session_type)=2

SELECT user_id
FROM twitch_sessions
WHERE session_type = 'viewer' AND user_id IN (
    SELECT user_id
    FROM twitch_sessions
    WHERE session_type = 'streamer'
)