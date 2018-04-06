using System;
using System.ComponentModel;
using System.Data;

namespace example.Models
{
    public class Person
    {
      public int ID { get; set; }
      public string FirstName { get; set; }
      public string LastName { get; set; }
      public char Sex { get; set; }
      public DateTime DateofBirth { get; set; }
    }
}
