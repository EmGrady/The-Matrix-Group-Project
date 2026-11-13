-- ===========================================
-- USER AND ROLE TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS User (
    UserID INT UNSIGNED AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (UserID)
);


CREATE TABLE IF NOT EXISTS RoleType (
    RoleID INT UNSIGNED AUTO_INCREMENT,
    RoleName VARCHAR(100) NOT NULL UNIQUE,
    RoleDescription TEXT,

    PRIMARY KEY (RoleID)
);


CREATE TABLE IF NOT EXISTS UserRole (
    UserID INT UNSIGNED NOT NULL,
    RoleID INT UNSIGNED NOT NULL,

    PRIMARY KEY (UserID, RoleID),

    FOREIGN KEY (UserID) REFERENCES User (UserID),
    FOREIGN KEY (RoleID) REFERENCES RoleType (RoleID)
);

-- ===========================================
-- PRODUCT CATALOG TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS Brand (
    BrandID INT UNSIGNED AUTO_INCREMENT,
    BrandName VARCHAR(100) NOT NULL UNIQUE,

    PRIMARY KEY (BrandID)
);


CREATE TABLE IF NOT EXISTS Category (
    CategoryID INT UNSIGNED AUTO_INCREMENT,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,

    PRIMARY KEY (CategoryID)
);


CREATE TABLE IF NOT EXISTS Product (
    ProductID INT UNSIGNED AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    BasePrice DECIMAL(10, 2) NOT NULL,
    ProductDescription TEXT,
    BrandID INT UNSIGNED NOT NULL,

    PRIMARY KEY (ProductID),

    FOREIGN KEY (BrandID) REFERENCES Brand (BrandID),

    CHECK (BasePrice >= 0)
);


CREATE TABLE IF NOT EXISTS ProductCategory (
    ProductID INT UNSIGNED NOT NULL,
    CategoryID INT UNSIGNED NOT NULL,

    PRIMARY KEY (ProductID, CategoryID),

    FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Category (CategoryID)
);


CREATE TABLE IF NOT EXISTS ProductVariant (
    SKU VARCHAR(50) NOT NULL,
    Style VARCHAR(100),
    PriceAdjustment DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    Color VARCHAR(100),
    Size VARCHAR(100),
    ProductID INT UNSIGNED NOT NULL,

    PRIMARY KEY (SKU),

    FOREIGN KEY (ProductID) REFERENCES Product (ProductID)
);


CREATE TABLE IF NOT EXISTS Inventory (
    SKU VARCHAR(50) NOT NULL UNIQUE,
    QuantityOnHand INT UNSIGNED NOT NULL DEFAULT 0,
    QuantityReserved INT UNSIGNED NOT NULL DEFAULT 0,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (SKU),

    FOREIGN KEY (SKU) REFERENCES ProductVariant (SKU),

    CHECK (QuantityOnHand >= 0),
    CHECK (QuantityReserved <= QuantityOnHand)
);

-- ===========================================
-- ADDRESS TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS Countries (
    CountryCode CHAR(2) PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE IF NOT EXISTS States (
    CountryCode CHAR(2) NOT NULL,
    StateCode VARCHAR(10) NOT NULL,
    StateName VARCHAR(100) NOT NULL,

    PRIMARY KEY (CountryCode, StateCode),

    FOREIGN KEY (CountryCode) REFERENCES Countries (CountryCode)
);


CREATE TABLE IF NOT EXISTS ZipCode (
    ZipCodeID INT UNSIGNED AUTO_INCREMENT,
    PostalCode VARCHAR(20) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(10) NOT NULL,
    Country CHAR(2) NOT NULL,

    PRIMARY KEY (ZipCodeID),

    FOREIGN KEY (Country, State) REFERENCES States (CountryCode, StateCode)
);


CREATE TABLE IF NOT EXISTS Address (
    AddressID INT UNSIGNED AUTO_INCREMENT,
    AddressType VARCHAR(50) NOT NULL,
    AddressLine1 VARCHAR(255) NOT NULL,
    AddressLine2 VARCHAR(255),
    RecipientFirstName VARCHAR(100),
    RecipientLastName VARCHAR(100),
    ZipCodeID INT UNSIGNED NOT NULL,
    UserID INT UNSIGNED,

    PRIMARY KEY (AddressID),

    FOREIGN KEY (ZipCodeID) REFERENCES ZipCode (ZipCodeID),
    FOREIGN KEY (UserID) REFERENCES User (UserID)
);

-- ===========================================
-- PAYMENT TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS PaymentMethod (
    PaymentMethodID INT UNSIGNED AUTO_INCREMENT,
    NameOnCard VARCHAR(255) NOT NULL,
    LastFour CHAR(4),
    PaymentToken VARCHAR(255) NOT NULL UNIQUE,
    ExpirationMonth TINYINT UNSIGNED,
    ExpirationYear SMALLINT UNSIGNED,
    UserID INT UNSIGNED NOT NULL,

    PRIMARY KEY (PaymentMethodID),

    FOREIGN KEY (UserID) REFERENCES User (UserID),

    CHECK (
        ExpirationMonth IS NULL
        OR ExpirationMonth BETWEEN 1 AND 12
    )
);


CREATE TABLE IF NOT EXISTS BillingAddress (
    PaymentMethodID INT UNSIGNED NOT NULL,
    AddressID INT UNSIGNED NOT NULL,

    PRIMARY KEY (PaymentMethodID, AddressID),

    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod (PaymentMethodID),
    FOREIGN KEY (AddressID) REFERENCES Address (AddressID)
);

-- ===========================================
-- DISCOUNT AND GIFT CARD TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS Discount (
    DiscountID INT UNSIGNED AUTO_INCREMENT,
    DiscountType ENUM('Percentage', 'FixedAmount') NOT NULL,
    DiscountValue DECIMAL(10, 2) NOT NULL,
    DiscountCode VARCHAR(50) UNIQUE,
    StartDate DATETIME,
    EndDate DATETIME,

    PRIMARY KEY (DiscountID),

    CHECK (DiscountValue > 0),
    CHECK (
        DiscountType <> 'Percentage'
        OR DiscountValue <= 100
    )
);


CREATE TABLE IF NOT EXISTS GiftCard (
    CardID INT UNSIGNED AUTO_INCREMENT,
    Code VARCHAR(32) NOT NULL UNIQUE,
    InitialAmount DECIMAL(10, 2) NOT NULL,
    CurrentBalance DECIMAL(10, 2) NOT NULL,
    ExpireDate DATE,

    PRIMARY KEY (CardID),

    CHECK (InitialAmount > 0),
    CHECK (CurrentBalance >= 0),
    CHECK (CurrentBalance <= InitialAmount)
);

-- ===========================================
-- ORDER TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT UNSIGNED AUTO_INCREMENT,
    OrderStatus VARCHAR(20) NOT NULL DEFAULT 'Pending',
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Subtotal DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    DiscountAmount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    TaxAmount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    GrandTotal DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    TrackingNumber VARCHAR(50) UNIQUE,
    UserID INT UNSIGNED NOT NULL,
    ShippingAddressID INT UNSIGNED,

    PRIMARY KEY (OrderID),

    FOREIGN KEY (UserID) REFERENCES User (UserID),
    FOREIGN KEY (ShippingAddressID) REFERENCES Address (AddressID),

    CHECK (Subtotal >= 0.00),
    CHECK (DiscountAmount >= 0.00),
    CHECK (TaxAmount >= 0.00),
    CHECK (GrandTotal >= 0.00)
);


CREATE TABLE IF NOT EXISTS OrderItem (
    SKU VARCHAR(50) NOT NULL,
    OrderID INT UNSIGNED NOT NULL,
    Quantity INT UNSIGNED NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL, -- ProductPrice +- VariantPrice

    PRIMARY KEY (SKU, OrderID),

    FOREIGN KEY (SKU) REFERENCES ProductVariant(SKU),
    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),

    CHECK (Quantity > 0),
    CHECK (UnitPrice >= 0)
);


CREATE TABLE IF NOT EXISTS OrderDiscount (
    OrderID INT UNSIGNED NOT NULL,
    DiscountID INT UNSIGNED NOT NULL,
    DiscountAmount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,

    PRIMARY KEY (OrderID, DiscountID),

    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
    FOREIGN KEY (DiscountID) REFERENCES Discount (DiscountID),

    CHECK (DiscountAmount >= 0)
);


CREATE TABLE IF NOT EXISTS OrderTransaction (
    TransactionID INT UNSIGNED AUTO_INCREMENT,
    TransactionAmount DECIMAL(10, 2) NOT NULL,
    TransactionStatus VARCHAR(20) NOT NULL,
    TransactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    OrderID INT UNSIGNED NOT NULL,
    GiftCardID INT UNSIGNED,
    PaymentMethodID INT UNSIGNED,

    PRIMARY KEY (TransactionID),

    FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
    FOREIGN KEY (GiftCardID) REFERENCES GiftCard (CardID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod (PaymentMethodID),

    CHECK (TransactionAmount > 0),
    CHECK (
        (GiftCardID IS NOT NULL AND PaymentMethodID IS NULL)
        OR
        (GiftCardID IS NULL AND PaymentMethodID IS NOT NULL)
    )
);

-- ===========================================
-- RETURN TABLE
-- ===========================================

CREATE TABLE IF NOT EXISTS ProductReturn (
    ReturnID INT UNSIGNED AUTO_INCREMENT,
    ReturnDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ReturnReason TEXT,
    ReturnQuantity INT UNSIGNED NOT NULL,
    RefundAmount DECIMAL(10, 2) NOT NULL,
    SKU VARCHAR(50) NOT NULL,
    OrderID INT UNSIGNED NOT NULL,

    PRIMARY KEY (ReturnID),

    FOREIGN KEY (SKU, OrderID) REFERENCES OrderItem (SKU, OrderID),

    CHECK (ReturnQuantity > 0),
    CHECK (RefundAmount >= 0)
);

-- ===========================================
-- SHOPPING CART TABLES
-- ===========================================

CREATE TABLE IF NOT EXISTS Cart (
    CartID INT UNSIGNED AUTO_INCREMENT,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    UserID INT UNSIGNED NOT NULL UNIQUE,

    PRIMARY KEY (CartID),

    FOREIGN KEY (UserID) REFERENCES User (UserID)
);


CREATE TABLE IF NOT EXISTS CartItem (
    SKU VARCHAR(50) NOT NULL,
    CartID INT UNSIGNED NOT NULL,
    Quantity INT UNSIGNED NOT NULL,

    PRIMARY KEY (SKU, CartID),

    FOREIGN KEY (SKU) REFERENCES ProductVariant (SKU),
    FOREIGN KEY (CartID) REFERENCES Cart (CartID),

    CHECK (Quantity > 0)
);
