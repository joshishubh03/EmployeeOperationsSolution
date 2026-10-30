USE EmployeeOperationsLab;
GO
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- Version A: function applied to the column (commonly non-SARGable)
SELECT EmployeeId, FirstName, LastName, HireDate
FROM dbo.Employees
WHERE YEAR(HireDate) = 2024;
GO

-- Version B: equivalent date range for calendar year 2024
SELECT EmployeeId, FirstName, LastName, HireDate
FROM dbo.Employees
WHERE HireDate >= '20240101'
  AND HireDate <  '20250101';
GO

-- Another comparison: leading wildcard generally limits ordinary index-seek options
SELECT EmployeeId, FirstName, LastName, Email
FROM dbo.Employees
WHERE Email LIKE '%example.com';
GO

-- Prefix search is more likely to be seekable with a suitable index/collation
SELECT EmployeeId, FirstName, LastName, Email
FROM dbo.Employees
WHERE Email LIKE 'alex%';
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
