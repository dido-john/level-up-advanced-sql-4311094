SELECT *
FROM employee;


SELECT soldDate
FROM sales
LIMIT 100 ;

SELECT c.firstName, c.lastName,c.email, s.salesAmount, s.soldDate
FROM customer c
FULL OUTER JOIN sales s
ON c.customerId = s.customerId
--WHERE c.customerId any;

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

SELECT  A.firstName , A.lastName, A.title, B.salesAmount as total
FROM employee A 
left join sales B
ON ( A.employeeId = B.employeeId) 
WHERE B.salesAmount is NULL  AND A.title = 'Sales Person' 
;

SELECT  A.employeeId, A.firstName , A.lastName,count(*) as NumofCarsSold
FROM employee A 
inner join sales B
ON ( A.employeeId = B.employeeId) 
WHERE  A.title = 'Sales Person'
GROUP BY  A.employeeId, A.firstName , A.lastName
ORDER BY NumofCarsSold DESC
;

SELECT  A.employeeId, A.firstName , A.lastName,  min(B.salesAmount) as cheap , max(B.salesAmount) as expensive
FROM employee A 
INNER join sales B
ON ( A.employeeId = B.employeeId) 
--WHERE B.soldDate >= date('now', 'start of year')
GROUP BY  A.employeeId, A.firstName , A.lastName 
;

SELECT  A.employeeId, A.firstName , A.lastName,count(*) as NumofCarsSold
FROM employee A 
inner join sales B
ON ( A.employeeId = B.employeeId) 
--WHERE B.soldDate >= date('now', 'start of year')
GROUP BY  A.employeeId, A.firstName , A.lastName
HAVING NumofCarsSold > 5
--ORDER BY NumofCarsSold DESC
;