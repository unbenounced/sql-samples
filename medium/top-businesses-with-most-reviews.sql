/*
Find the top 5 businesses with most reviews. Assume that each row has a unique business_id such that the total reviews for each business is listed on each row. Output the business name along with the total number of reviews and order your results by the total reviews in descending order.
*/

--my solution
SELECT
    name,
    review_count
FROM (SELECT name, review_count, RANK() OVER(ORDER BY review_count DESC)
      FROM yelp_business) AS total_reviews
WHERE rank <= 5;

/* stratascratch solution

SELECT name,
       review_count
FROM yelp_business
WHERE business_id in
    (SELECT business_id
     FROM
       (SELECT business_id,
               rank() OVER (
                            ORDER BY review_count DESC)
        FROM yelp_business) sq
     WHERE rank <=5)
ORDER BY review_count DESC
*/