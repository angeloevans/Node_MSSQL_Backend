-- Total & Monthly Average Sales calculations for 2024 & 2025 --
SELECT 
C.CustomerID, 
C.CompanyName, 
(SUM(CASE WHEN YEAR(SOH.OrderDate) = 2024 THEN SOH.TotalDue ELSE 0 END)) AS 'a_2024',
(SUM(CASE WHEN YEAR(SOH.OrderDate) = 2024 THEN SOH.TotalDue ELSE 0 END) / 12) AS 'a_2024AverageSales',
(SUM(CASE WHEN YEAR(SOH.OrderDate) = 2025 THEN SOH.TotalDue ELSE 0 END)) AS 'b_2025',
(SUM(CASE WHEN YEAR(SOH.OrderDate) = 2025 THEN SOH.TotalDue ELSE 0 END) / MONTH(GETDATE())) AS 'b_2025AverageSales'
FROM 
Sales.Customer C
LEFT JOIN 
Sales.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
WHERE 
C.CustomerID IS NOT NULL
GROUP BY 
C.CustomerID, 
C.CompanyName
