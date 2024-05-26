/*
Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.
*/

--my solution
SELECT 
    100.0 * COUNT(customers.address) / COUNT(*) AS shipable_perc
FROM orders
INNER JOIN customers
ON orders.cust_id = customers.id;

/*
SELECT
    100 * SUM(CASE WHEN is_shipable THEN 1 ELSE 0 END) :: NUMERIC / COUNT(*) AS percent_shipable
FROM
    (SELECT
        o.id,
        CASE WHEN address IS NULL THEN False ELSE True END AS is_shipable
    FROM    
        orders o
    INNER JOIN
        customers c
    ON
        o.cust_id = c.id) base
*/