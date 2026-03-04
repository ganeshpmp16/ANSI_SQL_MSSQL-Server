
SELECT 1 + CAST(1 AS INT) result;

SELECT CAST(5.95 AS INT) result;

SELECT CAST(5.95 AS DEC(3,0)) result
-- convert - formating the data types 
SELECT 
    CONVERT(DATETIME, '2026-03-14') result;

SELECT 
    CONVERT(VARCHAR, GETDATE(),13) result

	SELECT 
    ISNULL(NULL,20) result;

	SELECT 
    IIF(10 < 20, 'True', 'False') Result ;

	SELECT 
    CASE
        WHEN TRY_CAST('test' AS varchar) IS NULL
        THEN 'Cast failed'
        ELSE 'Cast succeeded'
    END AS Result;

	
SELECT  TRY_CONVERT(DATE,'20222-02-22',13) result
SELECT  TRY_PARSE ('20222-02-22'AS DATE) result

-- SET OPERATORS 
CREATE TABLE Students2000(
Name VARCHAR(15),
TotalMark INT)
CREATE TABLE Students2005(
Name VARCHAR(15),
TotalMark INT)


INSERT INTO Students2000 VALUES('Robert',1063);
INSERT INTO Students2000 VALUES('John',1070);
INSERT INTO Students2000 VALUES('Rose',1032);
INSERT INTO Students2000 VALUES('Abel',1002);

INSERT INTO Students2005 VALUES('Robert',1063);
INSERT INTO Students2005 VALUES('Rose',1032);
INSERT INTO Students2005 VALUES('Boss',1086);
INSERT INTO Students2005 VALUES('Marry',1034);

SELECT * FROM Students2000
SELECT * FROM Students2005
/*SELECT Name,TotalMark FROM students2000 UNION
SELECT Name,TotalMark FROM students2005*/
SELECT Name,TotalMark FROM students2000 UNION ALL
SELECT Name,TotalMark FROM students2005

-- sql server - joins

select * from tbl_Dept
select * from tbl_Employee

SELECT D.Dept_ID,D.Dept_Name ,E.Employee_ID,E.FName,E.LName 
 FROM tbl_Dept  D INNER JOIN tbl_Employee E 
 ON D.Dept_ID = E.Deptartment_ID

 SELECT tbl_Dept.Dept_ID,tbl_Dept.Dept_Name ,tbl_Employee.Employee_ID,tbl_Employee.FName,tbl_Employee.LName 
 FROM tbl_Dept  INNER JOIN tbl_Employee  
 ON tbl_Dept.Dept_ID = tbl_Employee.Deptartment_ID

 insert into tbl_Dept values(13,'QC','AU')

 

 SELECT D.Dept_ID,D.Dept_Name ,E.Employee_ID,E.FName,E.LName 
 FROM tbl_Dept  D LEFT  OUTER JOIN tbl_Employee E 
 ON D.Dept_ID = E.Deptartment_ID

 SELECT D.Dept_ID,D.Dept_Name ,E.Employee_ID,E.FName,E.LName 
 FROM tbl_Dept  D FULL OUTER JOIN tbl_Employee E 
 ON D.Dept_ID = E.Deptartment_ID

 SELECT D.Dept_ID,D.Dept_Name ,E.Employee_ID,E.FName,E.LName 
 FROM tbl_Dept  D FULL OUTER JOIN tbl_Employee E 
 ON D.Dept_ID = E.Deptartment_ID

 CREATE TABLE R (A INT, B INT, C INT, D INT, E INT)
 CREATE TABLE S (D INT, E INT,F INT, G INT)
 INSERT INTO R VALUES(1,2,3,4,5)
 INSERT INTO S VALUES(4,5,6,7)
 select * from R
 select * from S
 SELECT * FROM R CROSS JOIN S
 -- self join 
 CREATE TABLE tbl_Staff(StaffID int IDENTITY(1,1) PRIMARY KEY,
Surname 	varchar(40) NOT NULL,
Given varchar(40) NOT NULL, 
DOB datetime NOT NULL,
Gender 	char(1) NOT NULL,
Joined 	datetime NOT NULL,
Resigned 	datetime  NULL,
[Address] 	varchar(50) NOT NULL,
Suburb 	varchar(30) NOT NULL,
Postcode 	varchar(6) NOT NULL,
Phone 	varchar(15) NOT NULL,
SupervisorID int NULL,
Commission 	decimal(9,2) NULL,
FOREIGN KEY(SupervisorID) REFERENCES tbl_Staff(StaffID))

INSERT INTO tbl_Staff VALUES ('C','James Smith','12-JUN-1980', 'M','13-MAY-2005','10-MAY-2010','3rd ave,NY','AA',60001,1234567890,NULL,500.00)
INSERT INTO tbl_Staff VALUES ('D','Joe Root','12-MAR-1981', 'M','20-MAY-2005','10-JUN-2009','4th ave,NY','AA',60001,2224567888,1,200.00)
INSERT INTO tbl_Staff VALUES ('E','Ben Stokes','12-MAR-1983', 'M','18-MAY-2006','11-JUN-2012','5th ave,NJ','BB',60003,3334567888,NULL,600.00)
INSERT INTO tbl_Staff VALUES ('S','Stuar Broad','15-MAR-1990', 'M','19-MAY-2006','12-JUN-2011','6th ave,CA','CC',60004,4444567888,3,400.00)
INSERT INTO tbl_Staff VALUES ('J','David Warner','18-APR-1992', 'M','20-JUL-2006','12-JUN-2010','7th ave,CA','CC',60004,5555567888,3,400.00)

-- list employee detail and the corresponding manager details  using self join

select * from tbl_Staff

SELECT S.Surname + ' ' + S.Given as 'Staff Full Name', S.Joined,S.Resigned,
 M.Surname + ' ' + M.Given  as 'Manager  Full Name', M.joined, M.resigned 
FROM tbl_Staff M INNER JOIN tbl_Staff S
ON M.StaffID =  S.SupervisorID 

CREATE TABLE tbl_Emp (
EmployeeID int PRIMARY KEY,
EmployeeName varchar(50),
ManagerId int null,
FOREIGN KEY (ManagerId) REFERENCES tbl_Emp(EmployeeID)
)

INSERT INTO tbl_Emp VALUES(101,'Veera',NULL)
INSERT INTO tbl_Emp VALUES(102,'Gopi',101)
INSERT INTO tbl_Emp VALUES(103,'Vijay',101)
INSERT INTO tbl_Emp VALUES(104,'Ravi',102)
INSERT INTO tbl_Emp VALUES(105,'Prem',102)

select * from tbl_Emp

SELECT E.EmployeeName as 'Employee',M.EmployeeName as 'Manager' FROM tbl_Emp E left  join tbl_Emp M
ON E.ManagerId = M.EmployeeID

SELECT E.EmployeeName as 'Employee',M.EmployeeName as 'Manager' FROM tbl_Emp E inner join tbl_Emp M
ON E.ManagerId = M.EmployeeID

-- find duplicate salaries using self join  table -staff StaffId,StaffName, salary 
SELECT GIVEN, Commission FROM tbl_Staff
Select E.Given,E.Commission from tbl_Staff E inner join tbl_Staff M
on E.Commission =M.Commission
AND E.StaffID <> m.StaffID
SELECT TOP 3* FROM tbl_Staff ORDER BY Commission DESC