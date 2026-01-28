CREATE DATABASE company_finance_db;
-- Select the database to work on
USE company_finance_db;

-- Stores department information
CREATE TABLE departments (dept_id INT PRIMARY KEY,dept_name VARCHAR(100) NOT NULL,manager_name VARCHAR(100));
INSERT INTO departments(dept_id,dept_name,manager_name) VALUES
(1,'Sales','Amit Kumar'),
(2,'Marketing','Neha Sharma'),
(3,'IT','Rahul Verma'),
(4,'HR','Sara Khan'),
(5,'Finance','Rohit Mehta');
select * from departments;

-- Stores revenue earned by departments
CREATE TABLE revenue (revenue_id INT PRIMARY KEY,dept_id INT,revenue_date DATE,amount DECIMAL(10,2),
FOREIGN KEY (dept_id) REFERENCES departments(dept_id));
INSERT INTO revenue(revenue_id,dept_id,revenue_date,amount) VALUES
(101,1,'2025-01-05',120000),
(102,2,'2025-01-06',85000),
(103,3,'2025-01-07',95000),
(104,1,'2025-01-10',110000),
(105,4,'2025-01-12',60000),
(106,5,'2025-01-13',70000),
(107,2,'2025-01-15',90000),
(108,3,'2025-01-18',105000),
(109,1,'2025-01-20',130000),
(110,5,'2025-01-22',75000);
select * from revenue;

-- Stores expenses made by departments
CREATE TABLE expenses (expense_id INT PRIMARY KEY,dept_id INT,expense_date DATE,amount DECIMAL(10,2),category VARCHAR(50),
FOREIGN KEY (dept_id) REFERENCES departments(dept_id));
INSERT INTO expenses(expense_id,dept_id,expense_date,amount,category) VALUES
(201,1,'2025-01-05',30000,'Operations'),
(202,2,'2025-01-06',25000,'Advertising'),
(203,3,'2025-01-07',40000,'Infrastructure'),
(204,1,'2025-01-10',35000,'Logistics'),
(205,4,'2025-01-12',20000,'Recruitment'),
(206,5,'2025-01-13',22000,'Auditing'),
(207,2,'2025-01-15',28000,'Campaign'),
(208,3,'2025-01-18',45000,'Cloud Services'),
(209,1,'2025-01-20',37000,'Distribution'),
(210,5,'2025-01-22',26000,'Compliance');
select * from expenses;


-- Displays complete financial transaction details
SELECT 
    d.dept_id,
    d.dept_name,
    d.manager_name,
    r.revenue_id,
    r.revenue_date,
    r.amount AS revenue_amount,
    e.expense_id,
    e.expense_date,
    e.amount AS expense_amount,
    e.category
FROM departments d
JOIN revenue r ON d.dept_id = r.dept_id            -- Join departments with revenue
JOIN expenses e ON d.dept_id = e.dept_id           -- Join departments with expenses
ORDER BY d.dept_name;


-- Creates a reusable business report for revenue, expenses & profit
CREATE VIEW vw_department_financials AS
SELECT 
    d.dept_id,
    d.dept_name,
    COALESCE(r.total_revenue,0) AS total_revenue,
    COALESCE(e.total_expenses,0) AS total_expenses,
    COALESCE(r.total_revenue,0) - COALESCE(e.total_expenses,0) AS profit
FROM departments d

-- Aggregate revenue per department
LEFT JOIN (SELECT dept_id, SUM(amount) AS total_revenue
FROM revenue 
GROUP BY dept_id) r ON d.dept_id = r.dept_id

-- Aggregate expenses per department
LEFT JOIN (SELECT dept_id, SUM(amount) AS total_expenses
FROM expenses
GROUP BY dept_id) e ON d.dept_id = e.dept_id;

-- View department-wise financial summary
SELECT * FROM vw_department_financials;


DELIMITER $$

-- Procedure to fetch department financial summary automatically
CREATE PROCEDURE get_department_profits()
BEGIN
    SELECT * FROM vw_department_financials;
END $$

DELIMITER ;
-- Execute the stored procedure
CALL get_department_profits();








