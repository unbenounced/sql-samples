/*  
What is the overall friend acceptance rate by date? Your output should have the rate of acceptances by the date the request was sent. Order by the earliest date to latest.


Assume that each friend request starts by a user sending (i.e., user_id_sender) a friend request to another user (i.e., user_id_receiver) that's logged in the table with action = 'sent'. If the request is accepted, the table logs action = 'accepted'. If the request is not accepted, no record of action = 'accepted' is logged.
*/

--my solution
SELECT
    requests.date,
    1.0 * COUNT(accepted.action) / COUNT(*) AS acceptance_rate
FROM (SELECT 
        date,
        user_id_sender,
        user_id_receiver,
        action
      FROM fb_friend_requests
      WHERE action = 'sent') AS requests
LEFT JOIN (SELECT 
                date,
                user_id_sender,
                user_id_receiver,
                action
            FROM fb_friend_requests
            WHERE action = 'accepted') AS accepted
ON requests.user_id_sender = accepted.user_id_sender AND
   requests.user_id_receiver = accepted.user_id_receiver
GROUP BY requests.date
ORDER BY requests.date;

--stratascracth
WITH sent_cte AS
  (SELECT date, user_id_sender,
                user_id_receiver
   FROM fb_friend_requests
   WHERE action='sent' ),
     accepted_cte AS
  (SELECT date, user_id_sender,
                user_id_receiver
   FROM fb_friend_requests
   WHERE action='accepted' )
SELECT a.date,
       count(b.user_id_receiver)/CAST(count(a.user_id_sender) AS decimal) AS percentage_acceptance
FROM sent_cte a
LEFT JOIN accepted_cte b ON a.user_id_sender=b.user_id_sender
AND a.user_id_receiver=b.user_id_receiver
GROUP BY a.date
