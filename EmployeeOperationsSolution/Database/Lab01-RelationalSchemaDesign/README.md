# Lab 1 — Relational Schema Design
 
## Purpose
Create a normalized employee-management schema in Microsoft SQL Server.
 
## Requirements
- SQL Server Developer/Express or an accessible SQL Server instance
- SSMS or another SQL query editor
- Permission to create the EmployeeOperationsLab database
 
## Run order
1. Execute 01_CreateDatabaseAndTables.sql.
2. Execute 02_InsertSampleData.sql.
3. Execute 03_ValidateSchemaAndData.sql.
 
Run the first script using a connection that can create databases. It creates
EmployeeOperationsLab if absent; it does not drop existing databases.
 
## Tables
- Departments: department details
- Employees: employee data and department foreign key
- Projects: project details
- EmployeeProjects: junction table for employee/project assignments
 
## Expected sample counts on a fresh database
- Departments: 4
- Employees: 5
- Projects: 3
- EmployeeProjects: 5
 
Counts may be higher if additional rows were added manually.
