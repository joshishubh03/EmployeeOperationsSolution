using EmployeeOperations.Application.Employees;
using EmployeeOperations.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace EmployeeOperations.Infrastructure.Employees;

public sealed class EfEmployeeRepository : IEmployeeRepository
{
    private readonly EmployeeOperationsDbContext _db;

    public EfEmployeeRepository(EmployeeOperationsDbContext db)
        => _db = db;

    public async Task<IReadOnlyList<EmployeeListItem>> GetAllAsync(
        CancellationToken cancellationToken = default)
    {
        return await _db.Employees
            .AsNoTracking()
            .OrderBy(e => e.LastName)
            .ThenBy(e => e.FirstName)
            .Select(e => new EmployeeListItem(
                e.EmployeeId, e.EmployeeNumber, e.FirstName,
                e.LastName, e.Email, e.EmploymentStatus,
                e.DepartmentId ?? 0, e.HireDate))
            .ToListAsync(cancellationToken);
    }

    public async Task<EmployeeListItem?> GetByIdAsync(
        int employeeId,
        CancellationToken cancellationToken = default)
    {
        return await _db.Employees
            .AsNoTracking()
            .Where(e => e.EmployeeId == employeeId)
            .Select(e => new EmployeeListItem(
                e.EmployeeId, e.EmployeeNumber, e.FirstName,
                e.LastName, e.Email, e.EmploymentStatus,
                e.DepartmentId ?? 0, e.HireDate))
            .SingleOrDefaultAsync(cancellationToken);
    }

    public async Task<IReadOnlyList<EmployeeListItem>> SearchAsync(
        string? searchTerm,
        CancellationToken cancellationToken = default)
    {
        var query = _db.Employees.AsNoTracking();

        if (!string.IsNullOrWhiteSpace(searchTerm))
        {
            var term = searchTerm.Trim();
            query = query.Where(e =>
                e.EmployeeNumber.Contains(term) ||
                e.FirstName.Contains(term) ||
                e.LastName.Contains(term) ||
                e.Email.Contains(term));
        }

        return await query
            .OrderBy(e => e.LastName)
            .ThenBy(e => e.FirstName)
            .Select(e => new EmployeeListItem(
                e.EmployeeId, e.EmployeeNumber, e.FirstName,
                e.LastName, e.Email, e.EmploymentStatus,
                e.DepartmentId ?? 0, e.HireDate))
            .ToListAsync(cancellationToken);
    }
}
