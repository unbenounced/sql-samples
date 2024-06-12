-- Find all the songs that were top-ranked (at first position) at least once in the past 20 years

--eric 
SELECT DISTINCT song_name
  FROM billboard_top_100_year_end
 WHERE year_rank = 1
  AND year >= EXTRACT(YEAR FROM CURRENT_DATE) - 20;

--strata
SELECT 
  distinct song_name
 FROM billboard_top_100_year_end
 WHERE 
  year_rank = 1 AND
  DATE_PART('year', CURRENT_DATE) - year <= 20