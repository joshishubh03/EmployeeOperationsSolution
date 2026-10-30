USE EmployeeOperationsLab;
GO
 
-- 1. Return a compact employee directory.
SELECT EmployeeNumber, FirstName, LastName, Email, HireDate
FROM dbo.Employees
ORDER BY LastName, FirstName;
GO
 
-- 2. Employees with salary at least 700,000.
SELECT EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE Salary >= 700000
ORDER BY Salary DESC, EmployeeNumber;
GO
 
-- 3. Active employees hired on or after 2022-01-01.
SELECT EmployeeNumber, FirstName, LastName, HireDate, EmploymentStatus
FROM dbo.Employees
WHERE EmploymentStatus = 'Active'
  AND HireDate >= '20220101'
ORDER BY HireDate DESC;
GO
 
-- 4. Search for names beginning with 'A'.
SELECT EmployeeNumber, FirstName, LastName
FROM dbo.Employees
WHERE FirstName LIKE N'A%'
ORDER BY FirstName, LastName;
GO
 
-- 5. Distinct employment statuses currently present.
SELECT DISTINCT EmploymentStatus
FROM dbo.Employees
ORDER BY EmploymentStatus;
GO
 
-- 6. Computed display column.
SELECT EmployeeNumber,
       CONCAT(FirstName, N' ', LastName) AS EmployeeName,
       Salary,
       CAST(Salary / 12.0 AS DECIMAL(12,2)) AS ApproxMonthlySalary
FROM dbo.Employees
ORDER BY EmployeeNumber;
GO
