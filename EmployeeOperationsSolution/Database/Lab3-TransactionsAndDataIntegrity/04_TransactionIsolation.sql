USE EmployeeOperationsLab;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;
 
UPDATE dbo.Employees
SET Salary = Salary + 100
WHERE EmployeeNumber = 'EMP-1005';
 
-- Leave this transaction open temporarily while you run Session B.
SELECT EmployeeNumber, Salary
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1005';
 
-- After observing Session B, run:
ROLLBACK TRANSACTION;
GO
USE EmployeeOperationsLab;
GO
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
 
SELECT EmployeeNumber, Salary
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1005';
GO


