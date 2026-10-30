USE EmployeeOperationsLab;
GO
 
DECLARE @PageNumber INT = 1;
DECLARE @PageSize INT = 3;
 
IF @PageNumber < 1 OR @PageSize < 1
    THROW 50001, 'Page number and page size must be positive.', 1;
 
SELECT EmployeeId, EmployeeNumber, FirstName, LastName, HireDate, Salary
FROM dbo.Employees
ORDER BY EmployeeId
OFFSET (@PageNumber - 1) * @PageSize ROWS
FETCH NEXT @PageSize ROWS ONLY;
GO
 
-- Exercise: change @PageNumber to 2 and compare the returned records.
