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