using Microsoft.EntityFrameworkCore;

namespace EmployeeOperations.Infrastructure.Data;

public sealed class Department
{
    public int DepartmentId { get; set; }
    public string DepartmentName { get; set; } = string.Empty;
    public string? Location { get; set; }
    public DateTime CreatedAtUtc { get; set; }

    public ICollection<Employee> Employees { get; set; } = new List<Employee>();
}

public sealed class Employee
{
    public int EmployeeId { get; set; }
    public string EmployeeNumber { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public DateTime HireDate { get; set; }
    public decimal Salary { get; set; }
    public string EmploymentStatus { get; set; } = "Active";
    public int? DepartmentId { get; set; }
    public DateTime CreatedAtUtc { get; set; }

    public Department? Department { get; set; }
    public ICollection<EmployeeProject> EmployeeProjects { get; set; } = new List<EmployeeProject>();
}

public sealed class Project
{
    public int ProjectId { get; set; }
    public string ProjectCode { get; set; } = string.Empty;
    public string ProjectName { get; set; } = string.Empty;
    public DateTime StartDate { get; set; }
    public DateTime? EndDate { get; set; }
    public string ProjectStatus { get; set; } = "Planned";

    public ICollection<EmployeeProject> EmployeeProjects { get; set; } = new List<EmployeeProject>();
}

public sealed class EmployeeProject
{
    public int EmployeeId { get; set; }
    public int ProjectId { get; set; }
    public string AssignedRole { get; set; } = string.Empty;
    public decimal AllocationPercent { get; set; }
    public DateTime AssignedAtUtc { get; set; }

    public Employee? Employee { get; set; }
    public Project? Project { get; set; }
}

public sealed class EmployeeOperationsDbContext : DbContext
{
    public EmployeeOperationsDbContext(DbContextOptions<EmployeeOperationsDbContext> options)
        : base(options)
    {
    }

    public DbSet<Department> Departments => Set<Department>();
    public DbSet<Employee> Employees => Set<Employee>();
    public DbSet<Project> Projects => Set<Project>();
    public DbSet<EmployeeProject> EmployeeProjects => Set<EmployeeProject>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Department>(entity =>
        {
            entity.ToTable("Departments");
            entity.HasKey(x => x.DepartmentId);
            entity.Property(x => x.DepartmentName)
                .HasMaxLength(100)
                .IsRequired();
            entity.Property(x => x.Location).HasMaxLength(100);
            entity.Property(x => x.CreatedAtUtc).HasColumnType("datetime2");
        });

        modelBuilder.Entity<Employee>(entity =>
        {
            entity.ToTable("Employees");
            entity.HasKey(x => x.EmployeeId);
            entity.Property(x => x.EmployeeNumber)
                .HasMaxLength(20)
                .IsRequired();
            entity.Property(x => x.FirstName).HasMaxLength(100).IsRequired();
            entity.Property(x => x.LastName).HasMaxLength(100).IsRequired();
            entity.Property(x => x.Email).HasMaxLength(256).IsRequired();
            entity.Property(x => x.HireDate).HasColumnType("date");
            entity.Property(x => x.Salary).HasColumnType("decimal(12,2)");
            entity.Property(x => x.EmploymentStatus)
                .HasMaxLength(20)
                .IsRequired();
            entity.Property(x => x.CreatedAtUtc).HasColumnType("datetime2");

            entity.HasOne(x => x.Department)
                .WithMany(x => x.Employees)
                .HasForeignKey(x => x.DepartmentId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Project>(entity =>
        {
            entity.ToTable("Projects");
            entity.HasKey(x => x.ProjectId);
            entity.Property(x => x.ProjectCode).HasMaxLength(30).IsRequired();
            entity.Property(x => x.ProjectName).HasMaxLength(150).IsRequired();
            entity.Property(x => x.StartDate).HasColumnType("date");
            entity.Property(x => x.EndDate).HasColumnType("date");
            entity.Property(x => x.ProjectStatus).HasMaxLength(20).IsRequired();
        });

        modelBuilder.Entity<EmployeeProject>(entity =>
        {
            entity.ToTable("EmployeeProjects");
            entity.HasKey(x => new { x.EmployeeId, x.ProjectId });
            entity.Property(x => x.AssignedRole).HasMaxLength(100).IsRequired();
            entity.Property(x => x.AllocationPercent).HasColumnType("decimal(5,2)");
            entity.Property(x => x.AssignedAtUtc).HasColumnType("datetime2");

            entity.HasOne(x => x.Employee)
                .WithMany(x => x.EmployeeProjects)
                .HasForeignKey(x => x.EmployeeId)
                .OnDelete(DeleteBehavior.Restrict);

            entity.HasOne(x => x.Project)
                .WithMany(x => x.EmployeeProjects)
                .HasForeignKey(x => x.ProjectId)
                .OnDelete(DeleteBehavior.Restrict);
        });
    }
}
