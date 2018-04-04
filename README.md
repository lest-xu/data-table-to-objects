# data-table-to-objects
convert mssql data table to list of objects in c#
## Description
This is a `C#` example code that shows you how to convert a ms-sql command or stored procedure to a list of objects in `C#`

## How?
### Table Content
1. [Prepare sql statement](#prepare-sql-statement)
2. [Prepare data object](#prepare-data-object)
3. [DataTable Select](#datatable-select)
4. [Function: ExcuteObject](#function-excuteobject)
5. [Result](#result)

### Prepare sql statement  
Let's create a sample of select statement and stored procedure:
* #### Select satement
```sql
SELECT Id, FirstName, LastName, Sex, DateofBirth FROM ExampleTable
```
* #### Stored procedure
```sql
CREATE PROCEDURE [dbo].[usp_GetListofPeople]  

AS

 BEGIN

	--Declare Local Variables
	DECLARE		@Procedure_Name     varchar(100),
                @Error_Num          int,
                @Error_Message      varchar(1000)

	BEGIN TRY

	SELECT  
		 Id AS Id
		 , FirstName AS FirstName
		 , LastName AS LastName
		 , Sex AS Sex
		 , DateofBirth AS DateofBirth

	FROM		[dbo].[ExampleTable]

	ORDER BY  CAST(Id AS INT)
		
	END TRY

	BEGIN CATCH

		SET @Error_Num = ERROR_NUMBER()
		SET @Error_Message = ERROR_MESSAGE()
	    
		RAISERROR(@Error_Message,15,1,@Procedure_Name) WITH NOWAIT, SETERROR
	    
	END CATCH

END
```
### Prepare data object
Then, we are going to create a object <b>`Person.cs`</b> in `c#`:
```c#
public int ID { get; set; }
public string FirstName { get; set; }
public string LastName { get; set; }
public char Sex { get; set; }
public DateTime DateofBirth { get; set; }
```
### DataTable Select
The function to select a stored procedure or sql command text and return it as data table:
```c#
	public DataTable Select(string storedProcedureorCommandText, bool isStoredProcedure = true)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection("ConnectionString"))
            {
                using (SqlCommand command = new SqlCommand())
                {
                    command.Connection = connection;
                    command.CommandType = CommandType.StoredProcedure;
                    if (!isStoredProcedure)
                    {
                        command.CommandType = CommandType.Text;
                    }
                    command.CommandText = storedProcedureorCommandText;
                    connection.Open();

                    SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                    dataAdapter.Fill(dataTable);

                    return dataTable;
                }
            }
        }
```
### Function: ExcuteObject
The function for converting the data table to a list of objects:
```c#
	public IEnumerable<T> ExcuteObject<T> (string storedProcedureorCommandText, bool isStoredProcedure = true)
        {
            List<T> items = new List<T>();
            var dataTable = Select(storedProcedureorCommandText, isStoredProcedure); //this will use the DataTable Select function
            foreach (var row in dataTable.Rows)
            {
                T item = (T)Activator.CreateInstance(typeof(T), row);
                items.Add(item);
            }
            return items;
        }
```
### Result
* #### Run the sql select statement
```c#
List<Person> people = new List<Person>();
people = ExcuteObject<Person>("SELECT Id, FirstName, LastName, Sex, DateofBirth FROM ExampleTable", false).ToList();
//do something with the result - people


```
* #### Run the sql stored procedure statement
```c#
List<Person> people = new List<Person>();
people = ExcuteObject<Person>("[dbo].[usp_GetListofPeople]", true).ToList();
//do something with the result - people


```
