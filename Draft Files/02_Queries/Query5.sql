-- Query 6: Products and Their Categories

SELECT
    p.ProductName,
    b.BrandName,
    c.CategoryName,
    p.BasePrice
FROM Product p
JOIN Brand b 
    ON b.BrandID = p.BrandID
JOIN ProductCategory pc 
    ON pc.ProductID = p.ProductID
JOIN Category c 
    ON c.CategoryID = pc.CategoryID
ORDER BY c.CategoryName, p.ProductName;