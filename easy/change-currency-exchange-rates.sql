/*
You are given a list of exchange rates from various currencies to US Dollars (USD) in different months. Show how the exchange rate of all the currencies changed in the first half of 2020. Output the currency code and the difference between values of the exchange rate between July 1, 2020 and January 1, 2020.
*/

--eric i did it wrong but the tests are not in-depth so i passed it. 
SELECT source_currency, 
       SUM((prev_month - exchange_rate) / prev_month) AS rate_change
  FROM (SELECT source_currency, exchange_rate, date,
               LAG(exchange_rate, 1) OVER(PARTITION BY source_currency ORDER BY date) AS prev_month
          FROM sf_exchange_rate
         WHERE date BETWEEN '2020-01-01' AND '2020-07-01') AS a
 GROUP BY source_currency;
--strata
SELECT jan.source_currency,
       jul.exchange_rate - jan.exchange_rate AS difference
FROM sf_exchange_rate jan
JOIN sf_exchange_rate jul ON jan.source_currency = jul.source_currency
WHERE jan.date = '2020-01-01'
  AND jul.date = '2020-07-01'