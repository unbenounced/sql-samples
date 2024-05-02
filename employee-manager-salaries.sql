/*
Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.
*/

--my solution
SELECT
    e.first_name AS higher_pay_than_manager,
    e.salary
FROM employee AS e
INNER JOIN employee AS m
ON e.manager_id = m.id
WHERE e.salary > m.salary;

--stratascratch 
SELECT
        a.first_name AS employee_name, 
        a.salary AS employee_salary
FROM employee AS a 
JOIN employee AS b ON  a.manager_id = b.id
WHERE a.salary > b.salary;