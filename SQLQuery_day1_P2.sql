USE [Upg_CT_DB]
GO

SELECT [Dept_ID]
      ,[Dept_Name]
      ,[Location]
  FROM [dbo].[tbl_Dept]

GO

GRANT SELECT ON [dbo].[tbl_Dept] TO USERNAME

REVOKE SELECT ON [dbo].[tbl_Dept] TO USERNAME
CREATE TABLE STUDENT (ID INT)
go
begin tran t  
	declare @id int;  
	set @id=8;  
	insert into [dbo].[student] values(@id)  
	if(@id<10)  
		begin  
				print'An id less than 10 is not valid; query is rolled back';  
	rollback tran t;  
	end   
	else  
		begin  
				print 'data is inserted'  
	commit
	end  

	select * from STUDENT

	create schema UpgSchema
	select * from sys.schemas