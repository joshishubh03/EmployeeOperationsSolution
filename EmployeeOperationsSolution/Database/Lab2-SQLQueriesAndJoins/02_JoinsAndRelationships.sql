USE EmployeeOperationsLab;
GO
 
-- 1. INNER JOIN: employees that have a matching department.
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       d.DepartmentName
FROM dbo.Employees e
INNER JOIN dbo.Departments d
    ON d.DepartmentId = e.DepartmentId
ORDER BY d.DepartmentName, e.LastName;
GO
 
-- 2. LEFT JOIN: include departments even when they have no employees.
SELECT d.DepartmentName, e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName
FROM dbo.Departments d
LEFT JOIN dbo.Employees e
    ON e.DepartmentId = d.DepartmentId
ORDER BY d.DepartmentName, e.EmployeeNumber;
GO
 
-- 3. Many-to-many join: employee assignments and project details.
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       p.ProjectCode, p.ProjectName,
       ep.AssignedRole, ep.AllocationPercent
FROM dbo.EmployeeProjects ep
INNER JOIN dbo.Employees e ON e.EmployeeId = ep.EmployeeId
INNER JOIN dbo.Projects p ON p.ProjectId = ep.ProjectId
ORDER BY p.ProjectCode, e.EmployeeNumber;
GO
 
-- 4. Projects with assignment counts, including unassigned projects.
SELECT p.ProjectCode, p.ProjectName,
       COUNT(ep.EmployeeId) AS AssignedEmployeeCount
FROM dbo.Projects p
LEFT JOIN dbo.EmployeeProjects ep ON ep.ProjectId = p.ProjectId
GROUP BY p.ProjectCode, p.ProjectName
ORDER BY p.ProjectCode;
GO
 
-- 5. Employees not currently assigned to any project.
SELECT e.EmployeeNumber, e.FirstName, e.LastName
FROM dbo.Employees e
LEFT JOIN dbo.EmployeeProjects ep ON ep.EmployeeId = e.EmployeeId
WHERE ep.EmployeeId IS NULL
ORDER BY e.EmployeeNumber;
GO
