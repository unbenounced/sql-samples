/*
Identify projects that are at risk for going overbudget. A project is considered to be overbudget if the cost of all employees assigned to the project is greater than the budget of the project.


You'll need to prorate the cost of the employees to the duration of the project. For example, if the budget for a project that takes half a year to complete is $10K, then the total half-year salary of all employees assigned to the project should not exceed $10K. Salary is defined on a yearly basis, so be careful how to calculate salaries for the projects that last less or more than one year.


Output a list of projects that are overbudget with their project name, project budget, and prorated total employee expense (rounded to the next dollar amount).


HINT: to make it simpler, consider that all years have 365 days. You don't need to think about the leap years.
*/

--my solution
  SELECT 
        p.title,
        p.budget,
        CEILING(SUM(((p.end_date - p.start_date) / 365.0) * le.salary)) AS employee_expenses
    FROM linkedin_projects AS p
    INNER JOIN linkedin_emp_projects AS e
    ON p.id = e.project_id
    INNER JOIN linkedin_employees AS le
    ON le.id = e.emp_id
    GROUP BY p.title, p.budget
    HAVING SUM(((p.end_date - p.start_date) / 365.0) * le.salary) > p.budget
    ORDER BY p.title;

--stratascratch
SELECT title,
       budget,
       ceiling(prorated_expenses) AS prorated_employee_expense
FROM
  (SELECT title,
          budget,
          (end_date::date - start_date::date) * (sum(salary)/365) AS prorated_expenses
   FROM linkedin_projects a
   INNER JOIN linkedin_emp_projects b ON a.id = b.project_id
   INNER JOIN linkedin_employees c ON b.emp_id=c.id
   GROUP BY title,
            budget,
            end_date,
            start_date) a
WHERE prorated_expenses > budget
ORDER BY title ASC