/*
Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. If customer had more than one order on a certain day, sum the order costs on daily basis. Output customer's first name, total cost of their items, and the date.
For simplicity, you can assume that every first name in the dataset is unique.
*/

-- my solution

SELECT
    first_name,
    order_date,
    total_cost
FROM (
    SELECT
        RANK() OVER(ORDER BY SUM(total_order_cost) DESC),
        customers.first_name,
        order_date,
        SUM(total_order_cost) AS total_cost
    FROM customers
    INNER JOIN orders
    ON customers.id = orders.cust_id
    WHERE orders.order_date BETWEEN '2019-02-01' AND '2019-05-01'
    GROUP BY customers.first_name, customers.id, order_date
    ORDER BY total_cost DESC
) AS total_cost_grouped
WHERE rank = 1;

-- stratascracth solution (they used cte)

WITH cte AS
  (SELECT first_name,
          cust_id,
          sum(total_order_cost) AS total_order_cost,
          order_date
   FROM orders o
   LEFT JOIN customers c ON o.cust_id = c.id
   WHERE order_date BETWEEN '2019-02-1' AND '2019-05-1'
   GROUP BY first_name,
            cust_id,
            order_date)
SELECT first_name,
       total_order_cost,
       order_date
FROM cte
WHERE total_order_cost =
    (SELECT max(total_order_cost)
     FROM cte)