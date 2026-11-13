-- If executing in VS Code, select CREATE until END
-- Do not select DELIMITER lines or '//' after END

DELIMITER //
CREATE TRIGGER GenerateTrackingNumber
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE tracking_id CHAR(32);

    SET tracking_id = REPLACE(UPPER(UUID()), '-', '');

    SET NEW.TrackingNumber = CONCAT(
        'TRK-',
        SUBSTRING(tracking_id, 1, 4), '-',
        SUBSTRING(tracking_id, 5, 4), '-',
        SUBSTRING(tracking_id, 9, 4)
    );
END //
DELIMITER ;