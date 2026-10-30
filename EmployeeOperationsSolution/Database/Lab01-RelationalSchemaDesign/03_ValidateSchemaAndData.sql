USE EmployeeOperationsLab;
GO
 
-- 1. Tables
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;
GO
 
-- 2. Employees and their departments
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       e.Email, d.DepartmentName, e.EmploymentStatus, e.Salary
FROM dbo.Employees e
INNER JOIN dbo.Departments d ON d.DepartmentId = e.DepartmentId
ORDER BY e.EmployeeNumber;
GO
 
-- 3. Employee-project assignments
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       p.ProjectCode, p.ProjectName, ep.AssignedRole, ep.AllocationPercent
FROM dbo.EmployeeProjects ep
INNER JOIN dbo.Employees e ON e.EmployeeId = ep.EmployeeId
INNER JOIN dbo.Projects p ON p.ProjectId = ep.ProjectId
ORDER BY p.ProjectCode, e.EmployeeNumber;
GO
 
-- 4. Fresh-database counts should be 4, 5, 3, and 5.
SELECT
    (SELECT COUNT(*) FROM dbo.Departments) AS DepartmentCount,
    (SELECT COUNT(*) FROM dbo.Employees) AS EmployeeCount,
    (SELECT COUNT(*) FROM dbo.Projects) AS ProjectCount,
    (SELECT COUNT(*) FROM dbo.EmployeeProjects) AS AssignmentCount;
GO
 
-- 5. Expected: zero rows (no orphaned employee-department references).
SELECT e.EmployeeId, e.DepartmentId
FROM dbo.Employees e
LEFT JOIN dbo.Departments d ON d.DepartmentId = e.DepartmentId
WHERE d.DepartmentId IS NULL;
GO
 
-- 6. Key constraints
SELECT name, type_desc
FROM sys.key_constraints
WHERE parent_object_id IN (
    OBJECT_ID(N'dbo.Departments'), OBJECT_ID(N'dbo.Employees'),
    OBJECT_ID(N'dbo.Projects'), OBJECT_ID(N'dbo.EmployeeProjects')
)
ORDER BY parent_object_id, name;
 
-- 7. Indexes
SELECT t.name AS TableName, i.name AS IndexName, i.type_desc
FROM sys.indexes i
INNER JOIN sys.tables t ON t.object_id = i.object_id
WHERE t.name IN (N'Departments', N'Employees', N'Projects', N'EmployeeProjects')
  AND i.index_id > 0
ORDER BY t.name, i.name;
GO
using System;
using System.Collections.Generic;
using System.Text;

namespace EmployeeOperationsSolution.Database.Lab01_RelationalSchemaDesign
{
    internal class _03_ValidateSchemaAndData
    {
    }
}
