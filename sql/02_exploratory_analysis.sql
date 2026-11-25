-- Display main table

SELECT *
FROM walmartsalesdata

-- ---------------------------------------------------------------------------
-- ---------------------------------------------------------------------------
-- FEATURE ENGINEERING
-- ---------------------------------------------------------------------------

-- Displaying the Time_of_day in a new column in accordance to the Time presented in the column


SELECT Time,
		CASE WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
			 WHEN Time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
		           ELSE 'Evening'
				   END AS Time_of_date
FROM walmartsalesdata;


-- Adding the column named Time_of_Day

ALTER TABLE walmartsalesdata ADD COLUMN time_of_day VARCHAR(20);

-- Updating the details

UPDATE walmartsalesdata
	SET time_of_day = (
		CASE WHEN Time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
			 WHEN Time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
			 ELSE 'Evening' END )

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

SELECT Product_Line,
	   SUM(Total) as Total_Revenue
FROM walmartsalesdata
GROUP BY Product_line
ORDER BY Total_Revenue DESC LIMIT 1

-- What is the city with the largest revenue?

SELECT City,
	   Branch,
	   SUM(Total) as Total_Revenue
FROM walmartsalesdata
GROUP BY City,Branch
ORDER BY Total_Revenue DESC 


-- What product line had the largest VAT?


-- SELECT Product_line,
-- 	   AVG(VAT) AS Avg_tax
-- FROM walmartsalesdata
-- GROUP BY Product_line


-- Which branch sold more products than average product sold?

SELECT Branch,
	   SUM(Total) as Total_Revenue
FROM walmartsalesData
GROUP BY Branch
HAVING SUM(Total) > (SELECT AVG(quantity) FROM walmartsalesdata)

-- What is the most common product line by gender?

SELECT Gender, 
		Product_Line,
        COUNT(Gender) AS cnt
FROM walmartsalesdata
GROUP BY Gender, Product_Line
ORDER BY cnt DESC

-- What is the average rating of each product line?

SELECT Product_Line,
	   ROUND(AVG(Rating),2)AS Rating
FROM walmartsalesdata
GROUP BY Product_Line
ORDER BY Rating DESC

-- SALES QUESTIONS

-- Number of sales made in each time of the day per weekday

SELECT time_of_day,
	  COUNT(*) AS total_number_of_sales
FROM walmartsalesdata
WHERE Day_of_the_Week = "Sunday"
GROUP BY time_of_day
ORDER BY total_number_of_sales DESC

-- Which of the customer types brings the most revenue?

SELECT Customer_type,
	   ROUND(SUM(Total), 2) as Total_Amount
FROM walmartsalesdata
GROUP BY Customer_type 

-- Which city has the largest tax percent/ VAT (**Value Added Tax**)?

SELECT city,
	   AVG(VAT) as VAT
FROM walmartsalesdata
GROUP BY city
ORDER BY VAT DESC;

-- Which customer type pays the most in VAT?


SELECT Customer_type,
	   AVG(VAT) as VAT
FROM walmartsalesdata
GROUP BY Customer_type
ORDER BY VAT DESC; 


-- CUSTOMER QUESTION
