-- Display main table

SELECT *
FROM walmartsalesdata

-- FEATURE ENGINEERING---------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------------

-- Displaying the Time_of_day in a new column in accordance to the Time presented in the column


SELECT Time, (CASE WHEN 'Time' BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
				   WHEN 'Time' BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		           ELSE "EVENING"
				   END)
                AS Time_of_data
FROM walmartsalesdata;


-- Adding the column named Time_of_Day

ALTER TABLE walmartsalesdata ADD COLUMN time_of_day VARCHAR(20);

-- Updating the details

UPDATE walmartsalesdata
	SET time_of_day = (CASE 
				WHEN 'Time' BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
				WHEN 'Time' BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
                ELSE "EVENING"
                END )

-- ----------------------------------------------------------------------------------------

-- Displaying the day of the week in a new column in accordance to the date presented in the column

SELECT Date,
	DAYNAME(Date)
FROM walmartsalesdata

-- Adding the column named Day_of_the week
ALTER TABLE walmartsalesdata ADD COLUMN Day_of_the_Week VARCHAR(10);
    
-- Updating the column name
UPDATE walmartsalesdata
	SET Day_of_the_Week = DAYNAME(Date)

-- ----------------------------------------------------------------------------------------

-- Displaying the Month in a new column in accordance to the date presented in the column

SELECT Date,
	MONTHNAME(Date)
FROM walmartsalesdata

-- Adding the column named Month
ALTER TABLE walmartsalesdata ADD COLUMN Month VARCHAR(20);
    
-- Updating the column name 
UPDATE walmartsalesdata
	SET Month = MONTHNAME(Date)
    
    
-- ------------------------------Exploratory Data Analysis - Business Questions

-- How many unique cities does the data have?

SELECT DISTINCT(City)
FROM walmartsalesdata

-- In which city is which branch?

SELECT DISTINCT(City), branch
FROM walmartsalesdata  



-- PRODUCT QUESTIONS
-- How many unique products does the data have?

SELECT DISTINCT(Product_line)
FROM walmartsalesdata

-- What is most common payment method?
Product_line
SELECT COUNT(payment) as cnt, payment
FROM walmartsalesdata
GROUP BY payment 
ORDER BY cnt DESC LIMIT 1


-- What is the most selling product?

SELECT COUNT(Product_line) as cnt, Product_line
FROM walmartsalesdata
GROUP BY Product_line 
ORDER BY cnt DESC 

-- What is the total revenue by month?

SELECT Month, SUM(Total) as Total_amount
FROM walmartsalesdata
GROUP BY Month
ORDER BY Total_amount DESC 

-- What months had the largest COGS?

SELECT Month,
	   SUM(cogs) as Cost_of_Goods_Sold
FROM walmartsalesdata
GROUP BY Month
ORDER BY Cost_of_Goods_Sold DESC

-- Which product line had the largest revenue?



                