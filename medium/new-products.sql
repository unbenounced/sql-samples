/*
You are given a table of product launches by company by year. Write a query to count the net difference between the number of products companies launched in 2020 with the number of products companies launched in the previous year. Output the name of the companies and a net difference of net products released for 2020 compared to the previous year.
*/

--my solution
SELECT
    r_2020.company_name,
    r_2020.n_releases - r_2019.n_releases AS net_differences
FROM (SELECT 
        year,
        company_name,
        COUNT(*) AS n_releases
      FROM car_launches
      WHERE year = 2020
      GROUP BY year, company_name) AS r_2020
INNER JOIN (SELECT 
              year,
              company_name, 
              COUNT(*) AS n_releases
            FROM car_launches
            WHERE year = 2019
            GROUP BY year, company_name) AS r_2019
ON r_2019.company_name = r_2020.company_name;

--stratascratch
SELECT a.company_name,
       (count(DISTINCT a.brand_2020)-count(DISTINCT b.brand_2019)) net_products
FROM
  (SELECT company_name,
          product_name AS brand_2020
   FROM car_launches
   WHERE YEAR = 2020) a
FULL OUTER JOIN
  (SELECT company_name,
          product_name AS brand_2019
   FROM car_launches
   WHERE YEAR = 2019) b ON a.company_name = b.company_name
GROUP BY a.company_name
ORDER BY company_name