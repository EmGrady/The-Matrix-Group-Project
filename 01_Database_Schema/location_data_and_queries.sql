-- Fit & Order - Milestone 3
-- Sample data for Countries, States, ZipCode, and Address
-- Plus two inventory reporting queries
-- Run the inserts once, after creating the tables and loading the sample User records.

USE fit_and_order;

-- Location data
INSERT INTO Countries (CountryCode, CountryName) VALUES
    ('US', 'United States'),
    ('CA', 'Canada'),
    ('MX', 'Mexico'),
    ('GB', 'United Kingdom');

INSERT INTO States (CountryCode, StateCode, StateName) VALUES
    ('US', 'NC', 'North Carolina'),
    ('US', 'SC', 'South Carolina'),
    ('US', 'VA', 'Virginia'),
    ('US', 'GA', 'Georgia');

INSERT INTO ZipCode (PostalCode, City, State, Country) VALUES
    ('28202', 'Charlotte', 'NC', 'US'),
    ('28025', 'Concord', 'NC', 'US'),
    ('28078', 'Huntersville', 'NC', 'US'),
    ('28105', 'Matthews', 'NC', 'US');

-- Shipping addresses for the four sample users
INSERT INTO Address
    (AddressID, AddressType, AddressLine1, AddressLine2,
     RecipientFirstName, RecipientLastName, PostalCode, UserID)
VALUES
    (401, 'Shipping', '12 Oak St', NULL, 'Ava', 'Reed', '28202', 1),
    (402, 'Shipping', '45 Pine Ave', NULL, 'Leo', 'Brooks', '28025', 2),
    (403, 'Shipping', '18 Cedar Rd', NULL, 'Mia', 'Patel', '28078', 3),
    (404, 'Shipping', '77 Elm Ln', NULL, 'Noah', 'Price', '28105', 4);

-- Query 1: Show product variants that have units available to sell.
SELECT
    b.BrandName,
    p.ProductName,
    pv.SKU,
    pv.Size,
    pv.Color,
    (i.QuantityOnHand - i.QuantityReserved) AS AvailableUnits
FROM Brand AS b
JOIN Product AS p ON p.BrandID = b.BrandID
JOIN ProductVariant AS pv ON pv.ProductID = p.ProductID
JOIN Inventory AS i ON i.SKU = pv.SKU
WHERE (i.QuantityOnHand - i.QuantityReserved) > 0
ORDER BY b.BrandName, p.ProductName, pv.Size;

-- Query 2: Summarize available inventory by product category.
SELECT
    c.CategoryName,
    COUNT(DISTINCT p.ProductID) AS ProductCount,
    COUNT(DISTINCT pv.SKU) AS VariantCount,
    SUM(i.QuantityOnHand - i.QuantityReserved) AS TotalAvailableUnits
FROM Category AS c
JOIN ProductCategory AS pc ON pc.CategoryID = c.CategoryID
JOIN Product AS p ON p.ProductID = pc.ProductID
JOIN ProductVariant AS pv ON pv.ProductID = p.ProductID
JOIN Inventory AS i ON i.SKU = pv.SKU
GROUP BY c.CategoryID, c.CategoryName
HAVING SUM(i.QuantityOnHand - i.QuantityReserved) > 0
ORDER BY TotalAvailableUnits DESC, c.CategoryName;
