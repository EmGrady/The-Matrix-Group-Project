-- Query 2: Inventory Summary by Category

SELECT
    c.CategoryName,
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    COUNT(pv.SKU) AS VariantCount,
    SUM(i.QuantityOnHand - i.QuantityReserved) AS TotalAvailableUnits
FROM Category c
JOIN ProductCategory pc
    ON pc.CategoryID = c.CategoryID
JOIN Product p
    ON p.ProductID = pc.ProductID
JOIN ProductVariant pv
    ON pv.ProductID = p.ProductID
JOIN Inventory i
    ON i.SKU = pv.SKU
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalAvailableUnits DESC;