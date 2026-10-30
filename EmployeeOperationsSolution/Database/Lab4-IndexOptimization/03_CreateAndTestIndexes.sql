USE EmployeeOperationsLab;
GO
 
-- Index A: department filter followed by salary ordering.
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.Employees')
      AND name = N'IX_Lab4_Employees_Department_Salary'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Lab4_Employees_Department_Salary
    ON dbo.Employees (DepartmentId, Salary DESC, EmployeeId)
    INCLUDE (EmployeeNumber, FirstName, LastName);
END;
GO
 
-- Index B: a covering index for an employee directory lookup by department.
-- Included columns do not participate in the index's sort order.
IF NOT EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.Employees')
      AND name = N'IX_Lab4_Employees_Department_Directory'
)
BEGIN
    CREATE NONCLUSTERED INDEX IX_Lab4_Employees_Department_Directory
    ON dbo.Employees (DepartmentId, LastName, FirstName, EmployeeId)
    INCLUDE (EmployeeNumber, Email, HireDate, EmploymentStatus);
END;
GO
 
-- Index C: the primary key of EmployeeProjects is (EmployeeId, ProjectId).
-- This additional index supports searches that start with ProjectId.
-- Lab 1 already created IX_EmployeeProjects_ProjectId; inspect before deciding
-- whether another index is needed. This lab does NOT create a duplicate index.
SELECT name, type_desc
FROM sys.indexes
WHERE object_id = OBJECT_ID(N'dbo.EmployeeProjects')
ORDER BY index_id;
GO
 
-- Re-run the baseline queries after creating Index A and B.
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO
 
DECLARE @DepartmentId INT =
(
    SELECT TOP (1) DepartmentId
    FROM dbo.Departments
    WHERE DepartmentName = N'Engineering'
);
 
SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE DepartmentId = @DepartmentId
ORDER BY Salary DESC, EmployeeId;
GO
 
SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Email, HireDate, EmploymentStatus
FROM dbo.Employees
WHERE DepartmentId = @DepartmentId
ORDER BY LastName, FirstName, EmployeeId;
GO
 
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
