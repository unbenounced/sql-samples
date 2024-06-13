
--Find the top 10 users that have traveled the greatest distance. Output their id, name and a total distance traveled.

--eric
SELECT user_id, name, traveled_distance
  FROM (SELECT r.user_id, u.name,
               SUM(r.distance) AS traveled_distance,
               RANK() OVER(ORDER BY SUM(r.distance) DESC) 
          FROM lyft_rides_log AS r
         INNER JOIN lyft_users AS u
            ON r.user_id = u.id
         GROUP BY r.user_id, u.name) AS users_ranked
 WHERE rank <= 10;

 --strata
 SELECT user_id,
       name,
       traveled_distance
FROM
  (SELECT lr.user_id,
          lu.name,
          SUM(lr.distance) AS traveled_distance,
          rank () OVER (
                        ORDER BY SUM(lr.distance) DESC) AS rank
   FROM lyft_users AS lu
   INNER JOIN lyft_rides_log AS lr ON lu.id = lr.user_id
   GROUP BY lr.user_id,
            lu.name
   ORDER BY traveled_distance DESC) sq
WHERE rank <= 10