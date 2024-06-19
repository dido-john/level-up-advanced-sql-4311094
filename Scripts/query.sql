SELECT *
FROM employee;


SELECT strftime('%m', soldDate) as "month"
FROM sales
LIMIT 5;

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

with YearlySales AS (

Select strftime('%Y', soldDate) as "Year", salesAmount

from sales)

SELECT Year , FORMAT("$%.2f", sum(salesAmount)) AS annualSales 

FROM YearlySales
GROUP BY Year;

With MonthlySales21 as(
SELECT  B.firstName as FN, B.lastName as LN, A.soldDate, 
      CASE WHEN strftime('%m', A.soldDate) = '01'
      THEN salesAmount END AS JanSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '02'
      THEN salesAmount END AS FebSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '03'
      THEN salesAmount END AS MarSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '04' 
      THEN salesAmount END AS AprSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '05' 
      THEN salesAmount END AS MaySales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '06' 
      THEN salesAmount END AS JunSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '07' 
      THEN salesAmount END AS JulSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '08' 
      THEN salesAmount END AS AugSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '09' 
      THEN salesAmount END AS SepSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '10' 
      THEN salesAmount END AS OctSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '11' 
      THEN salesAmount END AS NovSales,
  CASE 
      WHEN strftime('%m', A.soldDate) = '12' 
      THEN salesAmount END AS DecSales
         
FROM sales A 
inner join employee B
ON ( A.employeeId = B.employeeId) 
WHERE  (B.title = 'Sales Person') AND (A.soldDate >='2021-01-01' AND A.soldDate < '2022-01-01') )


SELECT FN, LN, sum(JanSales) as "Jan", sum(FebSales) "Feb", SUM(MarSales) Mar, SUM(AprSales) Apr, SUM(MaySales) May,
SUM(JunSales) as Jun, SUM(JulSales) as Jul, SUM(AugSales) Aug, SUM(SepSales) Sep, SUM(OctSales) Oct, SUM(NovSales)as Nov ,
SUM(DecSales) as Dec


FROM MonthlySales21
GROUP BY FN, LN
ORDER BY LN, FN;


SELECT s.soldDate, s.salesAmount, i.colour, i.year
FROM sales s 
INNER JOIN inventory i 
on s.inventoryId = i.inventoryId
where i.modelId in ( SELECT ModelId FROM model where EngineType = 'Electric');

