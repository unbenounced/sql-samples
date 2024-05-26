/*
You have been asked to get a list of all the sign up IDs with transaction start dates in either April or May.


Since a sign up ID can be used for multiple transactions only output the unique ID.


Your output should contain a list of non duplicated sign-up IDs.
*/

--my solution
SELECT DISTINCT
    signup_id
FROM transactions
WHERE date_part('month', transaction_start_date) = 4
      OR date_part('month', transaction_start_date) = 5;

--strata
SELECT DISTINCT signup_id
FROM transactions
WHERE EXTRACT(MONTH
              FROM transaction_start_date) IN (4,
                                               5);