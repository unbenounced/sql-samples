/*
Select the most popular client_id based on a count of the number of users who have at least 50% of their events from the following list: 'video call received', 'video call sent', 'voice call received', 'voice call sent'.
*/

--my solution
SELECT client_id
FROM (SELECT 
        client_id,
        COUNT(*),
        RANK() OVER(ORDER BY COUNT(*) DESC)
      FROM fact_events
      WHERE user_id IN 
                        (SELECT user_id
                         FROM (
                               SELECT 
                                 user_id,
                                 SUM(CASE WHEN event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent') THEN 1 ELSE 0 END) * 100.0  / COUNT(*) AS total_notifications
                                FROM fact_events
                                GROUP BY 1
                                ) AS d
                         WHERE total_notifications >= 50
                        )
        GROUP BY client_id) AS f
WHERE rank = 1;

--strata
SELECT client_id FROM (SELECT client_id, rank() over (order by count(*) DESC)
FROM fact_events
WHERE user_id in
    (SELECT user_id
     FROM fact_events
     GROUP BY user_id
     HAVING avg(CASE
                    WHEN event_type in ('video call received', 'video call sent', 'voice call received', 'voice call sent') THEN 1
                    ELSE 0
                END) >=0.5)
GROUP BY client_id) a
WHERE rank = 1