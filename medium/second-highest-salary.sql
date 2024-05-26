/*
Find the second highest salary of employees.
*/

--my solution
SELECT 
    MAX(salary) AS rank_2nd
FROM employee
WHERE salary NOT IN (SELECT MAX(salary)
                     FROM employee);


--stratascratch
SELECT DISTINCT salary
FROM
  (SELECT salary,
          DENSE_RANK() OVER (
                             ORDER BY salary DESC) AS rank_
   FROM employee) A
WHERE rank_ = 2;
