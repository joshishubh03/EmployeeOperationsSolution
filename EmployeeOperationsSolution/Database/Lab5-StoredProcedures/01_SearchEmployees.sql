USE EmployeeOperationsLab;
GO
 
CREATE OR ALTER PROCEDURE dbo.usp_Employee_Search
    @SearchText NVARCHAR(100) = NULL,
    @DepartmentId INT = NULL,
    @EmploymentStatus VARCHAR(10) = NULL
AS
BEGIN
    SET NOCOUNT ON;
 
    IF @DepartmentId IS NOT NULL
       AND NOT EXISTS (
           SELECT 1 FROM dbo.Departments
           WHERE DepartmentId = @DepartmentId
       )
        THROW 50101, 'The specified department does not exist.', 1;
 
    IF @EmploymentStatus IS NOT NULL
       AND @EmploymentStatus NOT IN ('Active', 'OnLeave', 'Inactive')
        THROW 50102, 'Invalid employment status.', 1;
 
    SELECT
        e.EmployeeId,
        e.EmployeeNumber,
        e.FirstName,
        e.LastName,
        e.Email,
        e.HireDate,
        e.Salary,
        e.EmploymentStatus,
        d.DepartmentName
    FROM dbo.Employees AS e
    INNER JOIN dbo.Departments AS d
        ON d.DepartmentId = e.DepartmentId
    WHERE
        (
            @SearchText IS NULL
            OR e.FirstName LIKE N'%' + @SearchText + N'%'
            OR e.LastName LIKE N'%' + @SearchText + N'%'
            OR e.EmployeeNumber LIKE '%' + @SearchText + '%'
        )
        AND (@DepartmentId IS NULL OR e.DepartmentId = @DepartmentId)
        AND (@EmploymentStatus IS NULL OR e.EmploymentStatus = @EmploymentStatus)
    ORDER BY e.LastName, e.FirstName, e.EmployeeId;
END;
GO
 
-- Examples
EXEC dbo.usp_Employee_Search;
EXEC dbo.usp_Employee_Search @SearchText = N'Meera';
EXEC dbo.usp_Employee_Search @DepartmentId = 1;
EXEC dbo.usp_Employee_Search @EmploymentStatus = 'Active';
EXEC dbo.usp_Employee_Search
    @SearchText = N'EMP-100',
    @EmploymentStatus = 'Active';
GO
