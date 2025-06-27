
-- Sales & Order Management System SQL Schema

-- 1. Customers Table
CREATE TABLE Customers (
						CustomerID INT PRIMARY KEY,
						 Name VARCHAR(100),
						Email VARCHAR(100),
						Phone VARCHAR(15),
						City VARCHAR(50)
						);

-- 2. Employees Table
CREATE TABLE Employees (
						EmployeeID INT PRIMARY KEY,
						Name VARCHAR(100),
						Position VARCHAR(50),
						Department VARCHAR(50)
						);

-- 3. Products Table
CREATE TABLE Products (
						ProductID INT PRIMARY KEY,
						Name VARCHAR(100),
						Category VARCHAR(50),
						Price DECIMAL(10, 2),
						Stock INT
						);

-- 4. Orders Table
CREATE TABLE Orders (
						OrderID INT PRIMARY KEY,
						CustomerID INT,
						EmployeeID INT,
						OrderDate DATE,
						FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
						FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
					);

-- 5. OrderDetails Table
CREATE TABLE OrderDetails (
							OrderDetailID INT PRIMARY KEY,
							OrderID INT,
							ProductID INT,
							Quantity INT,
							Discount DECIMAL(4, 2),
							FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
							FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
						);


