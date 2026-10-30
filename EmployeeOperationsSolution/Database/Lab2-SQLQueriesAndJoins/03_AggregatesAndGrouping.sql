USE EmployeeOperationsLab;
GO
 
-- 1. Overall salary summary.
SELECT COUNT(*) AS EmployeeCount,
       MIN(Salary) AS MinimumSalary,
       MAX(Salary) AS MaximumSalary,
       AVG(CAST(Salary AS DECIMAL(12,2))) AS AverageSalary,
       SUM(Salary) AS TotalAnnualSalary
FROM dbo.Employees;
GO
 
-- 2. Employee count and average salary by department.
SELECT d.DepartmentName,
       COUNT(e.EmployeeId) AS EmployeeCount,
       AVG(CAST(e.Salary AS DECIMAL(12,2))) AS AverageSalary
FROM dbo.Departments d
LEFT JOIN dbo.Employees e ON e.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentId, d.DepartmentName
ORDER BY EmployeeCount DESC, d.DepartmentName;
GO
 
-- 3. Departments with at least two employees.
SELECT d.DepartmentName, COUNT(e.EmployeeId) AS EmployeeCount
FROM dbo.Departments d
INNER JOIN dbo.Employees e ON e.DepartmentId = d.DepartmentId
GROUP BY d.DepartmentId, d.DepartmentName
HAVING COUNT(e.EmployeeId) >= 2
ORDER BY EmployeeCount DESC;
GO
 
-- 4. Salary totals by department and employment status.
SELECT d.DepartmentName, e.EmploymentStatus,
       COUNT(*) AS EmployeeCount, SUM(e.Salary) AS TotalSalary
FROM dbo.Employees e
INNER JOIN dbo.Departments d ON d.DepartmentId = e.DepartmentId
GROUP BY d.DepartmentName, e.EmploymentStatus
ORDER BY d.DepartmentName, e.EmploymentStatus;
GO
 
-- 5. Count project assignments by employee.
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       COUNT(ep.ProjectId) AS ProjectCount
FROM dbo.Employees e
LEFT JOIN dbo.EmployeeProjects ep ON ep.EmployeeId = e.EmployeeId
GROUP BY e.EmployeeId, e.EmployeeNumber, e.FirstName, e.LastName
ORDER BY ProjectCount DESC, e.EmployeeNumber;
GO
