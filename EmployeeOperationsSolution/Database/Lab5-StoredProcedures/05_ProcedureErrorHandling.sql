USE EmployeeOperationsLab;
GO
 
CREATE OR ALTER PROCEDURE dbo.usp_Employee_ValidateSalary
    @EmployeeNumber VARCHAR(20),
    @ProposedSalary DECIMAL(12,2)
AS
BEGIN
    SET NOCOUNT ON;
 
    IF @ProposedSalary < 0
        THROW 50140, 'Salary cannot be negative.', 1;
 
    IF NOT EXISTS (
        SELECT 1 FROM dbo.Employees
        WHERE EmployeeNumber = @EmployeeNumber
    )
        THROW 50141, 'Employee was not found.', 1;
 
    SELECT
        EmployeeNumber,
        Salary AS CurrentSalary,
        @ProposedSalary AS ProposedSalary,
        CASE
            WHEN @ProposedSalary >= Salary THEN N'Valid for review'
            ELSE N'Possible salary reduction; approval may be required'
        END AS ValidationMessage
    FROM dbo.Employees
    WHERE EmployeeNumber = @EmployeeNumber;
END;
GO
 
EXEC dbo.usp_Employee_ValidateSalary
    @EmployeeNumber = 'EMP-1001',
    @ProposedSalary = 900000;
 
-- Uncomment one at a time to observe expected errors:
-- EXEC dbo.usp_Employee_ValidateSalary 'EMP-1001', -10;
-- EXEC dbo.usp_Employee_ValidateSalary 'EMP-9999', 500000;
GO
