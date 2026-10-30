# Lab 3 — Transactions and Data Integrity
 
## Prerequisites
Complete Labs 1 and 2. Use the EmployeeOperationsLab database in a test environment.
 
## Files
1. 01_TransactionBasics.sql
2. 02_TryCatchAndRollback.sql
3. 03_MultiTableTransaction.sql
4. 04_TransactionIsolation.sql (requires two separate query sessions)
5. 05_DeadlockConcepts.md (instructor-led discussion/demonstration)
 
## Safety
- Never run the lab against production.
- Do not leave transactions open after an exercise.
- Roll back test changes unless a step explicitly requires a commit.
- The error-handling exercise intentionally raises a constraint error.
- The isolation exercise may block depending on database settings.
 
## Evidence to submit
- Screenshots of before/inside/after transaction results
- Error number/message from the intentional constraint failure
- Verification that the failed row was not inserted
- Short explanation of ACID, READ COMMITTED, dirty reads, and deadlocks
