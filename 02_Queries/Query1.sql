-- Query 1: Available Inventory by Product Variant

SELECT
    b.BrandName,
    p.ProductName,
    pv.SKU,
    pv.Size,
    pv.Color,
    (i.QuantityOnHand - i.QuantityReserved) AS AvailableUnits
FROM Brand b
JOIN Product p
    ON p.BrandID = b.BrandID
JOIN ProductVariant pv
    ON pv.ProductID = p.ProductID
JOIN Inventory i
    ON i.SKU = pv.SKU
WHERE (i.QuantityOnHand - i.QuantityReserved) > 0
ORDER BY b.BrandName, p.ProductName;