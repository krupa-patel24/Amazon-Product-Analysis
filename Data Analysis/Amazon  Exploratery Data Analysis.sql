-- Exploratery Data Analysis

-- Category Distribution

select * from a.amazon;

select main_category,count(*) as total_category
from a.amazon
group by main_category
order by total_category desc;

-- Average Rating by Category

select main_category,
round(avg(rating),1) as avg_rate
from a.amazon
group by main_category
order by avg_rate desc;

-- Most Reviewed Products

SELECT 
product_name,
rating_count
FROM a.amazon
ORDER BY rating_count DESC
LIMIT 10;

-- Highest Rated Products

SELECT 
product_name,
rating
FROM a.amazon
ORDER BY rating DESC
LIMIT 10;

-- Discount Analysis

SELECT 
main_category,
AVG(discount_percentage) AS avg_discount
FROM a.amazon
GROUP BY main_category
ORDER BY avg_discount DESC;

-- Price Range Distribution

SELECT 
price_range,
COUNT(*) AS total_products
FROM a.amazon
GROUP BY price_range;

-- Price vs Rating

SELECT 
price_range,
AVG(rating) AS avg_rating
FROM a.amazon
GROUP BY price_range;


-- Price vs Rating count

SELECT 
price_range,
AVG(rating_count) AS avg_reviews
FROM a.amazon
GROUP BY price_range;


-- Best Deals

select * from a.amazon;

SELECT 
product_name,
rating,
discount_percentage
FROM a.amazon
WHERE rating >= 4.3
ORDER BY discount_percentage DESC
LIMIT 10;

-- Popularity Analysis

SELECT 
popularity_level,
COUNT(*)
FROM a.amazon
GROUP BY popularity_level;

-- Rating Distribution

SELECT 
rating_category,
COUNT(*) as total
FROM a.amazon
GROUP BY rating_category;

-- Top Categories by Revenue Potential

SELECT 
main_category,
AVG(discounted_price) AS avg_price
FROM a.amazon
GROUP BY main_category
ORDER BY avg_price DESC;