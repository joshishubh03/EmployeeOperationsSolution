# Lab 4 — Index Optimization
 
## Prerequisites
Complete Labs 1–3 and use the EmployeeOperationsLab database.
 
## Execution order
1. 01_InspectExistingIndexes.sql
2. 02_BaselineQueryPerformance.sql
3. 03_CreateAndTestIndexes.sql
4. 04_CompareExecutionPlans.sql
5. 05_CleanupLabIndexes.sql (optional)
 
Enable the actual execution plan in SSMS with Ctrl+M.
Use SET STATISTICS IO and SET STATISTICS TIME to record query metrics.
 
## Safety
- Use a test database only.
- Do not drop existing Lab 1 indexes.
- The cleanup script drops only indexes whose names start with IX_Lab4_.
- Small sample data may not show a performance improvement.
 
## Evidence to submit
- Existing index inventory
- Baseline and post-index logical reads / time
- Screenshots or notes from actual execution plans
- Short rationale for each index and discussion of its write/storage cost
