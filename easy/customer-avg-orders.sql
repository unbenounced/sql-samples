/*
How many customers placed an order and what is the average order amount?
*/

--my solution 
SELECT
    ROUND(AVG(amount)::numeric, 2),
    COUNT(DISTINCT customer_id)
FROM postmates_orders;

--strata
SELECT count(DISTINCT customer_id),
       avg(amount)
FROM postmates_orders