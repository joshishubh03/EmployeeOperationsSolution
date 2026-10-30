namespace EFCoreLab.Models
{
    public class Department
    {
        public ICollection<Employee> Employees { get; set; } = new List<Employee>();
    }
}
