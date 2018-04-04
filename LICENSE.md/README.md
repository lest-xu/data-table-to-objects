# data-table-to-objects
convert mssql data table to list of objects in c#
## Description
This is a `C#` example code that shows you how to convert a ms-sql command or stored procedure to a list of objects in `C#`

## How?
### Table Content
1. Prepare sql statement
2. Prepare data object
3. DataTable Select
4. Function: ExcuteObject
5. Result

### Prepare sql statement
Let's create a sample of select statement and stored procedure:
* #### Select satement
```
SELECT Id, FirstName, LastName, Sex, Age FROM ExampleTable
```
* #### Stored procedure
```
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
		 , Age AS Age

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