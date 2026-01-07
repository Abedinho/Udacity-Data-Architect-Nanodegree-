/*SQL queries code that report business name, temperature, precipitation, ratings*/

SELECT name_business, min_t, max_t, normal_min, normal_max, precipitation, precipitation_normal, r.stars
FROM business AS b
JOIN total_info AS tot
ON b.business_id_main = tot.business_id_main
JOIN temperature AS t
ON t.date_t = tot.date_t
JOIN precipitation AS p
ON p.date_p = tot.date_p
JOIN review AS r
ON r.review_id = tot.review_id;
