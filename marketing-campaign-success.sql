/*
You have a table of in-app purchases by user. Users that make their first in-app purchase are placed in a marketing campaign where they see call-to-actions for more in-app purchases. Find the number of users that made additional in-app purchases due to the success of the marketing campaign.


The marketing campaign doesn't start until one day after the initial in-app purchase so users that only made one or multiple purchases on the first day do not count, nor do we count users that over time purchase only the products they purchased on the first day.
*/

--my solution
SELECT COUNT(DISTINCT c.user_id)
FROM marketing_campaign AS c
LEFT JOIN (SELECT
    a.user_id, 
    a.created_at,
    a.product_id
FROM marketing_campaign AS a
INNER JOIN (
            SELECT
                *
            FROM (SELECT 
                    user_id,
                    created_at,
                    product_id,
                    RANK() OVER(PARTITION BY user_id ORDER BY created_at ASC)
                  FROM marketing_campaign) AS rmc
            WHERE rank = 1  ) AS b
ON a.user_id = b.user_id
AND a.product_id = b.product_id) AS d
ON c.user_id = d.user_id AND c.created_at = d.created_at AND c.product_id = d.product_id
WHERE d.user_id IS NULL;

--stratascratch
SELECT count(DISTINCT user_id)
FROM marketing_campaign
WHERE user_id in
    (SELECT user_id
     FROM marketing_campaign
     GROUP BY user_id
     HAVING count(DISTINCT created_at) >1
     AND count(DISTINCT product_id) >1)
  AND concat((user_id),'_', (product_id)) not in
    (SELECT user_product
     FROM
       (SELECT *,
               rank() over(PARTITION BY user_id
                           ORDER BY created_at) AS rn,
               concat((user_id),'_', (product_id)) AS user_product
        FROM marketing_campaign) x
     WHERE rn = 1 )