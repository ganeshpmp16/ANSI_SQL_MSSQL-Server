--Subqueries - Week 3 - Day4 - Final SQL(day 3) session

Select * from tbl_Employee

SELECT * FROM tbl_Employee WHERE Employee_ID IN

(SELECT Employee_ID FROM tbl_Employee  WHERE Salary >1000)

SELECT * FROM tbl_Employee where Deptartment_ID =
(SELECT Deptartment_ID from tbl_Employee where Email='James@abc.com' OR Phone ='1234567111')


SELECT * FROM tbl_Employee where Employee_ID = 'E002'
(SELECT Employee_ID from tbl_Employee where Email='James@abc.com' OR Phone ='1234567111')

-- scalar subquery
SELECT * FROM tbl_Employee
SELECT Fname,Lname ,salary FROM tbl_Employee 
WHERE Salary >
( SELECT AVG(salary)FROM tbl_Employee)

SELECT SUM(salary) FROM tbl_Employee
SELECT AVG(salary)FROM tbl_Employee

-- correlated subquery

SELECT FName,salary,Deptartment_ID
FROM tbl_employee outerQuery
WHERE salary >
( SELECT avg(salary) FROM tbl_employee WHERE Deptartment_ID =outerQuery.Deptartment_ID)

SELECT * FROM tbl_Employee

SELECT avg(salary) FROM tbl_employee WHERE Deptartment_ID =12
SELECT avg(salary) FROM tbl_employee WHERE Deptartment_ID =11
SELECT avg(salary) FROM tbl_employee WHERE Deptartment_ID =11
SELECT avg(salary) FROM tbl_employee WHERE Deptartment_ID =12

SELECT * FROM tbl_Employee
-- nth max salary 

SELECT MAX(salary) AS 'second highest salary' FROM tbl_Employee
WHERE salary <
(SELECT MAX(salary) from tbl_Employee)

SELECT fname,salary

FROM ( 

		SELECT	Fname,
				salary,
				DENSE_RANK() OVER (ORDER BY salary DESC) as rankvalue
		FROM tbl_Employee

) AS nthsalary
WHERE rankvalue =2

select * from tbl_Employee order by salary desc


SELECT Fname,salary,DENSE_RANK() OVER (ORDER BY salary DESC) as rankvalue 
FROM tbl_Employee 


select * from tbl_Employee

-- ROW_NUMBER() RANK(), DENSE_RANK() 
-- ROW_NUMBER() - unqiue num always; no rank sharing
-- RANK() Duplicates gets same rank but next rank is skipped
--DENSE_RANK()  Duplicates gets same rank but next rank NOT SKIPPED
SELECT Fname,salary,
	   ROW_NUMBER() OVER (ORDER BY salary DESC) AS RowNumber,
	   RANK() OVER (ORDER BY salary DESC) AS RankValue,
	   DENSE_RANK() OVER( ORDER BY salary DESC) AS DenseRankValue
	   FROM tbl_Employee

	 --Scalar subquery in SELECT — show each employee's salary vs. company average
	 SELECT
			FName,
			Salary,
			(SELECT AVG(Salary) FROM tbl_Employee) AS CompanyAvgSalary,
			Salary - (SELECT AVG(Salary) FROM tbl_Employee) AS DiffFromAvg
	FROM tbl_Employee;

	-- IN: list employees who work in departments located in 'Los Angles' or 'New York'
	SELECT * FROM tbl_Dept
	SELECT * FROM tbl_Employee

	SELECT FName, LName, Deptartment_ID
	FROM   tbl_Employee
	WHERE  Deptartment_ID IN (
           SELECT Dept_ID
           FROM   tbl_Dept
           WHERE  Location IN ('LA', 'NY')
       )

	  SELECT FName, LName, Deptartment_ID
	FROM   tbl_Employee
	WHERE  Deptartment_ID IN (10,11)

	--  Derived Table (Subquery in FROM)
	-- A derived table is a subquery used in the FROM clause — it acts like a temporary inline table. 
	-- It must be given an alias.
	---- Derived table: first calculate per-department salary stats, then filter

	SELECT
    dept_stats.Deptartment_ID,
    dept_stats.AvgSalary,
    dept_stats.MaxSalary,
    dept_stats.HeadCount
FROM (
    SELECT
        Deptartment_ID,
        AVG(Salary)   AS AvgSalary,
        MAX(Salary)   AS MaxSalary,
        COUNT(*)      AS HeadCount
    FROM  tbl_Employee
    GROUP BY Deptartment_ID
) AS dept_stats         -- alias is mandatory for derived tables
WHERE dept_stats.HeadCount > 2
ORDER BY dept_stats.AvgSalary DESC;

-- CTE basic  syntax


WITH CTE_EmployeesSalary
AS
(
   SELECT Fname,salary FROM tbl_Employee
)
SELECT * FROM CTE_EmployeesSalary

-- expressions - condtional logic

SELECT
    Employee_ID,
    Salary,
    CASE
        WHEN Salary <  40000  THEN 'Grade 1 — Entry Level'
        WHEN Salary <  70000  THEN 'Grade 2 — Mid Level'
        WHEN Salary < 100000  THEN 'Grade 3 — Senior Level'
        ELSE                        'Grade 4 — Executive'
    END AS SalaryGrade
FROM tbl_Employee;

SELECT
    CASE
        WHEN Salary <  50000 THEN 'Low'
        WHEN Salary <  90000 THEN 'Medium'
        ELSE                       'High'
    END           AS SalaryBand,
    COUNT(*)      AS EmployeeCount,
    AVG(Salary)   AS AvgInBand
FROM    tbl_Employee
GROUP BY
    CASE                          -- GROUP BY must repeat the same CASE
        WHEN Salary <  50000 THEN 'Low'
        WHEN Salary <  90000 THEN 'Medium'
        ELSE                       'High'
    END;

	-- choose
	-- CHOOSE: return a value at a 1-based index position from a list
SELECT
    CHOOSE(MONTH(GETDATE()), 'Q1','Q1','Q1','Q2','Q2','Q2',
                               'Q3','Q3','Q3','Q4','Q4','Q4')
    AS CurrentQuarter,

    CHOOSE(DATEPART(WEEKDAY, GETDATE()),
           'Sunday','Monday','Tuesday','Wednesday',
           'Thursday','Friday','Saturday')
    AS DayName;

	select CHOOSE(3,'TV','Fridge','MicroOven') AS result
	SELECT DATEPART(MONTH,'2026-03-05') as [year]

	CREATE TABLE tbl_customers(CustomerId INT PRIMARY KEY,
	 CustName varchar(20),
	 phone varchar(20),
	 Mobile varchar(20),
	 WorkPhone varchar(20)
	
	)
	INSERT INTO tbl_customers VALUES(10,'Sam', '1234567890','1234567891',NULL)
	SELECT
    CustomerId,
    COALESCE(Phone, Mobile, WorkPhone, 'No contact number')
    AS BestPhone   -- returns the first non-NULL phone number
FROM tbl_customers;
select * from tbl_customers
SELECT
    WorkPhone,
      -- treat NULL as 0
    ISNULL(WorkPhone, 'No work phone number')
                            AS MyWorkPhone
FROM tbl_customers;

SELECT FName,Deptartment_ID,Salary, 
SUM(salary) OVER (PARTITION BY Deptartment_ID) AS 'TotalSalDept'
from tbl_Employee

SELECT NULLIF(10,10) AS RESULT