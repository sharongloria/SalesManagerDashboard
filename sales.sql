-- create Database 
CREATE DATABASE sales;

-- use the DB
USE sales;

-- view tables
SELECT *
FROM fact_internetsales i
join dim_calendar cu
on i.OrderDateKey = cu.DateKey
LIMIT 20;

-- change column names
ALTER TABLE fact_internetsales
CHANGE ï»¿ProductKey ProductKey INT;
ALTER TABLE dim_products
CHANGE ï»¿ProductKey ProductKey INT;
ALTER TABLE dim_customers
CHANGE ï»¿CustomerKey CustomerKey INT;
ALTER TABLE dim_calendar
CHANGE ï»¿DateKey DateKey INT;

-- find gender with highest sales
SELECT c.Gender, sum(i.SalesAmount) as Total_Sales
FROM dim_customers c
JOIN fact_internetsales i
ON c.CustomerKey = i.CustomerKey
WHERE fact_internetsales
GROUP BY c.Gender;

-- find sales in 2019 and 2020 from different cities
WITH CitySales AS(
SELECT c.`Customer City` as City, round(sum(i.SalesAmount),2) as Sales_2020
FROM dim_customers c
JOIN fact_internetsales i
ON c.CustomerKey = i.CustomerKey
JOIN dim_calendar cal
ON cal.DateKey = i.OrderDateKey
WHERE cal.Year = 2020
GROUP BY c.`Customer City`
), 
CitySales1 AS(
SELECT c.`Customer City` as City, round(sum(i.SalesAmount),2)  as Sales_2019
FROM dim_customers c
JOIN fact_internetsales i
ON c.CustomerKey = i.CustomerKey
JOIN dim_calendar cal
ON cal.DateKey = i.OrderDateKey
WHERE cal.Year = 2019
GROUP BY c.`Customer City`
)
SELECT sal.City, sal.Sales_2019, sa.Sales_2020
FROM CitySales sa
JOIN CitySales1 sal
ON sal.City = sa.City
ORDER BY sal.City;

SELECT *
FROM CitySales


