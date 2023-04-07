DROP DATABASE IF EXISTS EmployeeDB
GO

CREATE DATABASE EmployeeDB
GO

USE EmployeeDB
GO

--CREATE TABLE
CREATE TABLE [Department_table] (
	DepartId integer NOT NULL,
	DepartName varchar(50) NOT NULL,
	Description varchar(100) NOT NULL,
  CONSTRAINT [PK_DEPARTMENT_TABLE] PRIMARY KEY CLUSTERED
  (
  [DepartId] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Employee_table] (
	EmpCode char(6) NOT NULL,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,
	Birthday smalldatetime NOT NULL,
	Gender integer NOT NULL DEFAULT '1',
	Address varchar(100),
	DepartID integer NOT NULL,
	Salary money NOT NULL,
  CONSTRAINT [PK_EMPLOYEE_TABLE] PRIMARY KEY CLUSTERED
  (
  [EmpCode] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO

ALTER TABLE [Employee_table] WITH CHECK ADD CONSTRAINT [Employee_table_fk0] FOREIGN KEY ([DepartID]) REFERENCES [Department_table]([DepartId])
ON UPDATE CASCADE
GO
ALTER TABLE [Employee_table] CHECK CONSTRAINT [Employee_table_fk0]
GO

--1. INSERT
INSERT INTO Department_table VALUES
(1, 'Management', 'Employee management'),
(2, 'Interview', 'Employee interview'),
(3, 'Trainning', 'Training Employees')
GO

INSERT INTO Employee_table VALUES
('A1', 'Tam', 'Phu', '5/4/2004', 1, 'Huong Mac- Tu Son- Bac Ninh', 1, '1000'),
('A2', 'Thuy', 'Tran', '9/9/2004', 2, 'Da Hoi- Tu Son- Bac Ninh', 2, '2000'),
('A3', 'Thuy', 'Nguyen', '1/1/1983', 2, 'Huong Mac- Tu Son- Bac Ninh', 3, '1500')
GO

-- 2
UPDATE Employee_table
SET Salary = Salary + (Salary * 0.1)
GO

-- 3
ALTER TABLE Employee_table 
ADD CONSTRAINT [salary_greater_than_0] check (Salary > 0 )
GO

-- 4

-- 5
CREATE UNIQUE NONCLUSTERED INDEX IX_DepartmentName
ON Department_table(DepartName)

-- 6
CREATE VIEW View_Employees
AS
SELECT E.EmpCode,
       E.LastName + ' ' + E.FirstName AS FullName,
	   D.DepartName
FROM Employee_table AS E
INNER JOIN Department_table AS D ON D.DepartId = E.DepartID
GO

 SELECT * FROM View_Employees

 -- 7
CREATE PROCEDURE sp_getAllEmp (@DeptID int)
AS
BEGIN
	SELECT D.DepartId, D.DepartName, D.Description,
	E.EmpCode, E.LastName + ' ' + E.FirstName AS FullName,
	E.Birthday, E.Address, E.Gender, E.Salary
	FROM Employee_table AS E
	INNER JOIN Department_table AS D ON @DeptID = E.DepartID
	WHERE E.DepartID = D.DepartId AND D.DepartId = @DeptID
END
GO

EXEC sp_getAllEmp @DeptID = 1
GO

-- 8
CREATE PROCEDURE sp_delDept(@EmpCode char(6))
AS
BEGIN
	DELETE FROM Employee_table
	WHERE EmpCode = @EmpCode
END
GO

EXEC sp_delDept @EmpCode = 'A3'
GO

SELECT * FROM Employee_table
GO
