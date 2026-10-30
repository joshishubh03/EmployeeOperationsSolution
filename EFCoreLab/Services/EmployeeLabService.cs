using EFCoreLab.Data;
using EFCoreLab.Entites;
using EmployeeOperations.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
namespace EFCoreLab.Services
{

    public sealed class EmployeeLabService
    {
        private readonly EmployeeOperationsDbContext _db;

        public EmployeeLabService(EmployeeOperationsDbContext db) => _db = db;

        public async Task ListActiveEmployeesAsync(CancellationToken cancellationToken = default)
        {
            var employees = await _db.Employees
                .AsNoTracking()
                .Where(e => e.EmploymentStatus == "Active")
                .OrderBy(e => e.LastName)
                .ThenBy(e => e.FirstName)
                .Select(e => new
                {
                    e.EmployeeId,
                    e.EmployeeNumber,
                    FullName = e.FirstName + " " + e.LastName,
                    e.Email,
                    e.Salary,
                    Department = e.Department == null
                        ? "(Unassigned)"
                        : e.Department.DepartmentName
                })
                .ToListAsync(cancellationToken);

            foreach (var employee in employees)
            {
                Console.WriteLine(
                    $"{employee.EmployeeId}: {employee.FullName} | " +
                    $"{employee.Department} | {employee.Salary:C}");
            }
        }

        public async Task<EmployeeOperations.Infrastructure.Data.Employee?> FindEmployeeAsync(
            int employeeId,
            CancellationToken cancellationToken = default)
        {
            return await _db.Employees
                .Include(e => e.Department)
                .SingleOrDefaultAsync(
                    e => e.EmployeeId == employeeId,
                    cancellationToken);
        }

        public async Task AddDemoEmployeeAsync(
            CancellationToken cancellationToken = default)
        {
            // Use a lab-prefixed unique key to avoid colliding with seed records.
            var employeeNumber = $"LAB07-{Guid.NewGuid():N}"[..14];

            var employee = new EmployeeOperations.Infrastructure.Data.Employee
            {
                EmployeeNumber = employeeNumber,
                FirstName = "Lab",
                LastName = "Seven",
                Email = $"{employeeNumber.ToLowerInvariant()}@example.test",
                HireDate = DateTime.UtcNow.Date,
                Salary = 45000.00m,
                EmploymentStatus = "Active",
                DepartmentId = null,
                CreatedAtUtc = DateTime.UtcNow
            };

            _db.Employees.Add(employee);
            await _db.SaveChangesAsync(cancellationToken);
            Console.WriteLine($"Inserted EmployeeId={employee.EmployeeId}, Number={employee.EmployeeNumber}");
        }

        public async Task UpdateSalaryAsync(
            int employeeId,
            decimal newSalary,
            CancellationToken cancellationToken = default)
        {
            if (newSalary < 0)
                throw new ArgumentOutOfRangeException(nameof(newSalary), "Salary cannot be negative.");

            var employee = await _db.Employees
                .SingleOrDefaultAsync(e => e.EmployeeId == employeeId, cancellationToken);

            if (employee is null)
            {
                Console.WriteLine($"Employee {employeeId} was not found.");
                return;
            }

            employee.Salary = newSalary;
            await _db.SaveChangesAsync(cancellationToken);
            Console.WriteLine($"Updated salary for EmployeeId={employee.EmployeeId}.");
        }

        public async Task DeleteDemoEmployeesAsync(
            CancellationToken cancellationToken = default)
        {
            var demoEmployees = await _db.Employees
                .Where(e => e.EmployeeNumber.StartsWith("LAB07-"))
                .ToListAsync(cancellationToken);

            if (demoEmployees.Count == 0)
            {
                Console.WriteLine("No Lab 7 demo employees found.");
                return;
            }

            _db.Employees.RemoveRange(demoEmployees);
            await _db.SaveChangesAsync(cancellationToken);
            Console.WriteLine($"Deleted {demoEmployees.Count} Lab 7 demo employee(s).");
        }
    }

}
