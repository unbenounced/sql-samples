/*
Find matching hosts and guests pairs in a way that they are both of the same gender and nationality.
Output the host id and the guest id of matched pair.
*/

--my solution
SELECT DISTINCT
    h.host_id,
    g.guest_id
FROM airbnb_hosts AS h
INNER JOIN airbnb_guests AS g
ON h.nationality = g.nationality AND
   h.gender = g.gender;

--stratascratch
SELECT DISTINCT h.host_id,
                g.guest_id
FROM airbnb_hosts h
INNER JOIN airbnb_guests g ON h.nationality = g.nationality
AND h.gender = g.gender