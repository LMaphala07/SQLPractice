CREATE TABLE Employeedemographics(
EmployeeID int,
Firstname varchar (50),
Lastname varchar (50),
Age int,
Gender varchar (50)
);

CREATE TABLE EmployeeSalary (
EmployeeID int,
Jobtitle varchar (50),
Salary int
);


INSERT INTO Employeedemographics values
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

Insert Into EmployeeSalary values
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)

/*
Select statement ,*, top, distinct, count, as, max, min, avg
*/

select *
from Employeedemographics

/*top*/
select top 5*
from Employeedemographics

select distinct EmployeeID, Gender
from Employeedemographics

select COUNT (Lastname) 
from Employeedemographics

select COUNT (Lastname) as Lastname 
from Employeedemographics

select*
from EmployeeSalary

select MIN(Salary)
from EmployeeSalary

select MAX(Salary)
from EmployeeSalary

select AVG(Salary)
from EmployeeSalary

/*
Where statement
=,<>,<,>, And, Or, Like, NULL, Not null, In
*/

select*
from Employeedemographics
where Firstname = 'Jim'

select*
from Employeedemographics
where Firstname < 'Michael'

select*
from Employeedemographics
where Age >=35

select*
from Employeedemographics
where Age = 30 or Age = 32

select*
from Employeedemographics
where Age = 30 and Gender = 'Male'

select*
from Employeedemographics	
where LastName Like 'S%'

select*
from Employeedemographics
where Firstname is NULL

select*
from Employeedemographics
where Firstname is NOT NULL

select*
from Employeedemographics
where Firstname IN ('Jim', 'Michale')


/*
Group BY, Order By
*/

select*
from Employeedemographics
select Gender, COUNT (Gender)
FROM Employeedemographics
GROUP BY Gender

select
Gender, COUNT (Gender) as CountGender
from Employeedemographics
where Age> 31
Group by Gender

select Gender
from Employeedemographics
where Age > 31
Group by Gender
order by Gender

select
Gender, COUNT (Gender) as CountGender
from Employeedemographics
where Age> 31
Group by Gender
Order by CountGender

select
Gender, COUNT (Gender) as CountGender
from Employeedemographics
where Age> 31
Group by Gender 
Order by Gender ASC

select*
from Employeedemographics
Order by Age ASC, Gender

/*
INTERMEDIATE SQL QUERIES
*/

/*
INNER Joins, Full/Left/Right, Outer Joins
*/

select*
from Employeedemographics
Left Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

select*
from Employeedemographics
Right Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


select Employeedemographics.EmployeeID, Firstname,Lastname,Salary
from Employeedemographics
INNER JOIN EmployeeSalary
ON Employeedemographics.EmployeeID = EmployeeSalary.EmployeeID
where Firstname <> 'Michael'
Order by Salary DESC


/*
UNIONS, UNIONS ALL
*/


select*
from WareHouseEmployeeDemographics
Full Outer Join Employeedemographics
ON Employeedemographics.EmployeeID = WareHouseEmployeedemographics.EmployeeID

select*
from Employeedemographics
UNION
select*
from WareHouseEmployeeDemographics


select*
from Employeedemographics
UNION ALL
select*
from WareHouseEmployeeDemographics


/*
Case statement
*/

select Firstname, Lastname, Age,
CASE
	WHEN Age >30 THEN 'Old'
		ELSE 'Young'
END
from Employeedemographics
where Age iS NOT NULL
Order By Age


select Firstname, Lastname, Age,
CASE
	WHEN Age >30 THEN 'Old'
	WHEN AGE BETWEEN 27 AND 30 THEN 'Young'
		ELSE 'Baby'
END
from Employeedemographics



select Firstname, Lastname, Jobtitle, Salary,
CASE
	WHEN Jobtitle = 'Salesman' THEN Salary + (Salary*.10)
	WHEN Jobtitle = 'Accountant' THEN Salary + (Salary*.05)
	WHEN Jobtitle = 'HR' THEN Salary + (Salary*.000001)
	ELSE Salary + (Salary*.03)
	END AS SalaryAfterRaise
from Employeedemographics
JOIN EmployeeSalary
	ON Employeedemographics.EmployeeID = EmployeeSalary.EmployeeID

/*
Having Clause Statement
*/

select Jobtitle, COUNT(Jobtitle)
from Employeedemographics
JOIN EmployeeSalary
	ON Employeedemographics.EmployeeID = EmployeeSalary.EmployeeID
		GROUP BY Jobtitle
HAVING COUNT(Jobtitle)>1

select Jobtitle, AVG(Salary)
from Employeedemographics
JOIN EmployeeSalary
	ON Employeedemographics.EmployeeID = EmployeeSalary.EmployeeID
		GROUP BY Jobtitle
HAVING COUNT(Jobtitle)>1


/*
Updating/Deleting
*/

select*
from Employeedemographics

UPDATE Employeedemographics
SET EmployeeID = 1012
WHERE Firstname = 'Holly' AND Lastname = 'Flax'

DELETE FROM Employeedemographics
WHERE EmployeeID = 1005

/*
Aliasing
*/


select Firstname + ' ' + Lastname AS Fullname
from Employeedemographics

select Firstname Fname
from Employeedemographics

/*
Partition By
*/


SELECT Firstname, Lastname, Gender, Salary,
COUNT(Gender) OVER (PARTITION By Gender) as TotalGender
from Employeedemographics dem
JOIN EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID



/*
CTE
*/


WITH CTE_Employee as
SELECT Firstname, Lastname, Gender, Salary,
COUNT(Gender) OVER (PARTITION By Gender) as TotalGender,
AVG (Salary) OVER (PARTITION BY Gender) as AvgSalary
from Employeedemographics dem
JOIN EmployeeSalary sal
	ON dem.EmployeeID = sal.EmployeeID

/*
Temp Tables
*/

CREATE TABLE #temp_Employee (
EmployeeID int, 
Jobtitle varchar (100),
Salary int
);


select*
from #temp_Employee


INSERT INTO #temp_Employee values (
'1001', 'HR', '45000')


/*
string function-TRIM,LTRIM,RTRIM,Replace,Substring,Uper,Lower
*/

CREATE TABLE EmployeeErrors(
EmployeeID varchar (50),
Firstname varchar (50),
Lastname varchar (50)
);

Insert into EmployeeErrors Values
('1001 ', 'Jimbo', 'Halbert'),
(' 1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson-Fired')

/*
DROP TABLE EmployeeErrors
*/

Select*
from EmployeeErrors

/*
TRIMS
*/
select EmployeeID, TRIM(EmployeeID) as IDTRIM
from EmployeeErrors

select EmployeeID, LTRIM(EmployeeID) as IDTRIM
from EmployeeErrors

select EmployeeID, RTRIM(EmployeeID) as IDTRIM
from EmployeeErrors

/*
Replace
*/

select Lastname, REPLACE(Lastname, '-Fired', '') as LastnameFixed
from EmployeeErrors

/*
substring
*/

select SUBSTRING(Lastname,1,11)
from EmployeeErrors

select err.Firstname, dem.Firstname
from EmployeeErrors
JOIN Employeedemographics dem
	ON err.Firstname = dem.Firstname


/*
Upper and Lower
*/


select Firstname, LOWER (Firstname)
from EmployeeErrors

select Firstname, UPPER (Firstname), Firstname, SUBSTRING(Firstname,1,3)
from EmployeeErrors



/*
STORED PROCEDURES
*/

CREATE PROCEDURE TEST
AS
SELECT*
FROM Employeedemographics

EXEC TEST


CREATE PROCEDURE Temp_Employee
AS
CREATE TABLE #temp_Employees (
Jobtitle varchar (100),
EmployeePerJob int,
AvgAge int,
AvgSaalary int
)

INSERT INTO #temp_Employees
SELECT Jobtitle, COUNT(Jobtitle), Avg(Age), Avg(Salary)
FROM Employeedemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
Group by Jobtitle

/*
Subqueries( in the select, from, where, insert and update statements)
*/

select*
from EmployeeSalary

--subquery in select

select EmployeeID,Salary, (select AVG(Salary) from EmployeeSalary) as AllAvgSalary
from EmployeeSalary

select*
from #temp_Employees

EXEC Temp_Employee







