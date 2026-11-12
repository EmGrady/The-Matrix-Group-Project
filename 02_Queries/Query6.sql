-- Query 7: Total Inventory Value

SELECT
    p.ProductName,
    SUM(i.QuantityOnHand - i.QuantityReserved) AS TotalAvailableUnits,
    SUM(
        (i.QuantityOnHand - i.QuantityReserved) *
        (p.BasePrice + pv.PriceAdjustment)
    ) AS TotalInventoryValue
FROM Product p
JOIN ProductVariant pv 
    ON pv.ProductID = p.ProductID
JOIN Inventory i 
    ON i.SKU = pv.SKU
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalInventoryValue DESC;