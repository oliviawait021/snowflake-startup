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

-- 2. 
-- Find all orders that include a part whose name contains either "boys" or "blue". 
-- Return O_ORDERKEY, O_ORDERDATE, P_NAME, and P_RETAILPRICE, ordered by O_ORDERDATE.


-----------||     Part 2: Aggregation, Grouping, Joins      ||--------------------------

-- 3. 
-- For each customer, compute Order_Count and Total_Spent (sum of O_TOTALPRICE). Return 
-- C_CUSTKEY, first/last name, Order_Count, Total_Spent, ordered by Total_Spent desc.


-- 4.
-- During 2018, for orders with O_TOTALPRICE > 1000, compute total revenue by region 
-- (R_NAME). Return R_NAME, Total_Revenue, ordered by Total_Revenue desc.


-- 5.
-- For each supplier, return supplier name, nation name, and the total quantity of 
-- items they have supplied across all orders. Order by nation, then supplier name.


-- 6.
-- For order 1784611, return one row per line item with: L_ORDERKEY, P_NAME, S_NAME, 
-- L_QUANTITY, L_EXTENDEDPRICE, and also include a column Order_Max_Quantity equal to 
-- the maximum L_QUANTITY within that same order.



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

