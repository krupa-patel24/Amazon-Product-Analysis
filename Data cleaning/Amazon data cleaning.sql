-- Data cleaning

-- 1.load data

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/amazon.csv'
INTO TABLE a.amazon
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;


-- 2.Understand the data

select count(*) from a.amazon;

desc a.amazon;

select * from a.amazon
limit 20;


-- 3.Data Profiling

-- Unique values check

SELECT COUNT(DISTINCT product_id) FROM a.amazon;

-- Category values

SELECT DISTINCT category FROM a.amazon;

-- Rating distribution
SELECT rating, COUNT(*) 
FROM a.amazon
GROUP BY rating;


-- 4.data transformation
ALTER TABLE a.amazon
ADD main_category VARCHAR(100);

UPDATE a.amazon
SET main_category = SUBSTRING_INDEX(category,'|',1);


-- 5.Duplicate Data Check
select * from (
select *,
row_number() over(partition by product_id order by product_id) as rn
from a.amazon
) t
where rn >1;

DELETE FROM a.amazon
WHERE product_id IN (
    SELECT product_id
    FROM (
        SELECT product_id,
        ROW_NUMBER() OVER(PARTITION BY product_id ORDER BY product_id) AS rn
        FROM a.amazon
    ) t
    WHERE rn > 1
);


-- 6.Manage incorrect value

update a.amazon 
set rating = 1
where rating ='|';


-- 7.Missing Values Check

select * from a.amazon
where product_name = ' ' and product_name is null;

select * from a.amazon
where discounted_price = ' ' and discounted_price is null;

select * from a.amazon
where actual_price = ' ' and actual_price is null;

select * from a.amazon
where discount_percentage = ' ' and discount_percentage is null;

select * from a.amazon
where rating = ' ' and rating is null;

SELECT 
SUM(CASE WHEN rating_count IS NULL THEN 1 ELSE 0 END) AS missing_rating_count
FROM a.amazon;

UPDATE a.amazon
SET rating_count = 0
WHERE rating_count = '' OR rating_count IS NULL;


-- 8. Data Type Cleaning

ALTER TABLE a.amazon
MODIFY discounted_price DECIMAL(10,2);

ALTER TABLE a.amazon
MODIFY rating DECIMAL(10,1);

ALTER TABLE a.amazon
MODIFY actual_price int;

ALTER TABLE a.amazon
MODIFY discount_percentage INT;

ALTER TABLE a.amazon
MODIFY rating_count INT;


-- 9.Remove unwanted symbols


UPDATE a.amazon
SET discounted_price = REPLACE(REPLACE(discounted_price,'₹',''),',','');

UPDATE a.amazon
SET actual_price = REPLACE(REPLACE(actual_price,'₹',''),',','');

UPDATE a.amazon
SET discount_percentage = REPLACE(discount_percentage,'%','');

UPDATE a.amazon
SET rating_count = REPLACE(rating_count,',','');

-- 10. Standardize columns

UPDATE a.amazon
SET main_category = REPLACE(main_category,'&',' & ');

UPDATE a.amazon
SET main_category = 'Office Products'
WHERE main_category = 'OfficeProducts';

UPDATE a.amazon
SET main_category = 'Musical Instruments'
WHERE main_category = 'MusicalInstruments';

UPDATE a.amazon
SET main_category = 'Home Improvement'
WHERE main_category = 'HomeImprovement';

-- 11. Data Validation

-- Rating Validation
select max(rating), min(rating)
from a.amazon;

-- Logical Validation
select * from a.amazon
where actual_price < discounted_price;

-- 12.Outlier Detection

SELECT product_name,category,actual_price
FROM a.amazon
ORDER BY actual_price DESC;

SELECT main_category,
AVG(actual_price) AS avg_price,
MAX(actual_price) AS max_price
FROM a.amazon
GROUP BY main_category;


-- 13. Remove unwanted columns

alter table a.amazon
drop column category;

-- 14.Final Clean Dataset Validation

select count(*) from a.amazon;

select count(distinct(product_id)) from a.amazon;

select * from a.amazon;



