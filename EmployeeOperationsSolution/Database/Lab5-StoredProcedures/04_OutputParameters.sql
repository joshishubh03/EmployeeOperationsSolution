USE EmployeeOperationsLab;
GO
 
CREATE OR ALTER PROCEDURE dbo.usp_Department_GetEmployeeCount
    @DepartmentId INT,
    @EmployeeCount INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
 
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Departments
        WHERE DepartmentId = @DepartmentId
    )
        THROW 50130, 'Department was not found.', 1;
 
    SELECT @EmployeeCount = COUNT(*)
    FROM dbo.Employees
    WHERE DepartmentId = @DepartmentId;
END;
GO
 
DECLARE @Count INT;
 
EXEC dbo.usp_Department_GetEmployeeCount
    @DepartmentId = 1,
    @EmployeeCount = @Count OUTPUT;
 
SELECT @Count AS EmployeeCount;
GO
