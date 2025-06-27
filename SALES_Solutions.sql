--SOLUTIONS

SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM OrderDetails;

--TASK 1
--Top 5 Customers by Total Purchase Amount
SELECT TOP 5 C.Name, 
       SUM(OD.Quantity * P.Price * (1 - OD.Discount)) AS TotalSpent
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.Name
ORDER BY TotalSpent DESC;

--TASK 2 
--List all customers and how many orders they’ve made
SELECT c.CustomerID, c.Name, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;

--TASK 3
-- List each order with customer name, employee name, and order date
SELECT o.OrderID, c.Name AS customerName  , e.Name AS employeeName , o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Employees e
ON o.EmployeeID = e.EmployeeID
GROUP BY o.OrderID , c.Name , e.Name , o.OrderDate;


--TASK 4
-- Calculate total quantity and total price per order
SELECT od.OrderID,
       SUM(od.Quantity) AS TotalItems,
       SUM(od.Quantity * p.Price * (1 - od.Discount)) AS TotalAmount
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.OrderID;

--TASK 5
--Show top 3 products by total sales (quantity)
SELECT  TOP 3 p.Name, p.ProductID , SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalSold DESC;

--TASK 6
--Find customers who never placed any order
SELECT c.* , o.OrderID 
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID 
WHERE o. OrderID IS NULL;

--TASK 7
-- Which employee handled the most orders
SELECT TOP 1 e.EmployeeID, e.Name, COUNT(o.OrderID) AS OrdersHandled
FROM Employees e
JOIN Orders o 
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.Name
ORDER BY OrdersHandled DESC;


--TASK 8
--Revenue per product including discount
SELECT p.ProductID, p.Name,
       SUM(od.Quantity * p.Price * (1 - od.Discount)) AS Revenue
FROM OrderDetails od
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY Revenue DESC;


--TASK 9
--Find average discount given per product
SELECT p.Name, AVG(od.Discount) AS AvgDiscount
FROM OrderDetails od
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY p.Name;


--TASK 10
--Total number of orders handled by each department
SELECT e.Department, COUNT(o.OrderID) AS TotalOrders
FROM Employees e
JOIN Orders o 
ON e.EmployeeID = o.EmployeeID
GROUP BY e.Department;

--TASK 11
--Customers from each city with number of their orders
SELECT  c.Name, c.City, COUNT(o.OrderID)
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.Name ,c.City;


--TASK 12
--Monthly revenue breakdown
SELECT FORMAT(o.OrderDate, 'yyyy-MM') AS Month,
       SUM(od.Quantity * p.Price * (1 - od.Discount)) AS MonthlyRevenue
FROM Orders o
JOIN OrderDetails od 
ON o.OrderID = od.OrderID
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY Month;


--TASK 13
--Product stock levels (descending)
SELECT ProductID, Name, Stock
FROM Products
ORDER BY Stock DESC;


--TASK 14
--Find all orders that included more than 1 product
SELECT OrderID
FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(DISTINCT ProductID) > 1;


--TASK 15
--Products never ordered
SELECT p.ProductID, p.Name
FROM Products p
LEFT JOIN OrderDetails od 
ON p.ProductID = od.ProductID
WHERE od.OrderID IS NULL;


--TASK 16
--Total revenue by customer
SELECT c.Name, SUM(od.Quantity * p.Price * (1 - od.Discount)) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.Name
ORDER BY TotalSpent DESC;

--END PROJECT  








