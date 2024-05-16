--1. How many unique cities does the data have?
Select DISTINCT city
from [dbo].[WalmartSalesData.csv];

--2. In which city is each branch?
SELECT COUNT(BRANCH) AS BRANCHES_IN_EACH_CITY
FROM [dbo].[WalmartSalesData.csv]
GROUP BY City;

/****************** PRODUCT ******************/

--1. How many unique product lines does the data have?
SELECT DISTINCT Product_line as Unique_Product_line
from [dbo].[WalmartSalesData.csv];

--2. What is the most common payment method?
SELECT top 1 Payment
FROM [dbo].[WalmartSalesData.csv]
GROUP BY Payment
ORDER BY COUNT(Payment) DESC;

--3. What is the most selling product line?
select top 1 Product_line,count(product_line) as Most_selling_Product
from [dbo].[WalmartSalesData.csv]
group by Product_line
ORDER BY Product_line DESC;

--4. What is the total revenue by month?
select Month(Date) AS Month,
sum(Unit_price * Quantity) AS Revenue
from [dbo].[WalmartSalesData.csv]
group by Month(Date)
order by Month;

--5. What month had the largest COGS?
select top 1 month(Date) as month,
SUM(cogs)
from [dbo].[WalmartSalesData.csv]
group by month(Date)
order by SUM(cogs) DESC;

--6. What product line had the largest revenue?
select top 1 Product_line,SUM(Unit_price * Quantity) as Revenue
from [dbo].[WalmartSalesData.csv]
group by Product_line
order by Revenue DESC;

--7. What is the city with the largest revenue?
select top 1 city,sum(Unit_price * Quantity) as Revenue
from [dbo].[WalmartSalesData.csv]
group by city
order by Revenue;

--8. What product line had the largest VAT?
SELECT TOP 1 Product_line,MAX(Tax_5)
from [dbo].[WalmartSalesData.csv]
group by Product_line
order by MAX(Tax_5) DESC;

/*9. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater
than average sales*/
SELECT 
    Product_line,
    AVG(Unit_price * Quantity) AS Average_sales,
    CASE 
        WHEN AVG(Unit_price * Quantity) > (SELECT AVG(Unit_price * Quantity) FROM [dbo].[WalmartSalesData.csv]) THEN 'Good'
        ELSE 'Bad'
    END AS Category
FROM 
   [dbo].[WalmartSalesData.csv]
GROUP BY 
    Product_line;
	--AVERAGE
SELECT AVG(Unit_price * Quantity) AS SALES_AVG
from  [dbo].[WalmartSalesData.csv];

--10.Which branch sold more products than average product sold?
SELECT TOP 1 BRANCH,AVG(Unit_price * Quantity)
from  [dbo].[WalmartSalesData.csv]
group by Branch
order by AVG(Unit_price * Quantity) DESC;

--11.What is the most common product line by gender?
SELECT max(Product_line),Gender
from [dbo].[WalmartSalesData.csv]
group by Gender
order by max(Product_line) DESC;

--12. What is the average rating of each product line?
SELECT Product_line,avg(Rating) as Avg_rating
from [dbo].[WalmartSalesData.csv]
group by Product_line;


------Sales--------
--1. Number of sales made in each time of the day per weekday
SELECT 
    (Unit_price * Quantity) as sale,
    DATENAME(WEEKDAY, sale) AS weekday,
    DATEPART(HOUR, sale) AS hour_of_day,
    COUNT(*) AS num_sales
FROM 
    [dbo].[WalmartSalesData.csv]
GROUP BY 
    DATENAME(WEEKDAY, sale),
    DATEPART(HOUR, sale)
ORDER BY 
    DATENAME(WEEKDAY, sale),
    DATEPART(HOUR, sale);

--2Which of the customer types brings the most revenue?
select top 1 Customer_type,sum(Unit_price * Quantity) as Revenue
from [dbo].[WalmartSalesData.csv]
group by  Customer_type
order by Revenue DESC;

--3Which city has the largest tax percent/ VAT (Value Added Tax)?
select top 1
City,
sum(0.5*cogs) as VAT 
from [dbo].[WalmartSalesData.csv]
GROUP BY City
ORDER BY VAT desc;

--4.Which customer type pays the most in VAT?
select top 1
Customer_type,
sum(0.5*Unit_price*Quantity) as VAT
from [dbo].[WalmartSalesData.csv]
GROUP BY Customer_type
ORDER BY VAT desc;

/***********Customer***********/
--1How many unique customer types does the data have?
select distinct Customer_type
from [dbo].[WalmartSalesData.csv]

--2.How many unique payment methods does the data have?
select distinct Payment
from [dbo].[WalmartSalesData.csv]

--3.What is the most common customer type?
select
Customer_type,
count(*) as most_customer_type
from [dbo].[WalmartSalesData.csv]
group by Customer_type
order by count(*) desc;

--4.Which customer type buys the most?
SELECT 
Customer_type,
count(Payment) as customer_type_buys_the_most
from [dbo].[WalmartSalesData.csv]
group by Customer_type
order by count(Payment) desc;

--5.What is the gender of most of the customers?
select 
Gender,
count(*) as Most_gender_customer
from [dbo].[WalmartSalesData.csv]
group by Gender
order by count(*) desc;

--6.What is the gender distribution per branch?
select Gender,
Branch,
count(*) as Gender_Distribution_Per_branch
from [dbo].[WalmartSalesData.csv]
group by Gender,Branch
order by Gender,Branch;

--7.Which time of the day do customers give most ratings?
SELECT top 1
Time,
COUNT(*) AS customers_give_most_ratings
FROM [dbo].[WalmartSalesData.csv]
GROUP BY Time
ORDER BY customers_give_most_ratings DESC;


--8.Which time of the day do customers give most ratings per branch?
SELECT
Time,
Branch,
COUNT(*) AS customers_give_most_ratings
FROM [dbo].[WalmartSalesData.csv]
GROUP BY Time,Branch
ORDER BY customers_give_most_ratings DESC;


--9.Which day of the week has the best avg ratings?

SELECT DATENAME(weekday, Date) AS weekday,
       AVG(Rating) AS Avg_rating
FROM [dbo].[WalmartSalesData.csv]
GROUP BY DATENAME(weekday, Date)
ORDER BY Avg_rating DESC;

--10.Which day of the week has the best average ratings per branch?

SELECT DATENAME(weekday, Date) AS weekday,
Branch,
AVG(Rating) AS Avg_rating
FROM [dbo].[WalmartSalesData.csv]
GROUP BY DATENAME(weekday, Date),Branch
ORDER BY Avg_rating DESC;

select top 1 * 
from [dbo].[WalmartSalesData.csv]
offset 1 row
FETCH NEXT 1 ROWS ONLY;

SELECT TOP 1 * 
FROM [dbo].[WalmartSalesData.csv]
ORDER BY Branch
OFFSET 1 ROW
FETCH NEXT 1 ROWS ONLY;



/************************************CONCLUSION***********************************************************/
/* By dealing with the walmart data, I had learnt the How to write a realtime query and how to import the 
flatted files like csv,doc,xlsx files
the walmart data had done tasks like retrieving the Profit of the company,How many types of customer and
Branches.
I came to know how to use the primary keys, Unique keys in practical of using this Walmart Data.

/**************************************THANK YOU***********************************************************/

