USE EmployeeOperationsLab;
GO

SELECT DB_NAME() AS CurrentDatabase;
GO

-- Baseline query A: employee details with department name
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

SELECT
    e.EmployeeId,
    e.EmployeeNumber,
    e.FirstName,
    e.LastName,
    e.Email,
    e.Salary,
    d.DepartmentName
FROM dbo.Employees AS e
LEFT JOIN dbo.Departments AS d
    ON d.DepartmentId = e.DepartmentId
WHERE e.EmploymentStatus = 'Active'
ORDER BY e.LastName, e.FirstName;
GO

-- Baseline query B: project assignment summary
SELECT
    p.ProjectCode,
    p.ProjectName,
    COUNT(ep.EmployeeId) AS AssignedEmployeeCount,
    SUM(ep.AllocationPercent) AS TotalAllocationPercent
FROM dbo.Projects AS p
LEFT JOIN dbo.EmployeeProjects AS ep
    ON ep.ProjectId = p.ProjectId
GROUP BY p.ProjectCode, p.ProjectName
ORDER BY p.ProjectCode;
GO

-- Baseline query C: salary range
DECLARE @MinimumSalary DECIMAL(12,2) = 50000.00;

SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE Salary >= @MinimumSalary
ORDER BY Salary DESC;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
