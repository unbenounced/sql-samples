/* 
Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.
*/

--my solution 
SELECT 
    department,
    first_name,
    salary
FROM (SELECT 
        RANK() OVER(PARTITION BY department ORDER BY salary DESC),
        department,
        first_name,
        salary
      FROM employee) AS sal_ranked
WHERE rank = 1;

--stratascratch's solution
 SELECT
    department AS department,
    first_name AS employee_name,
    salary
FROM employee
WHERE (department , salary) IN
        (SELECT 
                        department, 
                        MAX(salary)
        FROM employee         
        GROUP BY department
        ); 