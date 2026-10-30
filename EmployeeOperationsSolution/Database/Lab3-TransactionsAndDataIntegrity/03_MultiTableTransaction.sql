USE EmployeeOperationsLab;
GO
 
DECLARE @EmployeeId INT;
DECLARE @ProjectId INT;
DECLARE @RowsAffected INT;
 
SELECT @EmployeeId = EmployeeId
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1005';
 
SELECT @ProjectId = ProjectId
FROM dbo.Projects
WHERE ProjectCode = 'PRJ-001';
 
IF @EmployeeId IS NULL
    THROW 50010, 'Employee EMP-1005 was not found.', 1;
 
IF @ProjectId IS NULL
    THROW 50011, 'Project PRJ-001 was not found.', 1;
 
BEGIN TRY
    BEGIN TRANSACTION;
 
    -- Add the assignment only if it does not already exist.
    IF NOT EXISTS (
        SELECT 1
        FROM dbo.EmployeeProjects
        WHERE EmployeeId = @EmployeeId
          AND ProjectId = @ProjectId
    )
    BEGIN
        INSERT INTO dbo.EmployeeProjects
            (EmployeeId, ProjectId, AssignedRole, AllocationPercent)
        VALUES
            (@EmployeeId, @ProjectId, N'Operations Analyst', 25);
    END;
 
    -- Update the project status as part of the same transaction.
    UPDATE dbo.Projects
    SET ProjectStatus = 'Active'
    WHERE ProjectId = @ProjectId;
 
    SET @RowsAffected = @@ROWCOUNT;
 
    IF @RowsAffected <> 1
        THROW 50012, 'Expected exactly one project to be updated.', 1;
 
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
 
    THROW;
END CATCH;
GO
 
-- Verify the final state.
SELECT e.EmployeeNumber, p.ProjectCode, ep.AssignedRole,
       ep.AllocationPercent, p.ProjectStatus
FROM dbo.EmployeeProjects ep
INNER JOIN dbo.Employees e ON e.EmployeeId = ep.EmployeeId
INNER JOIN dbo.Projects p ON p.ProjectId = ep.ProjectId
WHERE e.EmployeeNumber = 'EMP-1005'
  AND p.ProjectCode = 'PRJ-001';
GO
