/*
Write a query that returns the user ID of all users that have created at least one ‘Refinance’ submission and at least one ‘InSchool’ submission.
*/

--my solution
SELECT DISTINCT a.user_id
FROM loans AS a
INNER JOIN (SELECT
                user_id,
                type
            FROM loans
            WHERE type = 'Refinance') AS b
ON a.user_id = b.user_id
WHERE a.type = 'InSchool';

--strata
SELECT user_id
FROM   loans
WHERE  type = 'Refinance'
INTERSECT
SELECT user_id
FROM   loans
WHERE  type = 'InSchool'