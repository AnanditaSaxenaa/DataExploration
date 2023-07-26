-- Salary Data Exploration
-- Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views

use PortfolioProject;

SELECT * FROM salaryinfo
ORDER BY 2,6;

SELECT * FROM salaryloc 
ORDER BY 2,3;

SELECT Age,job,Experience,Education FROM salaryinfo
ORDER BY 1,3;

SELECT job,Salary FROM salaryinfo
WHERE Age = 21
ORDER BY 1,2;

SELECT Country,Race FROM salaryloc 
WHERE Country LIKE 'u%'
ORDER BY 1;

SELECT job,MAX(Salary) as Maximum_Salary,AVG(Salary) as Average_Salary FROM salaryinfo
GROUP BY job
ORDER BY Average_Salary ASC;

SELECT AVG(Salary) as AverageSalary,Country FROM salaryloc 
GROUP BY Country
ORDER BY AverageSalary;

SELECT Count('job') as number_of_jobs, Country,job 
FROM salaryinfo 
INNER JOIN salaryloc 
ON 
salaryinfo.Sno= salaryloc.Sno
GROUP BY Country,job
ORDER BY number_of_jobs desc;

SELECT Country, job, AVG(salaryinfo.Salary) as AverageSalary
FROM salaryinfo 
INNER JOIN salaryloc 
ON salaryinfo.Sno = salaryloc.Sno
GROUP BY Country, job
ORDER BY AverageSalary DESC;

SELECT Country, job, MAX(salaryinfo.Salary) as MaximumSalary
FROM salaryinfo 
INNER JOIN salaryloc 
ON salaryinfo.Sno = salaryloc.Sno
GROUP BY Country, job
ORDER BY MaximumSalary DESC;

SELECT count(distinct(job)) as Number_of_jobs ,country FROM salaryinfo
JOIN salaryloc 
ON 
salaryinfo.Sno = salaryloc.Sno
GROUP BY Country
ORDER BY Number_of_jobs desc;

SELECT country,Gender,COUNT(job) as JobsPerGenderAndCountry
FROM salaryinfo
JOIN salaryloc ON salaryinfo.Sno = salaryloc.Sno
GROUP BY Gender,country
ORDER BY country DESC;


SELECT 
    sl.Country,
    si.Gender,
    si.Salary,
    AVG(si.Salary) OVER (PARTITION BY sl.Country, si.Gender) AS AverageSalaryPerGenderAndCountry
FROM 
    salaryinfo si
JOIN 
    salaryloc sl ON si.Sno = sl.Sno;
    
SELECT Education, job, ROUND(AVG(Experience)) AS AvgExperience
FROM salaryinfo
GROUP BY job, Education;

WITH salVSavg(Country,Gender,Salary,AverageSalaryPerGenderAndCountry)
as
(
 SELECT 
    sl.Country,
    si.Gender,
    si.Salary,
    AVG(si.Salary) OVER (PARTITION BY sl.Country, si.Gender) AS AverageSalaryPerGenderAndCountry
 FROM 
    salaryinfo si
 JOIN 
    salaryloc sl ON si.Sno = sl.Sno
)
SELECT Country,Gender,ROUND(AverageSalaryPerGenderAndCountry) FROM salVSavg 
GROUP BY Country,Gender,AverageSalaryPerGenderAndCountry;

DROP TABLE IF EXISTS AverageSalary;
CREATE TEMPORARY TABLE AverageSalary 
(
Country varchar(255),
Gender varchar(255),
Salary numeric,
Age numeric
);
INSERT INTO AverageSalary
SELECT 
    sl.Country,
    si.Gender,
    si.Salary,
    si.Age
 FROM 
    salaryinfo si
 JOIN 
    salaryloc sl ON si.Sno = sl.Sno;
    

SELECT Age,AVG(Salary) as AverageSalary ,Country,Gender FROM AverageSalary
WHERE Gender = "Female"
GROUP BY Age,Country,Gender
ORDER BY Age;

CREATE VIEW SummarizedInfo AS
SELECT AVG(si.Salary) as AverageSalary,Age,Education,Country
FROM salaryinfo si
JOIN salaryloc sl ON
si.Sno = sl.Sno
GROUP BY Education,Country,Age;














