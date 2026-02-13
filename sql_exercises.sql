-- Hands On Lab: Snowflake Startup SQL Exercises
--
-- Note: If you haven't yet followed the instructions found in the assignment's README.md 
-- file, you should start there.  
-- 
-- Before we being, use the commands below to set your context to ensure that your 
-- queries are hitting the right database (and to ensure that you can simply call the 
-- tables by name and avoid lots of extra typing).

USE DATABASE IS566;
USE SCHEMA SQL_PRACTICE;

-----------||     Part 1: Basic SQL Queries      ||-------------------------------------

-- 1. 
-- Return a list of orders placed after 2018-01-01, including customer first/last name, 
-- O_ORDERKEY, O_ORDERDATE, and O_TOTALPRICE. Sort by O_TOTALPRICE descending, then by 
-- last name ascending.

SELECT c.c_firstname, c.c_lastname, o.o_orderkey, o.o_orderdate, o.o_totalprice 
FROM ORDERS o
JOIN CUSTOMER c ON c.c_custkey = o.o_custkey
WHERE o.O_ORDERDATE > '2018-01-01'
ORDER BY o.o_totalprice DESC, c.c_lastname ASC;

-- 2. 
-- Find all orders that include a part whose name contains either "boys" or "blue". 
-- Return O_ORDERKEY, O_ORDERDATE, P_NAME, and P_RETAILPRICE, ordered by O_ORDERDATE.

SELECT o.o_orderkey, o.o_orderdate, p.p_name, p.p_retailprice 
FROM ORDERS o
JOIN LINEITEM l ON o.o_orderkey = l.l_orderkey
JOIN PART p ON p.p_partkey = l.l_partkey
WHERE p.p_name LIKE ANY ('%boys%', '%blue%')
ORDER BY o.o_orderdate;


-----------||     Part 2: Aggregation, Grouping, Joins      ||--------------------------

-- 3. 
-- For each customer, compute Order_Count and Total_Spent (sum of O_TOTALPRICE). Return 
-- C_CUSTKEY, first/last name, Order_Count, Total_Spent, ordered by Total_Spent desc.

SELECT c.c_custkey, c.c_firstname, c.c_lastname, count(o.o_orderdate) as Order_Count, sum(o.o_totalprice) AS Total_Spent
FROM customer c
LEFT JOIN orders o ON c.c_custkey = o.o_custkey
GROUP BY c.c_custkey, c.c_firstname, c.c_lastname
ORDER BY Total_Spent DESC;

-- 4.
-- During 2018, for orders with O_TOTALPRICE > 1000, compute total revenue by region 
-- (R_NAME). Return R_NAME, Total_Revenue, ordered by Total_Revenue desc.
SELECT r.r_name, sum(o.o_totalprice) as Total_Revenue
FROM orders o
JOIN customer c ON c.c_custkey = o.o_custkey
JOIN nation n ON n.n_nationkey = c.c_nationkey
JOIN region r ON r.r_regionkey = n.n_regionkey
WHERE year(o.o_orderdate) = 2018 AND o.o_totalprice > 1000
GROUP BY r.r_name
ORDER BY Total_Revenue DESC;



-- 5.
-- For each supplier, return supplier name, nation name, and the total quantity of 
-- items they have supplied across all orders. Order by nation, then supplier name.

SELECT s.s_name, n.n_name, SUM(l.l_quantity) AS Total_Items
FROM lineitem l
JOIN supplier s ON s.s_suppkey = l.l_suppkey
JOIN nation n ON s.s_nationkey = n.n_nationkey
GROUP BY s.s_name, n.n_name
ORDER BY n.n_name, s.s_name;


-- 6.
-- For order 1784611, return one row per line item with: L_ORDERKEY, P_NAME, S_NAME, 
-- L_QUANTITY, L_EXTENDEDPRICE, and also include a column Order_Max_Quantity equal to 
-- the maximum L_QUANTITY within that same order.

SELECT 
    l.l_orderkey,
    p.p_name,
    s.s_name,
    l.l_quantity,
    l.l_extendedprice,
    MAX(l.l_quantity) OVER (PARTITION BY l.l_orderkey) AS Order_Max_Quantity
FROM supplier s
JOIN lineitem l on l.l_suppkey = s.s_suppkey
JOIN part p ON p.p_partkey = l.l_partkey
WHERE l.l_orderkey = 1784611;


-----------||     Part 3: Fun with CTEs                     ||--------------------------

--
--     HEY YOU! Read this... 
--
-- Please trust me on this: don't outsource this to AI. Attempt every one of these on 
-- your own before seeking help elsewhere. CTEs are THE WAY that data professionals work with
-- SQL, and you want to be able to think in CTEs. 



-- Also: If you haven't yet watched the two CTE tutorial videos linked in the assignment 
-- README file, go watch those first. Then come back here and complete the rest
-- of the exercises.

-- 7.
-- Create a CTE that filters customers with an account balance (C_ACCTBAL) greater than 9,000.
--
-- Then use this CTE to display the following columns:
--   C_CUSTKEY,
--   C_FIRSTNAME,
--   C_LASTNAME
--
-- Order the results by C_FIRSTNAME, then by C_LASTNAME.

WITH cust_acct AS (
    SELECT *
    FROM customer 
    WHERE c_acctbal > 9000
)
SELECT C_CUSTKEY, C_FIRSTNAME, C_LASTNAME
FROM cust_acct
ORDER BY C_FIRSTNAME, C_LASTNAME;

-- 8.
-- Create a CTE that calculates the total quantity of items for each order in the LINEITEM table.
-- (Total_Quantity = sum of L_QUANTITY, grouped by L_ORDERKEY.)
--
-- Then use this CTE to find orders where Total_Quantity exceeds 100.
--
-- Display the following columns:
--   L_ORDERKEY,
--   Total_Quantity
--
-- Order the results by L_ORDERKEY.

WITH sum_quantity AS (
    SELECT sum(l_quantity) as Total_Quantity, l_orderkey 
    FROM lineitem
    GROUP BY l_orderkey
)
SELECT l_orderkey, Total_Quantity
FROM sum_quantity
WHERE Total_Quantity > 100
ORDER BY l_orderkey;

-- 9.
-- Using only the CTEs from #7 and #8 (do not re-write their full logic in-line), compute summary
-- order behavior for customers with high account balances.
--
-- Requirements:
--   1) Use the #7 CTE (high-balance customers) as your customer filter.
--   2) Use the #8-style CTE to get total quantity per order, BUT do NOT apply the "Total_Quantity > 100"
--      filter from #8 (you need the per-order totals for all orders).
--
-- For each high-balance customer, calculate:
--   Avg_Order_Val   = average of O_TOTALPRICE across that customer's orders
--   Avg_Order_Qty   = average of Total_Quantity across that customer's orders
--   Customer_Since  = earliest O_ORDERDATE for that customer's orders
--
-- Display the following columns:
--   C_CUSTKEY,
--   C_FIRSTNAME,
--   C_LASTNAME,
--   Avg_Order_Val,
--   Avg_Order_Qty,
--   Customer_Since
--
-- Order the results by Avg_Order_Val descending.
WITH cust_acct AS (
    SELECT *
    FROM customer 
    WHERE c_acctbal > 9000
),
sum_quantity AS (
    SELECT sum(l_quantity) as Total_Quantity, l_orderkey 
    FROM lineitem
    GROUP BY l_orderkey
)
SELECT c.C_CUSTKEY,
       c.C_FIRSTNAME,
       c.C_LASTNAME,
       avg(o.o_totalprice) AS Avg_Order_Val,
       avg(Total_Quantity) AS Avg_Order_Qty,
       min(o.o_orderdate) AS Customer_Since
FROM cust_acct c
JOIN orders o ON o.o_custkey = c.c_custkey
JOIN sum_quantity s ON s.l_orderkey = o.o_orderkey
GROUP BY c.C_CUSTKEY, c.C_FIRSTNAME, c.C_LASTNAME
ORDER BY Avg_Order_Val desc;

-- 10.
-- Write a CTE-based query that identifies customers from Germany who place a large number of small
-- orders.
--
-- Definitions:
--   Small order = any order with O_TOTALPRICE < 1,000
--   "Large number" = more than 10 small orders over the full time period in the dataset
--
-- Steps / CTE guidance:
--   1) Create a CTE that counts small orders per customer (Small_Order_Count), grouped by O_CUSTKEY.
--   2) Create a CTE that assembles customer attributes including nation name (N_NAME) so you can filter
--      to German customers.
--   3) Join these CTEs, filter to N_NAME = 'GERMANY' and Small_Order_Count > 10, and return results.
--
-- Display the following columns:
--   C_CUSTKEY,
--   C_FIRSTNAME,
--   C_LASTNAME,
--   Small_Order_Count
--
-- Order the results by C_LASTNAME, then by C_FIRSTNAME.
WITH Order_Count AS (
    SELECT  count(o.o_orderkey) AS Small_Order_Count, o.o_custkey
    FROM orders o 
    JOIN customer c ON c.c_custkey = o.o_custkey
    WHERE o.o_totalprice < 1000 
    GROUP BY o.o_custkey
),
customer_attributes AS (
    SELECT c.C_CUSTKEY, c.C_FIRSTNAME, c.C_LASTNAME, n.n_name
    FROM customer c
    JOIN nation n ON c.c_nationkey = n.n_nationkey
)
SELECT C_CUSTKEY, C_FIRSTNAME, C_LASTNAME, Small_Order_Count
FROM ORDER_COUNT o
JOIN customer_attributes c ON c.c_custkey = o.o_custkey
WHERE c.N_NAME = 'GERMANY' and o.Small_Order_Count > 10
ORDER BY c.c_lastname, c.c_firstname;


-- 11.
-- Use a CTE to calculate the average account balance (S_ACCTBAL) of suppliers from each nation.
-- Use another CTE to identify suppliers whose account balance is above their nation's average.
--
-- Then, for each of these above-average suppliers, calculate two transactional activity metrics:
--   Total_Quantity_Shipped  = sum of L_QUANTITY across all line items supplied by that supplier
--   Distinct_Orders_Served  = count of distinct L_ORDERKEY values for that supplier
--
-- Display the following columns:
--   S_SUPPKEY,
--   S_NAME,
--   S_ACCTBAL,
--   N_NAME,
--   Total_Quantity_Shipped,
--   Distinct_Orders_Served
--
-- Order the results by N_NAME, then by S_NAME.

WITH account_balance AS (
    SELECT AVG(s.s_acctbal) AS Avg_acct_bal, n.n_name, n.n_nationkey
    FROM supplier s
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    GROUP BY n.n_name, n.n_nationkey
),
above_avg AS (
    SELECT s.s_suppkey, s.s_name, n.n_name, s.s_acctbal
    FROM supplier s 
    JOIN nation n ON s.s_nationkey = n.n_nationkey
    JOIN account_balance a ON n.n_nationkey = a.n_nationkey
    WHERE s.s_acctbal > a.Avg_acct_bal
)
SELECT g.s_suppkey, 
       g.s_name, 
       g.s_acctbal, 
       g.n_name, 
       SUM(l.l_quantity) AS Total_Quantity_Shipped, 
       COUNT(DISTINCT l.l_orderkey) AS Distinct_Orders_Served
FROM above_avg g
JOIN lineitem l ON g.s_suppkey = l.l_suppkey
GROUP BY g.s_suppkey, g.s_name, g.s_acctbal, g.n_name
ORDER BY g.n_name, g.s_name;

-- 12.
-- Write a CTE-based query to evaluate whether there are systematic shipping delays for customers in
-- the five regions.
--
-- Definitions:
--   Days_To_Ship (per line item) = difference between ship date and order date
--   Overall_Shipping_Days (per order) = the maximum Days_To_Ship among all line items on that order
--   (An order is not considered shipped until the last item ships.)
--
-- CTE guidance:
--   1) Create a CTE that joins LINEITEM to ORDERS and computes Days_To_Ship for each line item.
--   2) Create a CTE that aggregates to the order level, computing Overall_Shipping_Days as the max
--      Days_To_Ship per order.
--   3) Create a CTE (or final join) that assigns each order to a region via the customer:
--        ORDERS -> CUSTOMER -> NATION -> REGION
--   4) Aggregate to the region level to compute:
--        Order_Count        = count of distinct orders in that region
--        Avg_Shipping_Days  = average Overall_Shipping_Days for orders in that region
--
-- Display the following columns:
--   R_NAME,
--   Order_Count,
--   Avg_Shipping_Days
--
-- Order the results by R_NAME.

WITH lineitem_shipping AS (
    SELECT l.l_orderkey, 
           DATEDIFF(day, o.o_orderdate, l.l_shipdate) AS Days_To_Ship
    FROM lineitem l
    JOIN orders o ON l.l_orderkey = o.o_orderkey
),
order_shipping AS (
    SELECT l_orderkey, 
           MAX(Days_To_Ship) AS Overall_Shipping_Days
    FROM lineitem_shipping
    GROUP BY l_orderkey
),
order_region AS (
    SELECT os.l_orderkey, 
           os.Overall_Shipping_Days, 
           r.r_name
    FROM order_shipping os
    JOIN orders o ON os.l_orderkey = o.o_orderkey
    JOIN customer c ON o.o_custkey = c.c_custkey
    JOIN nation n ON c.c_nationkey = n.n_nationkey
    JOIN region r ON n.n_regionkey = r.r_regionkey
)
SELECT r_name AS R_NAME,
       COUNT(DISTINCT l_orderkey) AS Order_Count,
       AVG(Overall_Shipping_Days) AS Avg_Shipping_Days
FROM order_region
GROUP BY r_name
ORDER BY r_name;
