namespace EmployeeOperations.Application.Employees;

public interface IEmployeeRepository
{
    Task<IReadOnlyList<EmployeeListItem>> GetAllAsync(
        CancellationToken cancellationToken = default);

    Task<EmployeeListItem?> GetByIdAsync(
        int employeeId,
        CancellationToken cancellationToken = default);

    Task<IReadOnlyList<EmployeeListItem>> SearchAsync(
        string? searchTerm,
        CancellationToken cancellationToken = default);
}
