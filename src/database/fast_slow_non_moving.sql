-- FastMoving, SlowMoving, and Non-Moving. --
WITH SalesQuantityCTE AS
(
    SELECT
        P.ProductID,
        P.Name AS ProductName,
        S.StockQty AS 'In Stock',
        P.StandardCost * S.StockQty AS 'Stock Value',
        FORMAT(MAX(SO.ShipDate), 'dd.MM.yyyy') AS 'Last Sales Date',
        DATEDIFF(
            DAY,
            CASE WHEN MAX(SO.ShipDate) IS NOT NULL THEN MAX(SO.ShipDate)
            ELSE P.StandardCostDate END,
            GETDATE()
        ) AS days_since_last_sold,
        FORMAT(P.StandardCostDate, 'dd.MM.yyyy') AS 'Last Purchase Date',
        ROUND(
            ISNULL(
                (
                    SELECT SUM(Qty) / 12
                    FROM 
                    (
                        SELECT SUM(SOD.OrderQty) AS Qty
                        FROM Sales.SalesOrderDetail SOD
                        INNER JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
                        WHERE SOH.OrderDate >= DATEADD(Month, -12, GETDATE()) AND SOD.ProductID = P.ProductID
                        UNION ALL
                        SELECT -SUM(RSD.ReturnQty) AS Qty
                        FROM Sales.SalesReturnDetail RSD
                        WHERE RSD.ReturnDate >= DATEADD(Month, -12, GETDATE()) AND RSD.ProductID = P.ProductID
                    ) AS Total
                ), 
            0), 1
        ) AS 'Avg Quantity Sold Last 12 Months'
    FROM Production.Product P
    LEFT JOIN Production.ProductInventory S ON P.ProductID = S.ProductID
    LEFT JOIN Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
    LEFT JOIN Sales.SalesOrderHeader SO ON SOD.SalesOrderID = SO.SalesOrderID
    WHERE P.ProductSubcategoryID IS NOT NULL
    GROUP BY P.ProductID, P.Name, S.StockQty, P.StandardCost, P.StandardCostDate
),
SKUStatsCTE AS
(
    SELECT
        ProductID,
        ProductName,
        InStock,
        StockValue,
        LastSalesDate,
        days_since_last_sold,
        LastPurchaseDate,
        AvgQuantitySoldLast12Months,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY AvgQuantitySoldLast12Months) OVER () AS Top25Percentile,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY AvgQuantitySoldLast12Months) OVER () AS Bottom25Percentile
    FROM SalesQuantityCTE
),
ABCAnalysisCTE AS
(
    SELECT
        ProductID,
        ProductName,
        InStock,
        StockValue,
        LastSalesDate,
        days_since_last_sold,
        LastPurchaseDate,
        AvgQuantitySoldLast12Months,
        Top25Percentile,
        Bottom25Percentile,
        StockValue / TotalStockValue AS StockValuePercentage,
        SUM(StockValue / TotalStockValue) OVER (ORDER BY StockValue DESC) AS CumulativePercentage,
        CASE
            WHEN SUM(StockValue / TotalStockValue) OVER (ORDER BY StockValue DESC) <= 0.8 THEN 'A'
            WHEN SUM(StockValue / TotalStockValue) OVER (ORDER BY StockValue DESC) <= 0.95 THEN 'B'
            ELSE 'C'
        END AS 'ABCCategory'
    FROM SKUStatsCTE
    CROSS JOIN
    (SELECT SUM(StockValue) AS TotalStockValue FROM SKUStatsCTE) AS Total
)
SELECT
    ProductID,
    ProductName,
    InStock,
    StockValue,
    LastSalesDate,
    days_since_last_sold,
    LastPurchaseDate,
    AvgQuantitySoldLast12Months,
    ABCCategory,
    CASE
        WHEN AvgQuantitySoldLast12Months = 0 THEN 'Non-Moving'
        WHEN AvgQuantitySoldLast12Months >= Top25Percentile THEN 'FastMoving'
        ELSE 'SlowMoving' 
    END AS 'InventoryMovementType'
FROM ABCAnalysisCTE
WHERE InStock > 0
ORDER BY ABCCategory DESC, StockValue DESC;
