USE EmployeeOperationsLab;
GO
 
-- 1. Rank employees by salary within each department.
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       d.DepartmentName,
       e.Salary,
       RANK() OVER (
           PARTITION BY e.DepartmentId
           ORDER BY e.Salary DESC
       ) AS SalaryRankInDepartment
FROM dbo.Employees e
INNER JOIN dbo.Departments d ON d.DepartmentId = e.DepartmentId
ORDER BY d.DepartmentName, SalaryRankInDepartment, e.EmployeeNumber;
GO
 
-- 2. Show each employee's salary alongside department average.
SELECT e.EmployeeNumber,
       CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
       d.DepartmentName,
       e.Salary,
       AVG(CAST(e.Salary AS DECIMAL(12,2))) OVER (
           PARTITION BY e.DepartmentId
       ) AS DepartmentAverageSalary
FROM dbo.Employees e
INNER JOIN dbo.Departments d ON d.DepartmentId = e.DepartmentId
ORDER BY d.DepartmentName, e.Salary DESC;
GO
 
-- 3. Running total of salaries ordered by hire date.
SELECT EmployeeNumber, FirstName, LastName, HireDate, Salary,
       SUM(Salary) OVER (
           ORDER BY HireDate, EmployeeId
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS RunningSalaryTotal
FROM dbo.Employees
ORDER BY HireDate, EmployeeId;
GO
