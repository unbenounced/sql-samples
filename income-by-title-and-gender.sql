/*
Find the average total compensation based on employee titles and gender. Total compensation is calculated by adding both the salary and bonus of each employee. However, not every employee receives a bonus so disregard employees without bonuses in your calculation. Employee can receive more than one bonus.
Output the employee title, gender (i.e., sex), along with the average total compensation.
*/
--my solution
SELECT
    e.employee_title,
    e.sex,
    AVG(bonus + e.salary)
FROM sf_employee AS e
INNER JOIN (SELECT worker_ref_id, SUM(bonus) AS bonus
            FROM sf_bonus
            GROUP BY worker_ref_id) AS b
ON e.id = b.worker_ref_id
GROUP BY e.employee_title, e.sex;

--stratascratch
SELECT e.employee_title,
       e.sex,
       AVG(e.salary + b.ttl_bonus) AS avg_compensation
FROM sf_employee e
INNER JOIN
  (SELECT worker_ref_id,
          SUM(bonus) AS ttl_bonus
   FROM sf_bonus
   GROUP BY worker_ref_id) b ON e.id = b.worker_ref_id
GROUP BY employee_title,
         sex