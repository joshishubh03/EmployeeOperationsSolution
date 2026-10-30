using EFCoreLab.Entites;

namespace EFCoreLab.Models
{
    public class Project
    {
        public ICollection<EmployeeProject> EmployeeProjects { get; set; } = new List<EmployeeProject>();

    }
}
