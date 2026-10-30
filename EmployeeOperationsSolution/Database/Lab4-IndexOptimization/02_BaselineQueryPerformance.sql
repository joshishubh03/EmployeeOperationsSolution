USE EmployeeOperationsLab;
GO
 
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO
 
-- Query A: find employees in one department.
DECLARE @DepartmentId INT =
(
    SELECT TOP (1) DepartmentId
    FROM dbo.Departments
    WHERE DepartmentName = N'Engineering'
);
 
SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE DepartmentId = @DepartmentId;
GO
 
-- Query B: filter by department and order by salary.
DECLARE @DepartmentId2 INT =
(
    SELECT TOP (1) DepartmentId
    FROM dbo.Departments
    WHERE DepartmentName = N'Engineering'
);
 
SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE DepartmentId = @DepartmentId2
ORDER BY Salary DESC, EmployeeId;
GO
 
-- Query C: retrieve assignments for a project.
DECLARE @ProjectId INT =
(
    SELECT TOP (1) ProjectId
    FROM dbo.Projects
    WHERE ProjectCode = 'PRJ-001'
);
 
SELECT EmployeeId, ProjectId, AssignedRole, AllocationPercent
FROM dbo.EmployeeProjects
WHERE ProjectId = @ProjectId;
GO
 
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
