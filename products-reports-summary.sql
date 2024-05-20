/*
Find the number of unique transactions and total sales for each of the product categories in 2017. Output the product categories, number of transactions, and total sales in descending order. The sales column represents the total cost the customer paid for the product so no additional calculations need to be done on the column.
Only include product categories that have products sold.
*/

--my solution
SELECT b.product_category,
       COUNT(DISTINCT a.transaction_id),
       SUM(a.sales) AS total_sales
  FROM wfm_transactions AS a
       INNER JOIN wfm_products AS b
       ON a.product_id = b.product_id
 WHERE date_part('year', a.transaction_date) = 2017
 GROUP BY 1
 ORDER BY total_sales DESC;

 --strata
 SELECT product_category,
     count(distinct transaction_id) AS transactions,
     sum(sales) AS sales
FROM wfm_transactions AS tr
INNER JOIN wfm_products AS pr ON pr.product_id = tr.product_id
WHERE extract(YEAR
            FROM transaction_date) = 2017
GROUP BY product_category
ORDER BY sum(sales) DESC