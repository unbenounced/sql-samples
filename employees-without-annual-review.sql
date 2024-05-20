/*
Return all employees who have never had an annual review. Your output should include the employee's first name, last name, hiring date, and termination date. List the most recently hired employees first.
*/

--my solution
SELECT first_name, last_name, hire_date, termination_date
  FROM uber_employees
 WHERE id NOT IN 
       (SELECT emp_id
        FROM uber_annual_review)
 ORDER BY hire_date DESC;

 --strata
 SELECT first_name,
       last_name,
       hire_date,
       termination_date
FROM uber_employees
WHERE id not in
    (SELECT DISTINCT emp_id
     FROM uber_annual_review)
ORDER BY hire_date desc