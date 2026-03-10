-- Feature Creation
 
-- Discount Amount Feature
 

ALTER TABLE a.amazon
ADD discount_amount FLOAT;

UPDATE a.amazon
SET discount_amount = actual_price - discounted_price;

-- Price Difference Percentage Check

ALTER TABLE a.amazon
ADD calculated_discount int;

UPDATE a.amazon
SET calculated_discount = ((actual_price - discounted_price)/actual_price)*100;

alter table a.amazon
drop column discount_percentage;

ALTER TABLE a.amazon
RENAME COLUMN calculated_discount TO discount_percentage;

-- Price Range Feature

ALTER TABLE a.amazon
ADD price_range varchar(15);

UPDATE a.amazon
SET price_range =
CASE
WHEN discounted_price < 1000 THEN 'Low Price'
WHEN discounted_price BETWEEN 1000 AND 5000 THEN 'Medium Price'
ELSE 'High Price'
END ;

-- Product Popularity Feature


ALTER TABLE a.amazon
ADD popularity_level varchar(50);

UPDATE a.amazon
SET popularity_level =
CASE
WHEN rating_count > 10000 THEN 'Highly Popular'
WHEN rating_count BETWEEN 1000 AND 10000 THEN 'Moderately Popular'
ELSE 'Low Popularity'
END;


-- Rating Category Feature


ALTER TABLE a.amazon
ADD rating_category varchar(15);

update a.amazon
set rating_category =
CASE
WHEN rating >= 4.5 THEN 'Excellent'
WHEN rating BETWEEN 4 AND 4.5 THEN 'Good'
WHEN rating BETWEEN 3 AND 4 THEN 'Average'
ELSE 'Poor'
END ;


-- High Value Deal Feature

ALTER TABLE a.amazon
ADD deal_quality varchar(15);

update a.amazon
set  deal_quality =
CASE
WHEN rating >= 4 AND discount_percentage >= 40
THEN 'Great Deal'
ELSE 'Normal Deal'
END;