
SELECT * FROM BUSI.PUBLIC.SALES;

--DATA CLEANING

-- checking for NULL values

SELECT * FROM Sales
WHERE sales IS NULL OR cost_Of_Sales IS NULL OR quantity_sold IS NULL;

--checking duplicates

SELECT Date, sales, cost_Of_Sales, quantity_sold, COUNT(*)
FROM sales
GROUP BY Date, sales, cost_Of_Sales, quantity_sold
HAVING COUNT(*) > 1;


--date

SELECT MIN(date),
       MAX(date)
FROM sales;  

--num of sales

SELECT COUNT(sales)
FROM sales;


--Inividual Calculations

--Daily Sales Price per Unit
   

SELECT 
    REPLACE(ROUND(sales / quantity_sold, 2), '.', ',') AS sales_price_per_unit
FROM sales;


--Average Unit Sales Price

SELECT 
    ROUND(SUM(sales) / SUM(quantity_sold), 2 ) AS avg_sales_price
FROM sales;



--Daily % Gross Profit

SELECT 
    TO_DATE(date, 'DD/MM/YYYY') AS Date, 
    ROUND(((sales - cost_of_sales) / sales) * 100, 2) AS gross_profit_percentage
FROM sales;

--Daily % Gross Profit per Unit

SELECT 
    TO_DATE(date, 'DD/MM/YYYY') AS Date, 
    ROUND((sales - cost_of_sales) / quantity_sold, 2) AS gross_profit_per_unit
FROM sales;

--All calculations

SELECT 
    TO_DATE(date, 'DD/MM/YYYY') AS Date,
    quantity_sold,
    REPLACE(CAST(ROUND(SUM(Sales), 2) AS VARCHAR), '.', ',') AS Sales,
    REPLACE(CAST(ROUND(SUM(Cost_Of_Sales), 2) AS VARCHAR), '.', ',') AS Cost_of_sales,
    REPLACE(CAST(ROUND(SUM(sales) / SUM(quantity_sold), 2) AS VARCHAR), '.', ',') AS daily_sales_price_per_unit,
    REPLACE(CAST(ROUND(((SUM(sales) - SUM(cost_of_sales)) / SUM(sales)) * 100, 2) AS VARCHAR), '.', ',') AS daily_gross_profit,
    REPLACE(CAST(ROUND((SUM(sales) - SUM(cost_of_sales)) / SUM(quantity_sold), 2) AS VARCHAR), '.', ',') AS daily_gross_profit_per_unit 
FROM sales
GROUP BY quantity_sold, date;

--
--Average Unit Sales Price

SELECT 
    REPLACE(CAST(ROUND(SUM(sales) / SUM(quantity_sold), 2 ) AS VARCHAR), '.',',') AS avg_sales_price
FROM sales;

--


REPLACE(CAST(ROUND(SUM(sales) / SUM(quantity_sold), 2) AS VARCHAR), '.', ',') AS daily_sales_price_per_unit,

--Calculating Price elasticity demanded

SELECT 
    TO_DATE(date, 'DD/MM/YYYY') AS Date_1,
    SUM(quantity_sold) AS total_quantity_sold,
    -- REPLACE(CAST(ROUND(SUM(sales),2) AS VARCHAR), '.',',') AS total_sales,
    -- REPLACE(CAST(ROUND(SUM(cost_of_sales), 2) AS VARCHAR), '.',',') AS total_cost_of_sales,
    REPLACE(CAST(ROUND(SUM(sales) / SUM(quantity_sold), 2) AS VARCHAR), '.', ',') AS daily_sales_price_per_unit
FROM sales
WHERE TO_DATE(date, 'DD/MM/YYYY') BETWEEN '2014-02-18' AND '2014-03-09'
   OR TO_DATE(date, 'DD/MM/YYYY') BETWEEN '2014-08-25' AND '2014-09-18'
   OR TO_DATE(date, 'DD/MM/YYYY') BETWEEN '2014-09-27' AND '2014-10-19'
GROUP BY TO_DATE(date, 'DD/MM/YYYY')
ORDER BY Date_1;
