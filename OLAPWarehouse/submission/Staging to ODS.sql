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
