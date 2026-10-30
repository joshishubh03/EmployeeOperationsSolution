USE EmployeeOperationsLab;
GO

CREATE OR ALTER PROCEDURE dbo.usp_Lab06_EmployeesByDepartment
    @DepartmentId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeId, EmployeeNumber, FirstName, LastName, Salary, DepartmentId
    FROM dbo.Employees
    WHERE DepartmentId = @DepartmentId;
END;
GO

-- Execute using different parameter values and include the actual plan.
EXEC dbo.usp_Lab06_EmployeesByDepartment @DepartmentId = 1;
EXEC dbo.usp_Lab06_EmployeesByDepartment @DepartmentId = 2;
EXEC dbo.usp_Lab06_EmployeesByDepartment @DepartmentId = 3;
GO

-- Optional diagnostic comparison only; recompile applies to this execution.
EXEC dbo.usp_Lab06_EmployeesByDepartment @DepartmentId = 1 WITH RECOMPILE;
GO
