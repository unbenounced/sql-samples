/*
You have been asked to find the job titles of the highest-paid employees.


Your output should include the highest-paid title or multiple titles with the same salary.
*/

--my solution 
SELECT
    b.worker_title
FROM worker AS a
INNER JOIN title AS b
ON a.worker_id = b.worker_ref_id
WHERE a.salary = (SELECT MAX(salary)
                  FROM worker);

--stratascratch
SELECT *
FROM
  (SELECT CASE
              WHEN salary =
                     (SELECT max(salary)
                      FROM worker) THEN worker_title
          END AS best_paid_title
   FROM worker a
   INNER JOIN title b ON b.worker_ref_id=a.worker_id
   ORDER BY best_paid_title) sq
WHERE best_paid_title IS NOT NULL