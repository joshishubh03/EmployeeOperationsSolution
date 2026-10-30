USE EmployeeOperationsLab;
GO
 
CREATE OR ALTER PROCEDURE dbo.usp_Employee_ApplySalaryIncrease
    @EmployeeNumber VARCHAR(20),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
 
    IF @IncreasePercent <= 0 OR @IncreasePercent > 50
        THROW 50120, 'Increase percentage must be greater than 0 and no more than 50.', 1;
 
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Employees
        WHERE EmployeeNumber = @EmployeeNumber
    )
        THROW 50121, 'Employee was not found.', 1;
 
    BEGIN TRY
        BEGIN TRANSACTION;
 
        UPDATE dbo.Employees
        SET Salary = ROUND(Salary * (1 + (@IncreasePercent / 100.0)), 2)
        WHERE EmployeeNumber = @EmployeeNumber;
 
        IF @@ROWCOUNT <> 1
            THROW 50122, 'Expected exactly one employee to be updated.', 1;
 
        COMMIT TRANSACTION;
 
        SELECT EmployeeNumber, Salary
        FROM dbo.Employees
        WHERE EmployeeNumber = @EmployeeNumber;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO
 
-- Safe demonstration: run inside an outer transaction and roll it back.
BEGIN TRANSACTION;
EXEC dbo.usp_Employee_ApplySalaryIncrease
    @EmployeeNumber = 'EMP-1001',
    @IncreasePercent = 2.5;
ROLLBACK TRANSACTION;
GO
 
-- Verify the salary is back to its original value.
SELECT EmployeeNumber, Salary
FROM dbo.Employees
WHERE EmployeeNumber = 'EMP-1001';
GO
