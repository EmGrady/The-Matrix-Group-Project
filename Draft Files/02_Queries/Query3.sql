-- Query 3: Average Product Price by Category

SELECT
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount,
    ROUND(AVG(p.BasePrice), 2) AS AveragePrice
FROM Category c
JOIN ProductCategory pc
    ON pc.CategoryID = c.CategoryID
JOIN Product p
    ON p.ProductID = pc.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY AveragePrice DESC;