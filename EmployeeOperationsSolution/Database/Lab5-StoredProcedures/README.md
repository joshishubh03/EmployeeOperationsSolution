# Lab 5 — Stored Procedures
 
## Prerequisites
Complete Labs 1–4. Use the EmployeeOperationsLab database.
 
## Execution order
1. 01_SearchEmployees.sql
2. 02_ProjectAssignments.sql
3. 03_UpdateEmployeeSalary.sql
4. 04_OutputParameters.sql
5. 05_ProcedureErrorHandling.sql
 
## Procedures created
- dbo.usp_Employee_Search
- dbo.usp_Project_GetAssignments
- dbo.usp_Employee_ApplySalaryIncrease
- dbo.usp_Department_GetEmployeeCount
- dbo.usp_Employee_ValidateSalary
 
## Safety
- Use a test database.
- The salary update demo runs inside an outer transaction and rolls back.
- Run intentional invalid-input examples one at a time.
- Do not put credentials or secrets into scripts.
 
## Evidence to submit
- Procedure definitions and execution results
- Valid and invalid parameter test results
- Explanation of input vs output parameters
- Explanation of parameterization and transaction ownership
