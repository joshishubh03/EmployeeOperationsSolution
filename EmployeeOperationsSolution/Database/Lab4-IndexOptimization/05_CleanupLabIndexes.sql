USE EmployeeOperationsLab;
GO
 
IF EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.Employees')
      AND name = N'IX_Lab4_Employees_Department_Salary'
)
    DROP INDEX IX_Lab4_Employees_Department_Salary ON dbo.Employees;
GO
 
IF EXISTS (
    SELECT 1 FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'dbo.Employees')
      AND name = N'IX_Lab4_Employees_Department_Directory'
)
    DROP INDEX IX_Lab4_Employees_Department_Directory ON dbo.Employees;
GO
