-- ============================================
-- USER AND ROLE SAMPLE DATA
-- ============================================

INSERT INTO User (FirstName, LastName, Email, PasswordHash)
VALUES
('Ava', 'Reed', 'ava.reed@example.com', 'demo_hash_01'),
('Leo', 'Brooks', 'leo.brooks@example.com', 'demo_hash_02'),
('Mia', 'Patel', 'mia.patel@example.com', 'demo_hash_03'),
('Noah', 'Price', 'noah.price@example.com', 'demo_hash_04');

SELECT * FROM User;

INSERT INTO RoleType (RoleName, RoleDescription)
VALUES
('Customer', "Browse products and place orders"),
('Manager', "Maintain products and sales"),
('Warehouse Staff', "Manage stock and shipments"),
('Support', "Assist customers with orders");

SELECT * FROM RoleType;

INSERT INTO UserRole (UserID, RoleID)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1);

SELECT * FROM UserRole;

-- ============================================
-- PRODUCT CATALOG SAMPLE DATA
-- ============================================

INSERT INTO Brand (BrandName)
VALUES
('Everyday Co.'),
('Northline'),
('Fleet'),
('Brook');

SELECT * FROM Brand;

INSERT INTO Category (CategoryName)
VALUES
('Tops'),
('Bottoms'),
('Footwear'),
('Accessories');

SELECT * FROM Category;

INSERT INTO Product (ProductName, BasePrice, ProductDescription, BrandID)
VALUES
('Cotton T-Shirt', 24.00, "Soft crew-neck shirt", 1),
('Straight Jeans', 55.00, "Straight-fit denim jeans", 2),
('Running Shoes', 80.00, "Lightweight trainers", 3),
('Leather Belt', 20.00, "Casual belt", 4);

SELECT * FROM Product;

INSERT INTO ProductVariant (SKU, Style, Color, Size, ProductID)
VALUES
('TSH-NV-M', 'Casual', 'Navy', 'M', 1),
('JEA-BK-32', 'Straight', 'Black', '32', 2),
('SHO-WH-09', 'Running', 'White', '9', 3),
('BEL-BR-L', 'Classic', 'Brown', 'L', 4);

SELECT * FROM ProductVariant;

INSERT INTO Inventory (SKU, QuantityOnHand, QuantityReserved)
VALUES
('TSH-NV-M', 28, 2),
('JEA-BK-32', 11, 1),
('BEL-BR-L', 17, 1),
('SHO-WH-09', 35, 0);

SELECT * FROM Inventory;

INSERT INTO ProductCategory (ProductID, CategoryID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

SELECT * FROM ProductCategory;

-- ============================================
-- ADDRESS SAMPLE DATA
-- ============================================

-- TODO: add Countries

-- TODO: add States

-- TODO: add ZipCode

-- TODO: add Address

-- ============================================
-- PAYMENT SAMPLE DATA
-- ============================================

INSERT INTO PaymentMethod (PaymentMethodID, NameOnCard, LastFour, PaymentToken, ExpirationMonth, ExpirationYear, UserID)
VALUES
(501, 'Ava Reed', 1111, 'tok_payment_501', 8, 2028, 1),
(502, 'Leo Brooks', 2222, 'tok_payment_502', 9, 2028, 2),
(503, 'Mia Patel', 3333, 'tok_payment_503', 1, 2029, 3),
(504, 'Noah Price', 4444, 'tok_payment_504', 12, 2028, 4);

SELECT * FROM PaymentMethod;

-- TODO add BillingAddress

-- ============================================
-- DISCOUNT AND GIFT CARD SAMPLE DATA
-- ============================================

ALTER TABLE Discount 
MODIFY COLUMN DiscountType ENUM('Percentage', 'FixedAmount') NOT NULL;

INSERT INTO Discount (DiscountType, DiscountValue, DiscountCode, StartDate, EndDate)
VALUES
('Percentage', 10.00, 'SAVE10', '2026-01-01 00:00:00', '2026-12-31 23:59:59'),
('Percentage', 15.00, 'WELCOME15', '2026-01-01 00:00:00', '2027-01-01 23:59:59'),
('FixedAmount', 5.00, 'TAKE5', '2026-02-01 00:00:00', '2026-12-31 23:59:59'),
('FixedAmount', 10.00, 'HOLIDAY10', '2026-11-01 00:00:00', '2027-01-01 23:59:59');

SELECT * FROM Discount;

INSERT INTO GiftCard (Code, InitialAmount, CurrentBalance, ExpireDate)
VALUES
('GIFT-1001-ABCD', 25.00, 25.00, '2027-12-31'),
('GIFT-1002-EFGH', 50.00, 35.00, '2027-06-30'),
('GIFT-1003-IJKL', 100.00, 0.00, '2028-12-31'),
('GIFT-1004-MNOP', 75.00, 50.00, NULL);

SELECT * FROM GiftCard;

-- ============================================
-- ORDERS SAMPLE DATA
-- ============================================