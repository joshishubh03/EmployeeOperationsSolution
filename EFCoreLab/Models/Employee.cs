using EFCoreLab.Entites;

namespace EFCoreLab.Models
{
    public class Employee
    {
        public Department? Department { get; set; }
        public ICollection<EmployeeProject> EmployeeProjects { get; set; } = new List<EmployeeProject>();

    }
}
