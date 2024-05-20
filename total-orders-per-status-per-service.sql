/*
Uber is interested in identifying gaps in their business. Calculate the count of orders for each status of each service. Your output should include the service name, status of the order, and the number of orders.
*/

--my solution
SELECT service_name, status_of_order,
       SUM(number_of_orders)
  FROM uber_orders
 GROUP BY status_of_order, service_name;

--strata
SELECT service_name,
       status_of_order,
       sum(number_of_orders) AS orders_sum
FROM uber_orders
GROUP BY service_name,
         status_of_order