USE EmployeeOperationsLab;
GO
 
BEGIN TRY
    BEGIN TRANSACTION;
 
    INSERT INTO dbo.Employees
        (EmployeeNumber, FirstName, LastName, Email, HireDate, Salary, DepartmentId)
    VALUES
        ('EMP-LAB3-ERROR', N'Lab', N'Rollback', N'lab3.rollback@example.com',
         '20260101', -100.00,
         (SELECT TOP (1) DepartmentId
          FROM dbo.Departments
          ORDER BY DepartmentId));
 
    -- This statement should not be reached if the CHECK constraint rejects the row.
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;
 
    SELECT
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage,
        XACT_STATE() AS TransactionStateAfterRollback;
 
    THROW;
END CATCH;
GO
 
-- Run this verification separately after the expected error.
SELECT COUNT(*) AS UnexpectedRows
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-LAB3-ERROR';
GO
