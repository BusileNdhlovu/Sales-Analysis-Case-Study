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
    REPLACE(CAST(ROUND(SUM(Sales), 2) AS VARCHAR), '.', ',') AS Sales_Formatted,
    REPLACE(CAST(ROUND(SUM(Cost_Of_Sales), 2) AS VARCHAR), '.', ',') AS Cost_Formatted,
    REPLACE(CAST(ROUND(SUM(sales) / SUM(quantity_sold), 2) AS VARCHAR), '.', ',') AS sales_price_per_unit,
    REPLACE(CAST(ROUND(((SUM(sales) - SUM(cost_of_sales)) / SUM(sales)) * 100, 2) AS VARCHAR), '.', ',') AS gross_profit_percentage,
    REPLACE(CAST(ROUND((SUM(sales) - SUM(cost_of_sales)) / SUM(quantity_sold), 2) AS VARCHAR), '.', ',') AS gross_profit_per_unit  
FROM sales
GROUP BY Date;

--
--Average Unit Sales Price

SELECT 
    REPLACE(CAST(ROUND(SUM(sales) / SUM(quantity_sold), 2 ) AS VARCHAR), '.',',') AS avg_sales_price
FROM sales;
