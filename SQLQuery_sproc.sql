--- sql server  part 2 

CREATE TABLE tbl_Student (StudNo int not null, -- primary key creates clustered index 
Student_Name varchar(50) not null,
Grade char(3) not null)


insert into tbl_Student values(1000,'John','A+')
insert into tbl_Student values(1001,'Wasim','B+')
insert into tbl_Student values(1003,'Wasim','C')

if EXISTS(SELECT name FROM sys.indexes  
            WHERE name = N'IX_tbl_Student_StudNo')


SELECT name FROM sys.indexes WHERE name = N'IX_tbl_Student_StudNo'
--(in lower version this work)

DROP INDEX IX_tbl_Student_StudNo ON tbl_Student
GO

CREATE CLUSTERED INDEX IX_tbl_Student_StudNo  
    ON dbo.tbl_Student(StudNo) 
GO

sp_helpindex tbl_Student

if EXISTS(SELECT name FROM sys.indexes  
            WHERE name = N'IX_tbl_Student_StudentName')

DROP INDEX IX_tbl_Student_StudentName ON tbl_Student
GO
CREATE NONCLUSTERED INDEX IX_tbl_Student_StudentName  
    ON dbo.tbl_Student(Student_Name) 

GO

-- view 

create view vw_Upg_Dept_Emp as         
 SELECT D.Dept_ID,D.Dept_Name ,E.Employee_ID,E.FName,E.LName 
 FROM [dbo].[tbl_Dept] D INNER JOIN [dbo].[tbl_Employee] E 
 ON D.Dept_ID = E.Deptartment_ID

 select * from vw_Upg_Dept_Emp where Dept_ID=11
 
 -- schemabinding
 ALTER VIEW [vw_Upg_Dept_Emp] with schemabinding AS 
 SELECT D.Dept_ID,D.Dept_Name, D.[Location],E.Employee_ID,E.FName,E.LName,E.Age 
 FROM [dbo].[tbl_Dept] D INNER JOIN [dbo].[tbl_Employee] E 
 ON D.Dept_ID = E.Deptartment_ID

 --indexing the view afer thes schema is bound
 create unique clustered index IX_Vw
 on [vw_Upg_Dept_Emp](Dept_ID,Employee_ID)

 delete [vw_Upg_Dept_Emp] where Dept_iD =11
  
  update [vw_Upg_Dept_Emp] set [Location] ='CA' where
  Employee_ID ='E002'

  SELECT * FROM [vw_Upg_Dept_Emp]

  SELECT * FROM tbl_Dept
  SELECT * FROM tbl_Employee
  SELECT age FROM tbl_Employee where
  Employee_ID ='E002'

  update [vw_Upg_Dept_Emp] set age =50 where
  Employee_ID ='E002'
  -- stored procedure 

  CREATE PROCEDURE sproc_Insert_Dept
    
    @DeptId int,
    @deptName varchar(50),
    @location char(2)  
AS
BEGIN
    
    IF EXISTS(SELECT 1 FROM tbl_Dept WHERE Dept_ID = @DeptId)
	 BEGIN
			print 'The department already exists'
	END
ELSE
	BEGIN
           insert into tbl_Dept values (@DeptId,@deptName,@location)
	END
END  

-- EXEC sproc_Insert_Dept 14,'OP','AU'