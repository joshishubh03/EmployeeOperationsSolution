USE EmployeeOperationsLab;
GO
 
-- List indexes for the four lab tables.
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique,
    i.is_primary_key,
    i.is_unique_constraint,
    i.fill_factor,
    i.is_disabled
FROM sys.indexes AS i
INNER JOIN sys.tables AS t ON t.object_id = i.object_id
INNER JOIN sys.schemas AS s ON s.schema_id = t.schema_id
WHERE t.name IN (N'Departments', N'Employees', N'Projects', N'EmployeeProjects')
  AND i.index_id > 0
ORDER BY t.name, i.index_id;
GO
 
-- Show index key columns and included columns.
SELECT
    t.name AS TableName,
    i.name AS IndexName,
    ic.key_ordinal AS KeyOrdinal,
    c.name AS ColumnName,
    ic.is_included_column AS IsIncludedColumn,
    ic.is_descending_key AS IsDescending
FROM sys.indexes AS i
INNER JOIN sys.tables AS t ON t.object_id = i.object_id
INNER JOIN sys.index_columns AS ic
    ON ic.object_id = i.object_id AND ic.index_id = i.index_id
INNER JOIN sys.columns AS c
    ON c.object_id = ic.object_id AND c.column_id = ic.column_id
WHERE t.name IN (N'Departments', N'Employees', N'Projects', N'EmployeeProjects')
  AND i.index_id > 0
ORDER BY t.name, i.name, ic.is_included_column, ic.key_ordinal, c.column_id;
GO