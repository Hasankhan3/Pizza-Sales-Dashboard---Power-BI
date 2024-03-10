use pizza_sales;
select * from pizza_sales;
-- KPI
SELECT COUNT(*) FROM pizza_sales;
-- total revenue
select sum(total_price) as Total_Revenue from pizza_sales;
-- average order values.
select sum(total_price)/count(distinct order_id) AS Average_order_values from pizza_sales;
-- total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;
-- total_orders
select count(distinct order_id) as total_orders from pizza_sales;
-- Average Pizzas Per Order 
select cast(cast(sum(quantity) as decimal (10,2)) /
cast(count(distinct  order_id) as decimal(10,2)) as decimal (10,2)) as avg_pizza_per_order from pizza_sales;

-- CHART REQUIREMENT
select * from pizza_sales;

-- changing data type of order_date

ALTER TABLE pizza_sales
MODIFY COLUMN order_date datetime;

-- Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);

-- Monthly trend for total_order
select monthname(order_date) as order_month, count(distinct order_id) as total_orders
from pizza_sales
group by monthname(order_date)
order by total_orders desc;

-- Percentage of sales by Pizzas category.
select pizza_category, sum(total_price)*100 /(select sum(total_price)from pizza_sales where month(order_date) = 1) as percent_for_total_Sales
from pizza_sales
where month(order_date) = 1 group by pizza_category;
	
-- Percentage of sales by Pizzas category.
SELECT pizza_size, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size;

-- Top 5 Pizzas by Revenue
select pizza_name, sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;

-- Bottom 5 Pizzas by Revenue
select pizza_name,sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5;

-- Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
limit 5;

-- Bottom 5 pizza by orders.
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders asc
limit 5;

