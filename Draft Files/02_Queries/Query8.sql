-- Query 3: Customer Order Summary

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