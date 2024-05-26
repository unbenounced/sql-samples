/*
Make a report showing the number of survivors and non-survivors by passenger class

Make a report showing the number of survivors and non-survivors by passenger class.
Classes are categorized based on the pclass value as:
pclass = 1: first_class
pclass = 2: second_classs
pclass = 3: third_class
Output the number of survivors and non-survivors by each class.
*/

/*The use of pivot*/

--My solution 
SELECT
    survived,
    COUNT(CASE WHEN pclass = 1 THEN survived END) AS first_class,
    COUNT(CASE WHEN pclass = 2 THEN survived END) AS second_class,
    COUNT(CASE WHEN pclass = 3 THEN survived END) AS third_class
FROM titanic
GROUP BY survived;

--stratascratch solution
SELECT
    survived,
    sum(CASE WHEN pclass = 1 THEN 1 ELSE 0 END) AS first_class,
    sum(CASE WHEN pclass = 2 THEN 1 ELSE 0 END) AS second_class,
    sum(CASE WHEN pclass = 3 THEN 1 ELSE 0 END) AS third_class
FROM titanic
GROUP BY 
    survived