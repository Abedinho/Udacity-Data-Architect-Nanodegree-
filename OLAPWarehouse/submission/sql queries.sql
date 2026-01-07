CREATE TABLE precipitation (
	date_t DATE,
	precipitation FLOAT,
	precipitation_normal FLOAT);


INSERT INTO precipitation(date_t, precipitation, precipitation_normal)
SELECT TO_DATE(TO_VARCHAR(PRECIPITATION.DATE), 'YYYYMMDD'),
TRY_TO_NUMBER(precipitation),
CAST(precipitation_normal AS FLOAT)
FROM "UDACITYNANODEGREE"."STAGING".PRECIPITATION;

CREATE TABLE temperature (
	date_t DATE,
	min_t INT,
	max_t INT,
	normal_min FLOAT,
	normal_max FLOAT);

INSERT INTO temperature(date_t, min_t, max_t, normal_min, normal_max)
SELECT TO_DATE(TO_VARCHAR(TEMPERATURE.DATE), 'YYYYMMDD'),
CAST(min AS INT),
CAST(max AS INT),
CAST(normal_min AS FLOAT),
CAST(normal_max AS FLOAT)
FROM "UDACITYNANODEGREE"."STAGING".TEMPERATURE;

CREATE TABLE tip (
	business_id STRING,
	compliment_count INTEGER,
	date STRING,
	text STRING,
	user_id STRING);

INSERT INTO tip(business_id, compliment_count, date, text, user_id)
SELECT business_id,
			compliment_count,
			date,
			text,
			user_id
	FROM "UDACITYNANODEGREE"."STAGING".tip;


CREATE TABLE business (
	business_id VARCHAR(200),
	name VARCHAR(100),
	address VARCHAR(200),
	city VARCHAR(200),
	state VARCHAR(10),
	postal_code VARCHAR(20),
	latitude FLOAT,
	longitude FLOAT,
	stars FLOAT,
	review_count NUMBER(38,0),
	is_open NUMBER(38,0),
	attribute VARCHAR,
	categories VARCHAR,
	hours VARCHAR);

INSERT INTO business(business_id,name, address, city, state, postal_code, latitude,longitude,stars, review_count, is_open, attribute, categories, hours)
SELECT business_id,
			name,
			address,
			city,
			state,
			postal_code,
			latitude,
			longitude,
			stars,
			review_count,
			is_open,
			attributes,
			categories,
			hours::STRING
	FROM "UDACITYNANODEGREE"."STAGING".BUSINESS;


CREATE TABLE user (
	average_stars FLOAT,
	compliment_cool NUMBER,
	compliment_cute NUMBER,
	compliment_funny NUMBER,
	compliment_hot NUMBER,
	compliment_list NUMBER,
	compliment_more NUMBER,
	compliment_note NUMBER,
	compliment_photos NUMBER,
	compliment_plain NUMBER,
	compliment_profile NUMBER,
	compliment_writer NUMBER,
	cool NUMBER,
	elite STRING,
	fans NUMBER,
	friends VARCHAR,
	funny NUMBER,
	name VARCHAR,
	review_count NUMBER,
	useful NUMBER,
	user_id VARCHAR,
	yelping_since STRING);


INSERT INTO user(average_stars,compliment_cool,compliment_cute,compliment_funny,compliment_hot,compliment_list,compliment_more,
compliment_note,compliment_photos,compliment_plain,compliment_profile,compliment_writer,cool,elite, fans,friends, funny,name, review_count, useful,user_id,yelping_since)
SELECT average_stars,
	compliment_cool,
	compliment_cute,
	compliment_funny,
	compliment_hot,
	compliment_list,
	compliment_more,
	compliment_note,
	compliment_photos,
	compliment_plain,
	compliment_profile,
	compliment_writer,
	cool,
	elite,
	fans,
	friends,
	funny,
	name,
	review_count,
	useful,
	user_id,
	yelping_since
	FROM "UDACITYNANODEGREE"."STAGING".USER;


CREATE TABLE review(
  business_id VARCHAR,
  cool NUMBER,
  date STRING,
  funny NUMBER,
  review_id VARCHAR,
  stars NUMBER,
  text STRING,
  useful NUMBER,
  user_id VARCHAR);


INSERT INTO review(business_id, cool, date, funny, review_id, stars, text, useful, user_id)
SELECT business_id,
	cool,
	date,
	funny,
	review_id,
	stars,
	text,
	useful,
	user_id
FROM "UDACITYNANODEGREE"."STAGING".REVIEW

CREATE TABLE checkin(
	business_id VARCHAR,
	date STRING);

INSERT INTO checkin(business_id, date)
SELECT business_id,
		date
		FROM "UDACITYNANODEGREE"."STAGING".CHECKIN;


CREATE TABLE covid (
	Call_To_Action_enabled VARCHAR,
	Covid_Banner VARCHAR,
	Grubhub_enabled	VARCHAR,
	Request_a_Quote_Enabled VARCHAR,
	Temporary_Closed_Until	VARCHAR,
	Virtual_Services_Offered VARCHAR,
	business_id VARCHAR,
	delivery_or_takeout VARCHAR,
	highlights VARCHAR);

INSERT INTO covid(Call_To_Action_enabled,Covid_Banner,Grubhub_enabled,Request_a_Quote_Enabled, Temporary_Closed_Until,
Virtual_Services_Offered,business_id,delivery_or_takeout,highlights)
SELECT
	Call_To_Action_enabled,
	Covid_Banner,
	Grubhub_enabled,
	Request_a_Quote_Enabled,
	TEMPORARY_CLOSED_UNTIL,
	Virtual_Services_Offered,
	business_id,
	delivery_or_takeout,
	highlights
FROM "UDACITYNANODEGREE"."STAGING".COVID;

-- modifications for the tables---

ALTER TABLE precipitation RENAME COLUMN date_t TO date_p;
ALTER TABLE business RENAME COLUMN name TO name_business;
ALTER TABLE checkin RENAME COLUMN date TO date_checkin;
ALTER TABLE review RENAME COLUMN date TO date_review;
ALTER TABLE user RENAME COLUMN name TO name_user;
ALTER TABLE tip RENAME COLUMN date TO date_tip;

ALTER TABLE business RENAME COLUMN business_id TO business_id_main;
ALTER TABLE user RENAME COLUMN user_id TO user_id_main;

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

/* CREATE A FACT TABLE*/

CREATE TABLE total_info AS SELECT business_id_main, review_id, user_id_main, date_t, date_p
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

    /*SQL queries code to move data from ODS to DWH*/

CREATE TABLE covid CLONE "UDACITYNANODEGREE"."ODS".COVID ;

CREATE TABLE tip CLONE "UDACITYNANODEGREE"."ODS".TIP;

CREATE TABLE user CLONE "UDACITYNANODEGREE"."ODS".USER ;

CREATE TABLE review CLONE "UDACITYNANODEGREE"."ODS".REVIEW;

CREATE TABLE business CLONE "UDACITYNANODEGREE"."ODS".BUSINESS ;

CREATE TABLE checkin CLONE "UDACITYNANODEGREE"."ODS".CHECKIN ;

CREATE TABLE precipitation CLONE "UDACITYNANODEGREE"."ODS".PRECIPITATION;

CREATE TABLE temperature CLONE "UDACITYNANODEGREE"."ODS".TEMPERATURE;

CREATE TABLE total_info CLONE "UDACITYNANODEGREE"."ODS".total_info;


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
