using System;
using System.Collections.Generic;
using System.Text;

namespace EmployeeOperations.Application.Employees
{
    // Example assumes Employee.HireDate is DateOnly?.
    // Change this property to the exact CLR type in your existing entity.
    public sealed record EmployeeListItem(
        int EmployeeId,
        string EmployeeNumber,
        string FirstName,
        string LastName,
        string Email,
        string EmploymentStatus,
        int DepartmentId,
        DateTime HireDate);

}
