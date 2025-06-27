
-- Sample Data for Customers
INSERT INTO Customers (CustomerID, Name, Email, Phone, City) 
VALUES
			(1, 'Alice Johnson', 'alice@example.com', '123-456-7890', 'New York'),
			(2, 'Bob Smith', 'bob@example.com', '321-654-0987', 'Los Angeles'),
			(3, 'Charlie Lee', 'charlie@example.com', '987-654-3210', 'Chicago'),
			(4, 'Diana King', 'diana@example.com', '555-123-4567', 'Houston'),
			(5, 'Ethan Wright', 'ethan@example.com', '444-555-6666', 'Miami');

-- Sample Data for Employees
INSERT INTO Employees (EmployeeID, Name, Position, Department)
VALUES
			(1, 'John Manager', 'Sales Manager', 'Sales'),
			(2, 'Sarah Clerk', 'Sales Clerk', 'Sales'),
			(3, 'Tom Admin', 'Administrator', 'Operations');

-- Sample Data for Products
INSERT INTO Products (ProductID, Name, Category, Price, Stock) 
VALUES
			(1, 'Laptop', 'Electronics', 999.99, 25),
			(2, 'Smartphone', 'Electronics', 499.99, 40),
			(3, 'Desk Chair', 'Furniture', 89.99, 15),
			(4, 'Monitor', 'Electronics', 199.99, 30),
			(5, 'Notebook', 'Stationery', 2.49, 100);

-- Sample Data for Orders
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) 
VALUES
			(1, 1, 1, '2025-01-10'),
			(2, 2, 2, '2025-01-15'),
			(3, 3, 1, '2025-02-05'),
			(4, 4, 3, '2025-02-20'),
			(5, 5, 2, '2025-03-01');

-- Sample Data for OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Discount)
VALUES
				 (1, 1, 1, 1, 0.100),
				 (2, 1, 5, 10, 0.00),
				 (3, 2, 2, 2, 0.05),
				 (4, 3, 3, 1, 0.00),
				 (5, 4, 4, 2, 0.15),
				 (6, 5, 5, 20, 0.00);
