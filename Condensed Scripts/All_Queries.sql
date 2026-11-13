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
HAVING SUM(i.QuantityOnHand - i.QuantityReserved) > 0
ORDER BY TotalAvailableUnits DESC;

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

-- Query 4: Products Priced Above Overall Average

SELECT
    ProductName,
    BasePrice
FROM Product
WHERE BasePrice >
(
    SELECT ROUND(AVG(BasePrice), 2)
    FROM Product
)
ORDER BY BasePrice DESC;

-- Query 5: Products and Their Categories

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

-- Query 6: Total Inventory Value

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

-- Query 8: Customer Order Summary

SELECT
    u.UserID,
    CONCAT(u.FirstName, ' ', u.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.GrandTotal) AS TotalSpent
FROM User u
JOIN Orders o 
    ON u.UserID = o.UserID
GROUP BY u.UserID
ORDER BY TotalSpent DESC;

-- Query 9: Orders Using Discounts

SELECT
    o.OrderID,
    d.DiscountCode,
    d.DiscountType,
    od.DiscountAmount,
    o.GrandTotal
FROM Orders o
JOIN OrderDiscount od 
    ON od.OrderID = o.OrderID
JOIN Discount d 
    ON d.DiscountID = od.DiscountID
ORDER BY od.DiscountAmount DESC;

-- Query 10: Customer Payment Summary

SELECT
    CONCAT(u.FirstName, ' ', u.LastName) AS CustomerName,
    COUNT(ot.TransactionID) AS TransactionCount,
    ROUND(SUM(ot.TransactionAmount), 2) AS TotalPaid
FROM User u
JOIN Orders o 
    ON u.UserID = o.OrderID
JOIN OrderTransaction ot 
    ON o.OrderID = ot.OrderID
GROUP BY u.UserID
ORDER BY TotalPaid DESC;

-- Query 11: Call Procedure

CALL GetCustomerOrders(1)