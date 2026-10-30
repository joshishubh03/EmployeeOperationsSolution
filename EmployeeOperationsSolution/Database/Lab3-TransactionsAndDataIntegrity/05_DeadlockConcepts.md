# Deadlock concepts
 
A deadlock occurs when two or more sessions hold resources that the others need,
so none can proceed. SQL Server detects the cycle and chooses a victim transaction
to roll back (typically error 1205).
 
## Example pattern (instructor-led, test database only)
- Session A updates employee row EMP-1001, then attempts EMP-1002.
- Session B updates employee row EMP-1002, then attempts EMP-1001.
- Keep both transactions open between statements so the lock order can overlap.
- SQL Server may detect a deadlock and roll one transaction back.
 
## Prevention principles
- Access shared resources in a consistent order.
- Keep transactions short.
- Avoid user interaction while a transaction is open.
- Ensure queries have suitable indexes so they touch fewer rows where appropriate.
- Handle deadlock error 1205 with bounded retry logic at the application layer.
- Retry only operations that are safe to retry; do not blindly retry every error.
 
Do not run deliberate deadlock demonstrations against production data.
