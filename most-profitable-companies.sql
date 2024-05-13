/*
Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.
*/

--my solution
SELECT 
    company, 
    profits
FROM (SELECT
        RANK() OVER(ORDER BY profits DESC) AS rank,
        company,
        profits
      FROM forbes_global_2010_2014) AS a
WHERE rank <= 3;

--stratascratch
SELECT company,
       profit
FROM
  (SELECT *,
          rank() OVER (
                       ORDER BY profit DESC) as rank
   FROM
     (SELECT company,
             sum(profits) AS profit
      FROM forbes_global_2010_2014
      GROUP BY company) sq) sq2
WHERE rank <=3
