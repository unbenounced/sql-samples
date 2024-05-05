/*
Find the Olympics with the highest number of athletes. The Olympics game is a combination of the year and the season, and is found in the 'games' column. Output the Olympics along with the corresponding number of athletes.
*/

--my solution
SELECT 
    game,
    n_athletes
FROM (SELECT
        games AS game,
        COUNT(DISTINCT name) AS n_athletes, 
        RANK() OVER(ORDER BY COUNT(*) DESC)
FROM olympics_athletes_events
GROUP BY games) AS athletes_per_game
WHERE rank = 1;

/* stratascratch's solution
WITH subquery AS
  (SELECT games,
          count(DISTINCT id) AS athletes_count
   FROM olympics_athletes_events
   GROUP BY games
   ORDER BY athletes_count DESC)
SELECT *
FROM subquery
WHERE athletes_count =
    (SELECT max(athletes_count)
     FROM subquery)
*/