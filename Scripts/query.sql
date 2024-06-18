SELECT *
FROM employee;


SELECT *
FROM sales;

GO

SELECT  A.firstName , A.lastName, B.firstName, B.lastName
FROM employee A ,employee B
ON ( A.employeeId = B.managerId) 
--WHERE B.managerId is not NULL
;

SELECT model, EngineType
FROM model
LIMIT 5;

SELECT sql 
FROM sqlite_schema 
WHERE name = 'employee';

SELECT  A.firstName , A.lastName, B.salesAmount as total
FROM employee A 
left join sales B
ON ( A.employeeId = B.employeeId) 
WHERE B.salesAmount is NULL or B.salesAmount=0


;