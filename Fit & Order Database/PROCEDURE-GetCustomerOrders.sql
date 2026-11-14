-- If executing in VS Code, select CREATE until END
-- Do not select DELIMITER lines or '//' after END

DELIMITER //

CREATE PROCEDURE GetCustomerOrders
(
    IN pUserID INT UNSIGNED
)
BEGIN

    SELECT
        o.OrderID,
        o.OrderDate,
        o.OrderStatus,
        o.GrandTotal
    FROM Orders o
    WHERE o.UserID = pUserID
    ORDER BY o.OrderDate DESC;

END //

DELIMITER ;