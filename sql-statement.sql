
--Select satement
SELECT Id, FirstName, LastName, Sex, DateofBirth FROM ExampleTable;


--Stored procedure
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
