using EmployeeOperationsSolution.EmployeeOperations.EFCoreLab.Models;
using Microsoft.EntityFrameworkCore;

namespace EmployeeOperationsSolution.EmployeeOperations.EFCoreLab.Data;

public class MigrationPracticeDbContext : DbContext
{
    public MigrationPracticeDbContext(
        DbContextOptions<MigrationPracticeDbContext> options) : base(options)
    {
        MigrationDemoRecords = Set<MigrationDemoRecord>();
    }

    public DbSet<MigrationDemoRecord> MigrationDemoRecords { get; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<MigrationDemoRecord>(entity =>
        {
            entity.ToTable("MigrationDemoRecords");
            entity.HasKey(x => x.MigrationDemoRecordId);
            entity.Property(x => x.Title).HasMaxLength(200).IsRequired();
            entity.Property(x => x.Notes).HasMaxLength(500);
            entity.Property(x => x.CreatedAtUtc).IsRequired();
        });
    }
}
