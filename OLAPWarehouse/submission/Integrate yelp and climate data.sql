/*integrate climate and Yelp Data*/

SELECT *
	FROM precipitation AS p
	JOIN review AS r
	ON r.date_review = p.date_p
	JOIN temperature AS t
	ON t.date_t = r.date_review
	JOIN business AS b
	ON b.business_id_main = r.business_id
    JOIN covid AS c
	ON b.business_id_main = c.business_id
	JOIN checkin AS ch
	ON b.business_id_main = ch.business_id
	JOIN tip AS x
	ON b.business_id_main = x.business_id
    JOIN user AS u
    ON u.user_id_main = r.user_id;
