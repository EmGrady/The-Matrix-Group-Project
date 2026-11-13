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