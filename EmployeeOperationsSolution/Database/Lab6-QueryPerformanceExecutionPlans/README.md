# Lab 6 — Query Tuning Report

## Environment
- SQL Server version:
- Database compatibility level (if known):
- Date/time and machine:
- Data volume / relevant table row counts:

## Query under investigation
- Business purpose:
- Original SQL:
- Baseline logical reads:
- Baseline CPU / elapsed time:
- Baseline operators:
- Estimated rows vs. actual rows:

## Change tested
- SQL rewrite or index change:
- Why it should help:
- Correctness/equivalence check:

## Results
- New logical reads:
- New CPU / elapsed time:
- Operators changed:
- Estimated vs. actual rows after change:
- Repeated-run observations:

## Conclusion
- Evidence supporting the change:
- Trade-offs (writes, storage, maintenance, compile cost):
- Limitations / what to test with production-like data:

# Lab 06 — Query Performance and Execution Plan Analysis

Prerequisite: Labs 1–5 and the existing EmployeeOperationsLab database.

## Run order
1. 01_BaselineAndMetrics.sql
2. 02_InspectActualPlan.sql (optional file for your selected query-plan captures)
3. 03_SargabilityAndRewrites.sql
4. 04_ParameterSensitivity.sql
5. Complete 05_TuningReportTemplate.md

Run scripts in SQL Server Management Studio. Enable actual execution plans with Ctrl+M.
Use STATISTICS IO/TIME for evidence. Do not clear server caches or alter core seed data.
Clean up the lab procedure and optional Lab06_PerformanceSample table after recording results.
