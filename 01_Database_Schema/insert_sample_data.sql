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