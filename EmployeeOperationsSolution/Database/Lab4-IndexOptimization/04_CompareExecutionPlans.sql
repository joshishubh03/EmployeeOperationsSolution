USE EmployeeOperationsLab;
GO
 
-- Query used for comparison: department filter + salary order.
DECLARE @DepartmentId INT =
(
    SELECT TOP (1) DepartmentId
    FROM dbo.Departments
    WHERE DepartmentName = N'Engineering'
);
 
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
 
SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE DepartmentId = @DepartmentId
ORDER BY Salary DESC, EmployeeId;
 
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
 
-- Optional: inspect the optimizer's index usage statistics for this instance.
-- These counters are cumulative since SQL Server start or counter reset.
SELECT
    OBJECT_NAME(s.object_id) AS TableName,
    i.name AS IndexName,
    s.user_seeks,
    s.user_scans,
    s.user_lookups,
    s.user_updates
FROM sys.dm_db_index_usage_stats AS s
INNER JOIN sys.indexes AS i
    ON i.object_id = s.object_id AND i.index_id = s.index_id
WHERE s.database_id = DB_ID(N'EmployeeOperationsLab')
  AND s.object_id IN (OBJECT_ID(N'dbo.Employees'), OBJECT_ID(N'dbo.EmployeeProjects'))
ORDER BY TableName, IndexName;
GO
