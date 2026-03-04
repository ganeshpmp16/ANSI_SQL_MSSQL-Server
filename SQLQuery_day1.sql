--CREATE DATABASE Upg_CT_DB
GO
USE Upg_CT_DB
GO
CREATE TABLE  tbl_Dept(Dept_ID int Primary key,
Dept_Name varchar(50) NOT NULL, 
Location char(2) NOT NULL)
GO 
CREATE TABLE tbl_Employee(Employee_ID char(4) primary key,
FName varchar(20) NOT NULL,
LName varchar(20) NOT NULL,
[Address] varchar(200) NOT NULL,
Email varchar(60) NOT NULL,
Phone varchar(15) NOT NULL,
DOJ date NOT NULL,
Age int NOT NULL,
Deptartment_ID int NOT  NULL)
GO


insert into tbl_Employee values('E001','Steve','Smith','Aus-444','steve@abc.com','1234567890','1999-02-14',34,12)
insert into tbl_Employee values('E002','James','Anderson','Eng-4445','James@abc.com','1234567111','2000-04-14',41,11,20000)
insert into tbl_Employee values('E003','Ben','Stokes','Eng-4446','Ben@abc.com','1234567444','2001-03-18',35,11,30000)
insert into tbl_Employee values('E004','Virat','Kholi','Ind-123456','vk@abc.com','1234568444','2000-02-19',36,12,40000)

-- AND OR NOT  precedence NOT AND OR 
SELECT * FROM tbl_Employee WHERE age >40 OR SALARY >20000
SELECT * FROM tbl_Employee WHERE NOT age >40
-- AND + OR SCENARIO
SELECT * FROM tbl_Employee WHERE (AGE >40 AND salary <=20000)
OR salary >=40000

SELECT * FROM tbl_Employee WHERE salary >=20000 OR salary <=30000

SELECT * FROM tbl_Employee WHERE [Address] LIKE '%E%'
AND age >=40
ALTER TABLE tbl_Employee ADD Salary int
select * from tbl_Employee

UPDATE tbl_Employee SET salary = 10000 WHERE Employee_ID='E001'

ALTER TABLE tbl_Employee ADD CONSTRAINT fk_tbl_Employee_tbl_Dept 
FOREIGN KEY (Deptartment_ID) REFERENCES tbl_Dept(Dept_ID)
GO
--DML
INSERT INTO tbl_Dept VALUES (10,'Admin','NY')
INSERT INTO tbl_Dept VALUES (11,'HR','NJ')
INSERT INTO tbl_Dept VALUES (12,'IT','NJ')

select * from tbl_Dept
select * from tbl_Employee

select Dept_ID,Dept_Name,Location from tbl_Dept

update tbl_Dept set Location='LA' where Dept_ID=11


DELETE tbl_Dept where Dept_Name='IT'

--DCL 
-- domain integrity 
--check 

--between 
-- aggreate functions 
-- list employees order by salary 
SELECT * FROM tbl_Employee ORDER BY SALARY DESC
--List salary of employees department wise

SELECT Deptartment_ID,SUM(salary) AS 'Total salary'  FROM tbl_Employee GROUP BY Deptartment_ID ORDER BY Deptartment_ID
--List salary of employees department wise for alteast more than or one employee 

SELECT Deptartment_ID,SUM(salary) AS 'Total salary' FROM tbl_Employee GROUP BY Deptartment_ID 
HAVING COUNT( (Employee_ID )) >1
ORDER BY Deptartment_ID

-- LIST  THE NO.OF EMPLOYEES DEPARTMENTWISE IF EACH DEPT HAS MORE THAN ONE EMPLOYEE 
SELECT COUNT(Employee_ID) 'No.of employees departmentwise' ,Deptartment_ID from tbl_Employee
GROUP BY Deptartment_ID
HavING COUNT(Employee_ID) >1
-- find the no.of employees in department no.11 
SELECT Deptartment_ID, COUNT(*) 'No.of Employees' from tbl_Employee
WHERE Deptartment_ID =11
GROUP BY Deptartment_ID
SELECT AVG(salary) from tbl_Employee

