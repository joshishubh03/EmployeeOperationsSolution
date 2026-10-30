namespace EFCoreLab.Entites
{
    public sealed class Department
    {
        public int DepartmentId { get; set; }
        public string DepartmentName { get; set; } = string.Empty;
        public string? Location { get; set; }
        public DateTime CreatedAtUtc { get; set; }

        public ICollection<Employee> Employees { get; set; } = new List<Employee>();
    }
}
