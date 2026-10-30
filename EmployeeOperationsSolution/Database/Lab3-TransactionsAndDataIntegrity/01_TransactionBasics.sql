USE EmployeeOperationsLab;
GO
 
-- Baseline: record the current salary.
SELECT EmployeeNumber, Salary
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1001';
GO
 
-- Demonstrate a transaction that is deliberately rolled back.
BEGIN TRANSACTION;
 
UPDATE dbo.Employees
SET Salary = Salary + 1000
WHERE EmployeeNumber = 'EMP-1001';
 
SELECT EmployeeNumber, Salary AS SalaryInsideTransaction
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1001';
 
ROLLBACK TRANSACTION;
GO
 
-- Expected: salary returns to its original value.
SELECT EmployeeNumber, Salary AS SalaryAfterRollback
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1001';
GO
 
-- Demonstrate a committed change, then restore the original value.
-- Use a transaction so the lab leaves the row unchanged after the demonstration.
BEGIN TRANSACTION;
 
UPDATE dbo.Employees
SET Salary = Salary + 500
WHERE EmployeeNumber = 'EMP-1001';
 
SELECT EmployeeNumber, Salary AS SalaryBeforeCommit
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1001';
 
COMMIT TRANSACTION;
GO
 
-- Restore the value for repeatable lab runs.
UPDATE dbo.Employees
SET Salary = Salary - 500
WHERE EmployeeNumber = 'EMP-1001';
GO
