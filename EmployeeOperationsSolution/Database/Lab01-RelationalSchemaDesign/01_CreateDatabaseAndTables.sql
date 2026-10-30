USE master;
GO
IF DB_ID(N'EmployeeOperationsLab') IS NULL
BEGIN
    CREATE DATABASE EmployeeOperationsLab;
END;
GO
USE EmployeeOperationsLab;
GO
 
CREATE TABLE dbo.Departments
(
    DepartmentId INT IDENTITY(1,1) NOT NULL,
    DepartmentName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NULL,
    CreatedAtUtc DATETIME2(0) NOT NULL
        CONSTRAINT DF_Departments_CreatedAtUtc DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_Departments PRIMARY KEY (DepartmentId),
    CONSTRAINT UQ_Departments_DepartmentName UNIQUE (DepartmentName)
);
GO
 
CREATE TABLE dbo.Employees
(
    EmployeeId INT IDENTITY(1,1) NOT NULL,
    EmployeeNumber VARCHAR(20) NOT NULL,
    FirstName NVARCHAR(60) NOT NULL,
    LastName NVARCHAR(60) NOT NULL,
    Email NVARCHAR(254) NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(12,2) NOT NULL,
    EmploymentStatus VARCHAR(10) NOT NULL
        CONSTRAINT DF_Employees_EmploymentStatus DEFAULT ('Active'),
    DepartmentId INT NOT NULL,
    CreatedAtUtc DATETIME2(0) NOT NULL
        CONSTRAINT DF_Employees_CreatedAtUtc DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_Employees PRIMARY KEY (EmployeeId),
    CONSTRAINT UQ_Employees_EmployeeNumber UNIQUE (EmployeeNumber),
    CONSTRAINT UQ_Employees_Email UNIQUE (Email),
    CONSTRAINT CK_Employees_Salary_NonNegative CHECK (Salary >= 0),
    CONSTRAINT CK_Employees_EmploymentStatus
        CHECK (EmploymentStatus IN ('Active', 'OnLeave', 'Inactive')),
    CONSTRAINT FK_Employees_Departments
        FOREIGN KEY (DepartmentId) REFERENCES dbo.Departments (DepartmentId)
        ON DELETE NO ACTION
);
GO
 
CREATE TABLE dbo.Projects
(
    ProjectId INT IDENTITY(1,1) NOT NULL,
    ProjectCode VARCHAR(20) NOT NULL,
    ProjectName NVARCHAR(150) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    ProjectStatus VARCHAR(12) NOT NULL
        CONSTRAINT DF_Projects_ProjectStatus DEFAULT ('Planned'),
    CONSTRAINT PK_Projects PRIMARY KEY (ProjectId),
    CONSTRAINT UQ_Projects_ProjectCode UNIQUE (ProjectCode),
    CONSTRAINT CK_Projects_DateRange
        CHECK (EndDate IS NULL OR EndDate >= StartDate),
    CONSTRAINT CK_Projects_ProjectStatus
        CHECK (ProjectStatus IN ('Planned', 'Active', 'Completed', 'OnHold'))
);
GO
 
CREATE TABLE dbo.EmployeeProjects
(
    EmployeeId INT NOT NULL,
    ProjectId INT NOT NULL,
    AssignedRole NVARCHAR(80) NOT NULL,
    AllocationPercent TINYINT NOT NULL
        CONSTRAINT DF_EmployeeProjects_AllocationPercent DEFAULT (100),
    AssignedAtUtc DATETIME2(0) NOT NULL
        CONSTRAINT DF_EmployeeProjects_AssignedAtUtc DEFAULT SYSUTCDATETIME(),
    CONSTRAINT PK_EmployeeProjects PRIMARY KEY (EmployeeId, ProjectId),
    CONSTRAINT FK_EmployeeProjects_Employees
        FOREIGN KEY (EmployeeId) REFERENCES dbo.Employees (EmployeeId)
        ON DELETE NO ACTION,
    CONSTRAINT FK_EmployeeProjects_Projects
        FOREIGN KEY (ProjectId) REFERENCES dbo.Projects (ProjectId)
        ON DELETE NO ACTION,
    CONSTRAINT CK_EmployeeProjects_AllocationPercent
        CHECK (AllocationPercent BETWEEN 1 AND 100)
);
GO
 
-- SQL Server does not automatically index foreign-key columns.
CREATE INDEX IX_Employees_DepartmentId ON dbo.Employees (DepartmentId);
CREATE INDEX IX_EmployeeProjects_ProjectId ON dbo.EmployeeProjects (ProjectId);
GO