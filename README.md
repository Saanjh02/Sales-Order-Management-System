# Sales-Order-Management-System

**#PROJECT OVERVIEW:**

**Project Title**: **Sales & Order Management System **

**Level:** **Beginner And Intermediate **

**Database**:**'Sales_db'**

A mini SQL-based project that simulates a retail company's customer orders, product inventory, and employee activity tracking using relational database concepts.Built using Microsoft SQL Server.This project is a relational database system built for managing customers, employees, products, and orders. It supports querying various insights like revenue reports, customer behavior, and employee performance using SQL.

[Sales_project](https://github.com/Saanjh02/Sales-Order-Management-System/blob/main/library.jpg)

**#Objectives:**

- Design a normalized relational database for sales management.
- Populate the database with sample realistic data.
- Run intermediate-level SQL queries to extract business insights.
- Practice joins, aggregations, subqueries, and groupings.
- Support future integration with front-end or BI tools.
  
**#Project Structure:**

**Database Creation:** Created a database named Sales_db.

**Table Creation:** Created tables for Customers, Employees, Orders, OrderDetails and Products. Each table includes relevant columns and relationships.

```sql

-- 1. Customers Table
DROP TABLE IF EXISTS Customers
CREATE TABLE Customers (
						CustomerID INT PRIMARY KEY,
						 Name VARCHAR(100),
						Email VARCHAR(100),
						Phone VARCHAR(15),
						City VARCHAR(50)
						);

-- 2. Employees Table
DROP TABLE IF EXISTS Employees 
CREATE TABLE Employees (
						EmployeeID INT PRIMARY KEY,
						Name VARCHAR(100),
						Position VARCHAR(50),
						Department VARCHAR(50)
						);

-- 3. Products Table
DROP TABLE IF EXISTS Products
CREATE TABLE Products (
						ProductID INT PRIMARY KEY,
						Name VARCHAR(100),
						Category VARCHAR(50),
						Price DECIMAL(10, 2),
						Stock INT
						);

-- 4. Orders Table
DROP TABLE IF EXISTS Orders 
CREATE TABLE Orders (
						OrderID INT PRIMARY KEY,
						CustomerID INT,
						EmployeeID INT,
						OrderDate DATE,
						FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
						FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
					);

-- 5. OrderDetails Table
DROP TABLE IF EXISTS OrderDetails
CREATE TABLE OrderDetails (
							OrderDetailID INT PRIMARY KEY,
							OrderID INT,
							ProductID INT,
							Quantity INT,
							Discount DECIMAL(4, 2),
							FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
							FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
						);


```


**#CRUD Operations:**

**Create**: Insert new customers, products, or orders
**Read**: Retrieve customer info, order history, revenue reports
**Update**: Modify product prices or customer contact details
**Delete**: Remove specific orders or out-of-stock products

**--SOLUTIONS**

```sql
SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM Products;
SELECT * FROM OrderDetails;

```
**--TASK 1
--Top 5 Customers by Total Purchase Amount**

```sql
SELECT TOP 5 C.Name, 
       SUM(OD.Quantity * P.Price * (1 - OD.Discount)) AS TotalSpent
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.Name
ORDER BY TotalSpent DESC;
```
**
**--TASK 2 
--List all customers and how many orders they’ve made****

```sql
SELECT c.CustomerID, c.Name, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;
```

**--TASK 3
-- List each order with customer name, employee name, and order date**

```sql
SELECT o.OrderID, c.Name AS customerName  , e.Name AS employeeName , o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Employees e
ON o.EmployeeID = e.EmployeeID
GROUP BY o.OrderID , c.Name , e.Name , o.OrderDate;
```

**
**--TASK 4
-- Calculate total quantity and total price per order****

```sql
SELECT od.OrderID,
       SUM(od.Quantity) AS TotalItems,
       SUM(od.Quantity * p.Price * (1 - od.Discount)) AS TotalAmount
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.OrderID;
```

**--TASK 5
--Show top 3 products by total sales (quantity)**

```sql
SELECT  TOP 3 p.Name, p.ProductID , SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalSold DESC;
```

**--TASK 6
--Find customers who never placed any order**

```sql
SELECT c.* , o.OrderID 
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID 
WHERE o. OrderID IS NULL;
```

**--TASK 7
-- Which employee handled the most orders**

```sql
SELECT TOP 1 e.EmployeeID, e.Name, COUNT(o.OrderID) AS OrdersHandled
FROM Employees e
JOIN Orders o 
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.Name
ORDER BY OrdersHandled DESC;
```

**--TASK 8
--Revenue per product including discount**

```sql
SELECT p.ProductID, p.Name,
       SUM(od.Quantity * p.Price * (1 - od.Discount)) AS Revenue
FROM OrderDetails od
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY Revenue DESC;
```

**--TASK 9
--Find average discount given per product**

```sql
SELECT p.Name, AVG(od.Discount) AS AvgDiscount
FROM OrderDetails od
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY p.Name;
```


**--TASK 10
--Total number of orders handled by each department**

```sql
SELECT e.Department, COUNT(o.OrderID) AS TotalOrders
FROM Employees e
JOIN Orders o 
ON e.EmployeeID = o.EmployeeID
GROUP BY e.Department;
```

**--TASK 11
--Customers from each city with number of their orders**

```sql
SELECT  c.Name, c.City, COUNT(o.OrderID)
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.Name ,c.City;
```

**--TASK 12
--Monthly revenue breakdown**

```sql
SELECT FORMAT(o.OrderDate, 'yyyy-MM') AS Month,
       SUM(od.Quantity * p.Price * (1 - od.Discount)) AS MonthlyRevenue
FROM Orders o
JOIN OrderDetails od 
ON o.OrderID = od.OrderID
JOIN Products p 
ON od.ProductID = p.ProductID
GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY Month;
```


**--TASK 13
--Product stock levels (descending)**

```sql
SELECT ProductID, Name, Stock
FROM Products
ORDER BY Stock DESC;
```


**--TASK 14
--Find all orders that included more than 1 product**

```sql
SELECT OrderID
FROM OrderDetails
GROUP BY OrderID
HAVING COUNT(DISTINCT ProductID) > 1;
```

**--TASK 15
--Products never ordered
**
```sql
SELECT p.ProductID, p.Name
FROM Products p
LEFT JOIN OrderDetails od 
ON p.ProductID = od.ProductID
WHERE od.OrderID IS NULL;
```

**--TASK 16
--Total revenue by customer**

```sql
SELECT c.Name, SUM(od.Quantity * p.Price * (1 - od.Discount)) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.Name
ORDER BY TotalSpent DESC;
```

## 📊 Reports & Insights

- 📈 **Monthly Revenue Report**: Displays revenue per month based on product sales and discounts.
- 🏆 **Top-Selling Products**: Shows which products sold the most (by quantity).
- 🧍 **Customer Order History**: Number of orders placed by each customer.
- 👷 **Employee Performance**: Number of orders handled by each employee.
- 📦 **Product Inventory Summary**: Stock levels and products never ordered.
- 🚫 **Inactive Customers**: Identifies customers who haven’t made any orders.

## ✅ Conclusion

This Sales and Order Management SQL project helped demonstrate the design and execution of a relational database system. Using SQL Server, we created tables, populated them with realistic sample data, and extracted valuable insights using intermediate-level queries.

Through this project, we practiced:

- Database schema design and normalization
- Writing SQL queries involving joins, groupings, and aggregations
- Generating business reports from raw data
- Performing CRUD operations for data manipulation

This project lays the foundation for future enhancements like front-end integration, report automation, or connecting to Power BI dashboards.


## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.
   ```sh
   git clone https://github.com/Deepak Sharma/Sales & Order Management System.git
   ```

2. **Set Up the Database**: Execute the SQL scripts in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries in the `analysis_queries.sql` file to perform the analysis.
4. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.

## Author - Sunita Jangid

This project showcases SQL skills essential for database management and analysis. For more content on SQL and data analysis, connect with me through the following:

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/sunita-jangid-7a238b216)
- **Email ID**: (jangidsunita8008@gmail.com)

Thank you for your interest in this project!















