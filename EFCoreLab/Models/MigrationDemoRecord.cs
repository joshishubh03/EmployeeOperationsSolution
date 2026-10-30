namespace EmployeeOperationsSolution.EmployeeOperations.EFCoreLab.Models;

public class MigrationDemoRecord
{
    public int MigrationDemoRecordId { get; set; }
    public string Title { get; set; } = string.Empty;
    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;
    public string? Notes { get; set; }

}
