USE EmployeeOperationsLab;
GO
 
CREATE OR ALTER PROCEDURE dbo.usp_Project_GetAssignments
    @ProjectCode VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
 
    IF NULLIF(LTRIM(RTRIM(@ProjectCode)), '') IS NULL
        THROW 50110, 'Project code is required.', 1;
 
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Projects
        WHERE ProjectCode = @ProjectCode
    )
        THROW 50111, 'Project was not found.', 1;
 
    SELECT
        p.ProjectCode,
        p.ProjectName,
        p.ProjectStatus,
        e.EmployeeNumber,
        CONCAT(e.FirstName, N' ', e.LastName) AS EmployeeName,
        ep.AssignedRole,
        ep.AllocationPercent,
        ep.AssignedAtUtc
    FROM dbo.Projects AS p
    INNER JOIN dbo.EmployeeProjects AS ep ON ep.ProjectId = p.ProjectId
    INNER JOIN dbo.Employees AS e ON e.EmployeeId = ep.EmployeeId
    WHERE p.ProjectCode = @ProjectCode
    ORDER BY e.LastName, e.FirstName, e.EmployeeId;
END;
GO
 
EXEC dbo.usp_Project_GetAssignments @ProjectCode = 'PRJ-001';
GO
