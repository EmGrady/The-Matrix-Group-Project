-- Query 7: Brand Product Statistics

SELECT
    b.BrandName,
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    COUNT(pv.SKU) AS VariantCount,
    MIN(p.BasePrice) AS LowestPrice,
    MAX(p.BasePrice) AS HighestPrice
FROM Brand b
JOIN Product p 
    ON p.BrandID = b.BrandID
JOIN ProductVariant pv 
    ON pv.ProductID = p.ProductID
GROUP BY b.BrandID, b.BrandName
ORDER BY b.BrandName;