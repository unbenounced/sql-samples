/*
How many searches were there in the second quarter of 2021?
*/

--eric
SELECT COUNT(*) AS n_searches
  FROM fb_searches
 WHERE EXTRACT(QUARTER FROM date) = 2
   AND DATE_TRUNC('year', date) = '2021-01-01';

--strata
SELECT count(search_id) AS RESULT
FROM fb_searches
WHERE extract(QUARTER
              FROM date) = 2
  AND extract(YEAR
              FROM date) = 2021