-- USER AND ROLE SAMPLE DATA

INSERT INTO User
(UserID, FirstName, LastName, Email, PasswordHash)
VALUES
(1, 'Ava', 'Reed', 'ava.reed@example.com', 'demo_hash_01'),
(2, 'Leo', 'Brooks', 'leo.brooks@example.com', 'demo_hash_02'),
(3, 'Mia', 'Patel', 'mia.patel@example.com', 'demo_hash_03'),
(4, 'Noah', 'Price', 'noah.price@example.com', 'demo_hash_04');

SELECT * FROM User;

INSERT INTO RoleType
(RoleName, RoleDescription)
VALUES
('Customer', "Browse products and place orders"),
('Manager', "Maintain products and sales"),
('Warehouse Staff', "Manage stock and shipments"),
('Support', "Assist customers with orders");

SELECT * FROM RoleType;

INSERT INTO UserRole
(UserID, RoleID)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1);

SELECT * FROM UserRole;

-- ADDRESS SAMPLE DATA

INSERT INTO Countries
(CountryCode, CountryName)
VALUES
    ('US', 'United States'),
    ('CA', 'Canada'),
    ('MX', 'Mexico'),
    ('GB', 'United Kingdom');

SELECT * FROM Countries;

INSERT INTO States
(CountryCode, StateCode, StateName)
VALUES
    ('US', 'NC', 'North Carolina'),
    ('US', 'SC', 'South Carolina'),
    ('US', 'VA', 'Virginia'),
    ('US', 'GA', 'Georgia');

SELECT * FROM States;

INSERT INTO ZipCode
(ZipCodeID, PostalCode, City, State, Country)
VALUES
    (1, '28202', 'Charlotte', 'NC', 'US'),
    (2, '28025', 'Concord', 'NC', 'US'),
    (3, '28078', 'Huntersville', 'NC', 'US'),
    (4, '28105', 'Matthews', 'NC', 'US');

SELECT * FROM ZipCode;

INSERT INTO Address
(AddressType, AddressLine1, RecipientFirstName,
 RecipientLastName, ZipCodeID, UserID)
VALUES
('Shipping','12 Oak St','Ava','Reed',1,1),
('Billing','12 Oak St','Ava','Reed',1,1),
('Shipping','45 Pine Ave','Leo','Brooks',2,2),
('Billing','45 Pine Ave','Leo','Brooks',2,2),
('Shipping','18 Cedar Rd','Mia','Patel',3,3),
('Billing','18 Cedar Rd','Mia','Patel',3,3),
('Shipping','77 Elm Ln','Noah','Price',4,4),
('Billing','77 Elm Ln','Noah','Price',4,4);

SELECT * FROM Address;

-- PAYMENT SAMPLE DATA
INSERT INTO PaymentMethod
(PaymentMethodID, NameOnCard, LastFour, PaymentToken, ExpirationMonth, ExpirationYear, UserID)
VALUES
(501, 'Ava Reed', 1111, 'tok_payment_501', 8, 2028, 1),
(502, 'Leo Brooks', 2222, 'tok_payment_502', 9, 2028, 2),
(503, 'Mia Patel', 3333, 'tok_payment_503', 1, 2029, 3),
(504, 'Noah Price', 4444, 'tok_payment_504', 12, 2028, 4);

SELECT * FROM PaymentMethod;

INSERT INTO BillingAddress
(PaymentMethodID, AddressID)
VALUES
(501, 2),
(502, 4),
(503, 6),
(504, 8);

SELECT * FROM BillingAddress;

-- DISCOUNT AND GIFT CARD SAMPLE DATA

INSERT INTO Discount
(DiscountType, DiscountValue, DiscountCode, StartDate, EndDate)
VALUES
('Percentage', 10.00, 'SAVE10', '2026-01-01 00:00:00', '2026-12-31 23:59:59'),
('Percentage', 15.00, 'WELCOME15', '2026-01-01 00:00:00', '2027-01-01 23:59:59'),
('FixedAmount', 5.00, 'TAKE5', '2026-02-01 00:00:00', '2026-12-31 23:59:59'),
('FixedAmount', 10.00, 'HOLIDAY10', '2026-11-01 00:00:00', '2027-01-01 23:59:59');

SELECT * FROM Discount;

INSERT INTO GiftCard
(Code, InitialAmount, CurrentBalance, ExpireDate)
VALUES
('GIFT-1001-ABCD', 25.00, 25.00, '2027-12-31'),
('GIFT-1002-EFGH', 50.00, 35.00, '2027-06-30'),
('GIFT-1003-IJKL', 100.00, 0.00, '2028-12-31'),
('GIFT-1004-MNOP', 75.00, 50.00, NULL);

SELECT * FROM GiftCard;

-- PRODUCT CATALOG SAMPLE DATA

INSERT INTO Brand
(BrandID, BrandName)
VALUES
(1, 'Everyday Co.'),
(2, 'Northline'),
(3, 'Fleet'),
(4, 'Brook');

SELECT * FROM Brand;

INSERT INTO Category
(CategoryID, CategoryName)
VALUES
(1, 'Tops'),
(2, 'Bottoms'),
(3, 'Footwear'),
(4, 'Accessories');

SELECT * FROM Category;

INSERT INTO Product
(ProductName, BasePrice, ProductDescription, BrandID)
VALUES
('Cotton T-Shirt', 24.00, "Soft crew-neck shirt", 1),
('Straight Jeans', 55.00, "Straight-fit denim jeans", 2),
('Running Shoes', 80.00, "Lightweight trainers", 3),
('Leather Belt', 20.00, "Casual belt", 4);

SELECT * FROM Product;

INSERT INTO ProductVariant
(SKU, Style, PriceAdjustment, Color, Size, ProductID)
VALUES
('TSH-NV-M','Casual',0.00,'Navy','M',1),
('JEA-BK-32','Straight',0.00,'Black','32',2),
('SHO-WH-09','Running',5.00,'White','9',3),
('BEL-BR-L','Classic',0.00,'Brown','L',4);

SELECT * FROM ProductVariant;

INSERT INTO Inventory
(SKU, QuantityOnHand, QuantityReserved)
VALUES
('TSH-NV-M', 28, 2),
('JEA-BK-32', 11, 1),
('BEL-BR-L', 17, 1),
('SHO-WH-09', 35, 0);

SELECT * FROM Inventory;

INSERT INTO ProductCategory
(ProductID, CategoryID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

SELECT * FROM ProductCategory;

-- ORDERS SAMPLE DATA

-- Activate GenerateTrackingNumber Trigger --

INSERT INTO Orders
(
    OrderID,
    OrderStatus,
    Subtotal,
    DiscountAmount,
    TaxAmount,
    GrandTotal,
    UserID,
    ShippingAddressID
)
VALUES
(1, 'Delivered', 48.00, 4.80, 3.01, 46.21, 1, 1),
(2, 'Shipped',   55.00, 8.25, 3.27, 50.02, 2, 3),
(3, 'Shipped',   85.00, 5.00, 5.60, 85.60, 3, 5),
(4, 'Delivered', 20.00,10.00, 0.70, 10.70, 4, 7);

SELECT * FROM Orders;

INSERT INTO OrderItem
(SKU, OrderID, Quantity, UnitPrice)
VALUES
('TSH-NV-M',1,2,24.00),
('JEA-BK-32',2,1,55.00),
('SHO-WH-09',3,1,85.00),
('BEL-BR-L',4,1,20.00);

SELECT * FROM OrderItem;

INSERT INTO OrderDiscount
(OrderID, DiscountID, DiscountAmount)
VALUES
(1,1,4.80),
(2,2,8.25),
(3,3,5.00),
(4,4,10.00);

SELECT * FROM OrderDiscount;
INSERT INTO OrderTransaction
(TransactionAmount,
 TransactionStatus,
 OrderID,
 PaymentMethodID)
VALUES
(43.20, 'Completed', 1, 501),
(46.75, 'Completed', 2, 502),
(80.00, 'Completed', 3, 503),
(10.00, 'Completed', 4, 504);

SELECT * FROM OrderTransaction;

-- RETURN SAMPLE DATA

INSERT INTO ProductReturn
(ReturnReason,
 ReturnQuantity,
 RefundAmount,
 SKU,
 OrderID)
VALUES
('Wrong size', 1, 24.00, 'TSH-NV-M', 1),
('Changed mind', 1, 20.00, 'BEL-BR-L', 4);

-- CART SAMPLE DATA

INSERT INTO Cart
(UserID)
VALUES
(1), 
(2), 
(3), 
(4);

SELECT * FROM Cart;

INSERT INTO CartItem
(SKU, CartID, Quantity)
VALUES
('JEA-BK-32', 1, 1),
('SHO-WH-09', 1, 1),
('TSH-NV-M', 2, 2),
('BEL-BR-L', 3, 1),
('TSH-NV-M', 4, 1),
('SHO-WH-09', 4, 1);