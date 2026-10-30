USE EmployeeOperationsLab;
GO
 
INSERT INTO dbo.Departments (DepartmentName, Location)
SELECT v.DepartmentName, v.Location
FROM (VALUES
    (N'Engineering', N'Indore'),
    (N'Human Resources', N'Jalandhar'),
    (N'Finance', N'Mohali'),
    (N'Operations', N'Indore')
) AS v(DepartmentName, Location)
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Departments d
    WHERE d.DepartmentName = v.DepartmentName
);
GO
 
INSERT INTO dbo.Employees
    (EmployeeNumber, FirstName, LastName, Email, HireDate, Salary, EmploymentStatus, DepartmentId)
SELECT v.EmployeeNumber, v.FirstName, v.LastName, v.Email, v.HireDate,
       v.Salary, v.EmploymentStatus, d.DepartmentId
FROM (VALUES
    ('EMP-1001', N'Aarav', N'Sharma', N'aarav.sharma@example.com', CONVERT(date,'2022-04-11'), CAST(850000.00 AS DECIMAL(12,2)), 'Active', N'Engineering'),
    ('EMP-1002', N'Meera', N'Kapoor', N'meera.kapoor@example.com', CONVERT(date,'2021-09-20'), CAST(920000.00 AS DECIMAL(12,2)), 'Active', N'Engineering'),
    ('EMP-1003', N'Kabir', N'Singh', N'kabir.singh@example.com', CONVERT(date,'2023-01-16'), CAST(620000.00 AS DECIMAL(12,2)), 'OnLeave', N'Human Resources'),
    ('EMP-1004', N'Ananya', N'Patel', N'ananya.patel@example.com', CONVERT(date,'2020-06-08'), CAST(780000.00 AS DECIMAL(12,2)), 'Active', N'Finance'),
    ('EMP-1005', N'Rohan', N'Verma', N'rohan.verma@example.com', CONVERT(date,'2024-02-12'), CAST(540000.00 AS DECIMAL(12,2)), 'Active', N'Operations')
) AS v(EmployeeNumber, FirstName, LastName, Email, HireDate, Salary, EmploymentStatus, DepartmentName)
INNER JOIN dbo.Departments d ON d.DepartmentName = v.DepartmentName
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Employees e WHERE e.EmployeeNumber = v.EmployeeNumber
);
GO
 
INSERT INTO dbo.Projects (ProjectCode, ProjectName, StartDate, EndDate, ProjectStatus)
SELECT v.ProjectCode, v.ProjectName, v.StartDate, v.EndDate, v.ProjectStatus
FROM (VALUES
    ('PRJ-001', N'Employee Portal', CONVERT(date,'2026-01-15'), NULL, 'Active'),
    ('PRJ-002', N'Finance Reporting', CONVERT(date,'2026-03-01'), NULL, 'Active'),
    ('PRJ-003', N'HR Process Upgrade', CONVERT(date,'2026-05-10'), NULL, 'Planned')
) AS v(ProjectCode, ProjectName, StartDate, EndDate, ProjectStatus)
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Projects p WHERE p.ProjectCode = v.ProjectCode
);
GO
 
INSERT INTO dbo.EmployeeProjects (EmployeeId, ProjectId, AssignedRole, AllocationPercent)
SELECT e.EmployeeId, p.ProjectId, v.AssignedRole, v.AllocationPercent
FROM (VALUES
    ('EMP-1001', 'PRJ-001', N'Backend Developer', 70),
    ('EMP-1002', 'PRJ-001', N'Test Engineer', 30),
    ('EMP-1002', 'PRJ-002', N'Data Analyst', 60),
    ('EMP-1004', 'PRJ-002', N'Finance Analyst', 80),
    ('EMP-1003', 'PRJ-003', N'HR Analyst', 50)
) AS v(EmployeeNumber, ProjectCode, AssignedRole, AllocationPercent)
INNER JOIN dbo.Employees e ON e.EmployeeNumber = v.EmployeeNumber
INNER JOIN dbo.Projects p ON p.ProjectCode = v.ProjectCode
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.EmployeeProjects ep
    WHERE ep.EmployeeId = e.EmployeeId AND ep.ProjectId = p.ProjectId
);
GO
