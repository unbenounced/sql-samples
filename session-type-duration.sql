/* 
Calculate the average session duration for each session type?
*/

--my solution
SELECT
    session_type,
    AVG(session_end - session_start)
FROM twitch_sessions
GROUP BY session_type;

--strata
SELECT session_type,
       avg(session_end -session_start) AS duration
FROM twitch_sessions
GROUP BY session_type