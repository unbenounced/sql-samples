/*
Find songs that have ranked in the top position. Output the track name and the number of times it ranked at the top. Sort your records by the number of times the song was in the top position in descending order.
*/

--my solution
SELECT
    trackname,
    COUNT(*) AS n_topspot
FROM spotify_worldwide_daily_song_ranking
WHERE position = 1
GROUP BY trackname
ORDER BY n_topspot DESC;

/* stratascratch's solution
SELECT
    trackname,
    count(*) AS times_top1
FROM spotify_worldwide_daily_song_ranking
WHERE 
    position = 1
GROUP BY
    trackname
ORDER BY
    times_top1 DESC
*/