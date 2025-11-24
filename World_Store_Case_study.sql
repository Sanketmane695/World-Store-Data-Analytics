-- Case Study: World Store Data Analytics

-- Background:
-- World Store, a multinational online retail platform, collects vast amounts of data across its operations.
-- This data includes information on customer orders, staff assignments, product returns, and customer profiles.
-- By analyzing this data effectively, World Store aims to gain insights that will drive customer satisfaction,
-- streamline operations, and boost overall sales.

-- Problem Statement:
-- World Store seeks to leverage its comprehensive dataset to meet the following business objectives through data analytics.

-- 1. Retrieve all customer information.
SELECT * FROM Customers;

-- 2. List all orders made by customers.
SELECT * FROM Orders;

-- 3. Show details of all orders returned.
SELECT o.Order_ID, o.Order_Date, r.Returned, r.Market
FROM Orders o
JOIN Returns r ON o.Order_ID = r.Order_ID
WHERE r.Returned = 'Yes';

-- 4. Find the total number of orders made per customer.
SELECT Customer_ID, COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY Customer_ID;


-- 5. Retrieve customers whose yearly income is above $50,000.
SELECT Customer_Name, Yearly_Income
FROM Customers
WHERE Yearly_Income > 50000;

-- 6. Retrieve orders made by customers in a specific country, e.g., 'USA'.
SELECT *
FROM Orders
WHERE Country = 'USA';

-- 7. List the top 5 products by sales.
SELECT Product_Name, SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 5;

-- 8. Retrieve customer details who have returned their products.
SELECT c.Customer_ID, c.Customer_Name, r.Order_ID
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
JOIN Returns r ON o.Order_ID = r.Order_ID
WHERE r.Returned = 'Yes';

-- 9. Calculate total sales and profit by country.
SELECT Country, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Country;

-- 10. Find orders where the discount is greater than 10%.
SELECT *
FROM Orders
WHERE Discount > 0.10;

-- 11. List all customers who made purchases in the 'Technology' category.
SELECT DISTINCT c.Customer_Name
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Category = 'Technology';

-- 12. Calculate the average shipping cost by region.
SELECT Region, AVG(Shipping_Cost) AS Avg_Shipping_Cost
FROM Orders
GROUP BY Region;

-- 13. List all customers whose orders were shipped with high priority.
SELECT c.Customer_Name, o.Order_ID, o.Order_Priority
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Priority = 'High';

-- 14. Find the most profitable product by region.
SELECT Region, Product_Name, MAX(Profit) AS Max_Profit
FROM Orders
GROUP BY Region, Product_Name
ORDER BY Max_Profit DESC;

-- 15. Show the number of customers per marital status.
SELECT Marital_Status, COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Marital_Status;

-- 16. Retrieve orders along with the corresponding employee who handled the region.
SELECT o.Order_ID, o.Region, p.Person
FROM Orders o
JOIN People p ON o.Region = p.Region;

-- 17. Find the total sales made in the 'Consumer' segment.
SELECT Segment, SUM(Sales) AS Total_Sales
FROM Orders
WHERE Segment = 'Consumer'
GROUP BY Segment;

-- 18. Calculate the total profit made in each market.
SELECT Market, SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Market;

-- 19. Find all customers who placed orders before January 1, 2020.
SELECT Customer_ID, Order_ID, Order_Date
FROM Orders
WHERE Order_Date < '2020-01-01';

-- 20. Retrieve the names of customers who placed more than 3 orders.
SELECT Customer_ID, Customer_Name
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
HAVING COUNT(o.Order_ID) > 3;

-- 21. List all orders with customer information using an inner join.
SELECT o.Order_ID, o.Order_Date, c.Customer_Name, c.Gender
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID;

-- 22. Retrieve all orders along with customer and return details using a left join.
SELECT o.Order_ID, o.Order_Date, c.Customer_Name, r.Returned
FROM Orders o
LEFT JOIN Customers c ON o.Customer_ID = c.Customer_ID
LEFT JOIN Returns r ON o.Order_ID = r.Order_ID;

-- 23. Retrieve all orders and return details, including those without returns (using a right join).
SELECT o.Order_ID, o.Order_Date, r.Returned, r.Market
FROM Orders o
RIGHT JOIN Returns r ON o.Order_ID = r.Order_ID;

-- 24. Show customer names and their corresponding region from the 'People' table using an inner join.
SELECT c.Customer_Name, p.Region
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
JOIN People p ON o.Region = p.Region;

-- 25. Retrieve all customers and their orders who placed orders in the 'Technology' category using a join.
SELECT c.Customer_Name, o.Order_ID, o.Product_Name
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Category = 'Technology';

-- 26. Find customers who made purchases in both 'Consumer' and 'Corporate' segments.
SELECT DISTINCT c.Customer_Name
FROM Customers c
JOIN Orders o1 ON c.Customer_ID = o1.Customer_ID
JOIN Orders o2 ON c.Customer_ID = o2.Customer_ID
WHERE o1.Segment = 'Consumer' AND o2.Segment = 'Corporate';

-- 27. Retrieve orders where the shipping cost is higher than $20.
SELECT *
FROM Orders
WHERE Shipping_Cost > 20;

-- 28. Calculate total sales, discount, and profit by category.
SELECT Category, SUM(Sales) AS Total_Sales, SUM(Discount) AS Total_Discount, SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Category;

-- 29. Find orders with products from multiple categories.
SELECT Order_ID, COUNT(DISTINCT Category) AS Category_Count
FROM Orders
GROUP BY Order_ID
HAVING Category_Count > 1;

-- 30. Retrieve customer details along with the total profit generated by each customer.
SELECT c.Customer_Name, SUM(o.Profit) AS Total_Profit
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_Name;



-- Task 1: Analyzing Customer Insights

-- 1. Retrieve the list of all customers and their total sales.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    SUM(o.Sales) AS Total_Sales
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name;

-- 2. Retrieve the number of unique customers in each market.
SELECT 
    Market, 
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM 
    Orders
GROUP BY 
    Market;

-- 3. For each segment of customers, find the total number of orders placed.
SELECT 
    Segment, 
    COUNT(Order_ID) AS Total_Orders
FROM 
    Orders
GROUP BY 
    Segment;

-- 4. Find the customers who have placed orders totaling more than $5,000.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    SUM(o.Sales) AS Total_Sales
FROM 
    Customers c
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name
HAVING 
    SUM(o.Sales) > 5000;

-- 5. Retrieve a list of customers and their orders, showing only those who have placed more than 5 orders.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    Customers c
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name
HAVING 
    COUNT(o.Order_ID) > 5;

-- 6. Identify customers with no recorded sales.
SELECT 
    c.Customer_ID, 
    c.Customer_Name
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
WHERE 
    o.Sales IS NULL;

-- Task 2: Shipping and Profitability Analysis

-- 7. Find the average shipping cost per order.
SELECT 
    AVG(Shipping_Cost) AS Average_Shipping_Cost
FROM 
    Orders;

-- 8. List the total profit for each region.
SELECT 
    Region, 
    SUM(Profit) AS Total_Profit
FROM 
    Orders
GROUP BY 
    Region;

-- 9. Retrieve orders with a high shipping cost (above $50) and low profit (below $100).
SELECT 
    Order_ID, 
    Shipping_Cost, 
    Profit
FROM 
    Orders
WHERE 
    Shipping_Cost > 50 AND Profit < 100;

-- 10. Identify the top 5 most profitable products.
SELECT 
    Product_ID, 
    Product_Name, 
    SUM(Profit) AS Total_Profit
FROM 
    Orders
GROUP BY 
    Product_ID, Product_Name
ORDER BY 
    Total_Profit DESC
LIMIT 5;

-- Task 3: Product and Category Insights

-- 11. Find the total sales per product category.
SELECT 
    Category, 
    SUM(Sales) AS Total_Sales
FROM 
    Orders
GROUP BY 
    Category;

-- 12. List the top 3 products in terms of total sales in the "Furniture" category.
SELECT 
    Product_ID, 
    Product_Name, 
    SUM(Sales) AS Total_Sales
FROM 
    Orders
WHERE 
    Category = 'Furniture'
GROUP BY 
    Product_ID, Product_Name
ORDER BY 
    Total_Sales DESC
LIMIT 3;

-- 13. Identify products that have been sold more than 100 times but have a total profit of less than $500.
SELECT 
    Product_ID, 
    Product_Name, 
    SUM(Quantity) AS Total_Quantity_Sold, 
    SUM(Profit) AS Total_Profit
FROM 
    Orders
GROUP BY 
    Product_ID, Product_Name
HAVING 
    SUM(Quantity) > 100 AND SUM(Profit) < 500;

-- 14. Retrieve the list of products that have never been sold.
SELECT 
    p.Product_ID, 
    p.Product_Name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.Product_ID = o.Product_ID
WHERE 
    o.Product_ID IS NULL;

-- Task 4: Analyzing Returns

-- 15. Retrieve the number of returned orders for each region.
SELECT 
    o.Region, 
    COUNT(r.Order_ID) AS Returned_Orders
FROM 
    Orders o
JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    o.Region;

-- 16. Identify the markets with the highest return rate.
SELECT 
    Market, 
    COUNT(r.Order_ID) * 100.0 / COUNT(o.Order_ID) AS Return_Rate
FROM 
    Orders o
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    Market
ORDER BY 
    Return_Rate DESC;


-- 17. Find out which products are returned the most often.
SELECT 
    o.Product_ID, 
    o.Product_Name, 
    COUNT(r.Order_ID) AS Total_Returns
FROM 
    Orders o
JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    o.Product_ID, o.Product_Name
ORDER BY 
    Total_Returns DESC;


-- 18. For each customer, show the number of orders they have placed and how many of those were returned.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(o.Order_ID) AS Total_Orders, 
    COUNT(r.Order_ID) AS Returned_Orders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name;

-- Task 5: Join-Based Queries

-- 19. Retrieve a list of all customers along with the total sales they have generated. Include customers who have not placed any orders.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COALESCE(SUM(o.Sales), 0) AS Total_Sales
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name;

-- 20. For each customer, list their name, order date, and total sales for each order. Exclude customers without any orders.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    o.Order_Date, 
    o.Sales
FROM 
    Customers c
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
ORDER BY 
    c.Customer_Name;

-- 21. List all returned orders, displaying Order_ID, Order_Date, Customer_ID, and Market.
SELECT 
    r.Order_ID, 
    o.Order_Date, 
    o.Customer_ID, 
    r.Market
FROM 
    Returns r
JOIN 
    Orders o ON r.Order_ID = o.Order_ID;

-- 22. Retrieve a list of all orders with their return status (whether returned or not).
SELECT 
    o.Order_ID, 
    o.Order_Date, 
    COALESCE(r.Returned, 'No') AS Return_Status
FROM 
    Orders o
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID;

-- 23. Retrieve a list of employees and the total number of orders handled in their respective regions.
SELECT 
    p.Person, 
    p.Region, 
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    People p
LEFT JOIN 
    Orders o ON p.Region = o.Region
GROUP BY 
    p.Person, p.Region;

-- 24. Identify employees who have not handled any orders.
SELECT 
    p.Person, 
    p.Region
FROM 
    People p
LEFT JOIN 
    Orders o ON p.Region = o.Region
WHERE 
    o.Order_ID IS NULL;

-- 25. List all products along with their total sales and number of orders. Include products with no sales.
SELECT 
    o.Product_ID, 
    o.Product_Name, 
    COALESCE(SUM(o.Sales), 0) AS Total_Sales, 
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    Orders o
RIGHT JOIN 
    Products p ON o.Product_ID = p.Product_ID
GROUP BY 
    p.Product_ID, p.Product_Name;

-- 26. Retrieve a list of customers, their total orders, total sales, and the employee responsible for their region.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(o.Order_ID) AS Total_Orders, 
    COALESCE(SUM(o.Sales), 0) AS Total_Sales, 
    p.Person AS Responsible_Employee
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
LEFT JOIN 
    People p ON o.Region = p.Region
GROUP BY 
    c.Customer_ID, c.Customer_Name, p.Person;

-- 27. Find the total profit, total quantity sold, and the number of returned orders for each product.
SELECT 
    o.Product_ID, 
    o.Product_Name, 
    SUM(o.Profit) AS Total_Profit, 
    SUM(o.Quantity) AS Total_Quantity_Sold, 
    COUNT(r.Order_ID) AS Returned_Orders
FROM 
    Orders o
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    o.Product_ID, o.Product_Name;

-- 28. Identify the total sales for

-- ----------------------------------------------------------------
-- Task 1: Analyzing Customer Insights

-- 1. Retrieve the list of all customers and their total sales.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    SUM(o.Sales) AS Total_Sales
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name;

-- 2. Retrieve the number of unique customers in each market.
SELECT 
    Market, 
    COUNT(DISTINCT Customer_ID) AS Unique_Customers
FROM 
    Orders
GROUP BY 
    Market;

-- 3. For each segment of customers, find the total number of orders placed.
SELECT 
    Segment, 
    COUNT(Order_ID) AS Total_Orders
FROM 
    Orders
GROUP BY 
    Segment;

-- 4. Find the customers who have placed orders totaling more than $5,000.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    SUM(o.Sales) AS Total_Sales
FROM 
    Customers c
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name
HAVING 
    SUM(o.Sales) > 5000;

-- 5. Retrieve a list of customers and their orders, showing only those who have placed more than 5 orders.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    Customers c
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name
HAVING 
    COUNT(o.Order_ID) > 5;

-- 6. Identify customers with no recorded sales.
SELECT 
    c.Customer_ID, 
    c.Customer_Name
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
WHERE 
    o.Sales IS NULL;

-- Task 2: Shipping and Profitability Analysis

-- 7. Find the average shipping cost per order.
SELECT 
    AVG(Shipping_Cost) AS Average_Shipping_Cost
FROM 
    Orders;

-- 8. List the total profit for each region.
SELECT 
    Region, 
    SUM(Profit) AS Total_Profit
FROM 
    Orders
GROUP BY 
    Region;

-- 9. Retrieve orders with a high shipping cost (above $50) and low profit (below $100).
SELECT 
    Order_ID, 
    Shipping_Cost, 
    Profit
FROM 
    Orders
WHERE 
    Shipping_Cost > 50 AND Profit < 100;

-- 10. Identify the top 5 most profitable products.
SELECT 
    Product_ID, 
    Product_Name, 
    SUM(Profit) AS Total_Profit
FROM 
    Orders
GROUP BY 
    Product_ID, Product_Name
ORDER BY 
    Total_Profit DESC
LIMIT 5;

-- Task 3: Product and Category Insights

-- 11. Find the total sales per product category.
SELECT 
    Category, 
    SUM(Sales) AS Total_Sales
FROM 
    Orders
GROUP BY 
    Category;

-- 12. List the top 3 products in terms of total sales in the "Furniture" category.
SELECT 
    Product_ID, 
    Product_Name, 
    SUM(Sales) AS Total_Sales
FROM 
    Orders
WHERE 
    Category = 'Furniture'
GROUP BY 
    Product_ID, Product_Name
ORDER BY 
    Total_Sales DESC
LIMIT 3;

-- 13. Identify products that have been sold more than 100 times but have a total profit of less than $500.
SELECT 
    Product_ID, 
    Product_Name, 
    SUM(Quantity) AS Total_Quantity_Sold, 
    SUM(Profit) AS Total_Profit
FROM 
    Orders
GROUP BY 
    Product_ID, Product_Name
HAVING 
    SUM(Quantity) > 100 AND SUM(Profit) < 500;

-- 14. Retrieve the list of products that have never been sold.
SELECT 
    p.Product_ID, 
    p.Product_Name
FROM 
    Products p
LEFT JOIN 
    Orders o ON p.Product_ID = o.Product_ID
WHERE 
    o.Product_ID IS NULL;

-- Task 4: Analyzing Returns

-- 15. Retrieve the number of returned orders for each region.
SELECT 
    o.Region, 
    COUNT(r.Order_ID) AS Returned_Orders
FROM 
    Orders o
JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    o.Region;

-- 16. Identify the markets with the highest return rate.
SELECT 
    Market, 
    COUNT(r.Order_ID) * 100.0 / COUNT(o.Order_ID) AS Return_Rate
FROM 
    Orders o
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    Market
ORDER BY 
    Return_Rate DESC;

-- 17. Find out which products are returned the most often.
SELECT 
    o.Product_ID, 
    o.Product_Name, 
    COUNT(r.Order_ID) AS Total_Returns
FROM 
    Orders o
JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    o.Product_ID, o.Product_Name
ORDER BY 
    Total_Returns DESC;

-- 18. For each customer, show the number of orders they have placed and how many of those were returned.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(o.Order_ID) AS Total_Orders, 
    COUNT(r.Order_ID) AS Returned_Orders
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name;

-- Task 5: Join-Based Queries

-- 19. Retrieve a list of all customers along with the total sales they have generated. Include customers who have not placed any orders.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COALESCE(SUM(o.Sales), 0) AS Total_Sales
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY 
    c.Customer_ID, c.Customer_Name;

-- 20. For each customer, list their name, order date, and total sales for each order. Exclude customers without any orders.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    o.Order_Date, 
    o.Sales
FROM 
    Customers c
JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
ORDER BY 
    c.Customer_Name;

-- 21. List all returned orders, displaying Order_ID, Order_Date, Customer_ID, and Market.
SELECT 
    r.Order_ID, 
    o.Order_Date, 
    o.Customer_ID, 
    r.Market
FROM 
    Returns r
JOIN 
    Orders o ON r.Order_ID = o.Order_ID;

-- 22. Retrieve a list of all orders with their return status (whether returned or not).
SELECT 
    o.Order_ID, 
    o.Order_Date, 
    COALESCE(r.Returned, 'No') AS Return_Status
FROM 
    Orders o
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID;

-- 23. Retrieve a list of employees and the total number of orders handled in their respective regions.
SELECT 
    p.Person, 
    p.Region, 
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    People p
LEFT JOIN 
    Orders o ON p.Region = o.Region
GROUP BY 
    p.Person, p.Region;

-- 24. Identify employees who have not handled any orders.
SELECT 
    p.Person, 
    p.Region
FROM 
    People p
LEFT JOIN 
    Orders o ON p.Region = o.Region
WHERE 
    o.Order_ID IS NULL;

-- 25. List all products along with their total sales and number of orders. Include products with no sales.
SELECT 
    o.Product_ID, 
    o.Product_Name, 
    COALESCE(SUM(o.Sales), 0) AS Total_Sales, 
    COUNT(o.Order_ID) AS Total_Orders
FROM 
    Orders o
RIGHT JOIN 
    Products p ON o.Product_ID = p.Product_ID
GROUP BY 
    p.Product_ID, p.Product_Name;

-- 26. Retrieve a list of customers, their total orders, total sales, and the employee responsible for their region.
SELECT 
    c.Customer_ID, 
    c.Customer_Name, 
    COUNT(o.Order_ID) AS Total_Orders, 
    COALESCE(SUM(o.Sales), 0) AS Total_Sales, 
    p.Person AS Responsible_Employee
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.Customer_ID = o.Customer_ID
LEFT JOIN 
    People p ON o.Region = p.Region
GROUP BY 
    c.Customer_ID, c.Customer_Name, p.Person;

-- 27. Find the total profit, total quantity sold, and the number of returned orders for each product.
SELECT 
    o.Product_ID, 
    o.Product_Name, 
    SUM(o.Profit) AS Total_Profit, 
    SUM(o.Quantity) AS Total_Quantity_Sold, 
    COUNT(r.Order_ID) AS Returned_Orders
FROM 
    Orders o
LEFT JOIN 
    Returns r ON o.Order_ID = r.Order_ID
GROUP BY 
    o.Product_ID, o.Product_Name;

-- 28. Identify the total sales for each employee in their respective regions.
SELECT 
    p.Person, 
    p.Region, 
    SUM(o.Sales) AS Total_Sales
FROM 
    People p
LEFT JOIN 
    Orders o ON p.Region = o.Region
GROUP BY 
    p.Person, p.Region;

-- Task 6: Data Quality and Integrity

-- 29. Check for any missing values in the Customers table.
SELECT 
    *
FROM 
    Customers
WHERE 
    Customer_ID IS NULL OR Customer_Name IS NULL OR Yearly_Income IS NULL;

-- 30. Identify any duplicate entries in the Orders table.
SELECT 
    Order_ID, 
    COUNT(*) AS Duplicate_Count
FROM 
    Orders
GROUP BY 
    Order_ID
HAVING 
    COUNT(*) > 1;
