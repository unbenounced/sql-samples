/*--Rank guests based on the total number of messages they've exchanged with any of the hosts. Guests with the same number of messages as other guests should have the same rank. Do not skip rankings if the preceding rankings are identical.
Output the rank, guest id, and number of total messages they've sent. Order by the highest number of total messages first.
*/

--my solution
SELECT 
    DENSE_RANK() OVER(ORDER BY SUM(n_messages) DESC) AS ranking,
    id_guest,
    SUM(n_messages) AS n_messages
FROM airbnb_contacts
GROUP BY id_guest;

--stratascratch
SELECT 
    DENSE_RANK() OVER(ORDER BY sum(n_messages) DESC) as ranking, 
    id_guest, 
    sum(n_messages) as sum_n_messages
FROM airbnb_contacts
GROUP BY id_guest
ORDER BY sum_n_messages DESC