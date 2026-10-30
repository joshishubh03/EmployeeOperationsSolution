USE EmployeeOperationsLab;
GO
 
-- 1. Employees earning above the company-wide average.
SELECT EmployeeNumber, FirstName, LastName, Salary
FROM dbo.Employees
WHERE Salary > (SELECT AVG(Salary) FROM dbo.Employees)
ORDER BY Salary DESC;
GO
 
-- 2. Departments that have at least one employee: EXISTS.
SELECT d.DepartmentId, d.DepartmentName
FROM dbo.Departments d
WHERE EXISTS (
    SELECT 1
    FROM dbo.Employees e
    WHERE e.DepartmentId = d.DepartmentId
)
ORDER BY d.DepartmentName;
GO
 
-- 3. CTE: calculate department averages, then compare each employee.
WITH DepartmentSalary AS
(
    SELECT DepartmentId, AVG(CAST(Salary AS DECIMAL(12,2))) AS AvgDepartmentSalary
    FROM dbo.Employees
    GROUP BY DepartmentId
)
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       d.DepartmentName,
       e.Salary,
       ds.AvgDepartmentSalary
FROM dbo.Employees e
INNER JOIN dbo.Departments d ON d.DepartmentId = e.DepartmentId
INNER JOIN DepartmentSalary ds ON ds.DepartmentId = e.DepartmentId
WHERE e.Salary > ds.AvgDepartmentSalary
ORDER BY d.DepartmentName, e.Salary DESC;
GO
 
-- 4. Employees assigned to more than one project.
SELECT e.EmployeeNumber, e.FirstName, e.LastName
FROM dbo.Employees e
WHERE (
    SELECT COUNT(*)
    FROM dbo.EmployeeProjects ep
    WHERE ep.EmployeeId = e.EmployeeId
) > 1
ORDER BY e.EmployeeNumber;
GO
