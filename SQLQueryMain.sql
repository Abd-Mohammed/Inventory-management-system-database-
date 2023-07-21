
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200)
);


CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(100)
);


CREATE TABLE Item (
    ItemID INT PRIMARY KEY IDENTITY(1,1),
    ItemName VARCHAR(100),
    CategoryID INT,
    QuantityInStock INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);


CREATE TABLE Invoice_Item (
    Invoice_Item_ID INT PRIMARY KEY IDENTITY(1,1),
    InvoiceID INT,
    ItemID INT,
    Quantity INT,
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
    FOREIGN KEY (ItemID) REFERENCES Item(ItemID)
);


/*<-------------------------------------------- Adding Data----------------------------------------------------------------------------->*/

SET IDENTITY_INSERT Category ON;

INSERT INTO Category (CategoryID, CategoryName)
VALUES
    (1, 'Electronics'),
    (2, 'Clothing'),
    (3, 'Home and Kitchen');


SET IDENTITY_INSERT Category OFF;


SET IDENTITY_INSERT Item ON;

INSERT INTO Item (ItemID, ItemName, CategoryID, QuantityInStock, UnitPrice)
VALUES
    (101, 'Laptop', 1, 10, 1000.00),
    (102, 'T-Shirt', 2, 50, 20.00),
    (103, 'Microwave', 3, 15, 150.00);

SET IDENTITY_INSERT Item OFF;


SET IDENTITY_INSERT Customer ON;
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
	
    (1, 'Abd', 'Odeh', 'abd@ilinix.com', '123-456-7890', '123 Amman St'),
    (2, 'Ibrahim', 'Ghanem', 'Ibrahim@leadingpoint.com', '987-654-3210', '456 Dubai St');

SET IDENTITY_INSERT Customer OFF;


SET IDENTITY_INSERT Invoice ON;

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount)
VALUES
    (1001, 1, '2023-07-20', 1000.00),
    (1002, 2, '2023-07-20', 150.00);



SET IDENTITY_INSERT Invoice OFF;



SET IDENTITY_INSERT Invoice_Item ON;

select * from Invoice_Item; 
INSERT INTO Invoice_Item (InvoiceID, ItemID, Quantity)
VALUES
    (1001, 101, 2),
    (1001, 103, 1);

INSERT INTO Invoice_Item (InvoiceID, ItemID, Quantity)
VALUES
    (1002, 101, 2),
    (1002, 102, 4);

INSERT INTO Invoice_Item (InvoiceID, ItemID, Quantity)
VALUES
    (1001, 103, 2),
    (1002, 101, 4);



INSERT INTO Invoice_Item (InvoiceID, ItemID, Quantity)
VALUES
    (1002, 102, 3);


SET IDENTITY_INSERT Invoice_Item OFF;


/*<-------------------------------------------- Showing Data----------------------------------------------------------------------------->*/


-- TODO: Get all items. 

SELECT * FROM Item;

-- TODO: Calcluate for each user the total amount.

SELECT
    Invoice.InvoiceID,
    Customer.FirstName,
    Customer.LastName,
    Invoice.InvoiceDate,
    SUM(Invoice_Item.Quantity * Item.UnitPrice) AS TotalAmount
FROM Invoice
JOIN Customer ON Invoice.CustomerID = Customer.CustomerID
JOIN Invoice_Item ON Invoice.InvoiceID = Invoice_Item.InvoiceID
JOIN Item ON Invoice_Item.ItemID = Item.ItemID
GROUP BY Invoice.InvoiceID, Customer.FirstName, Customer.LastName, Invoice.InvoiceDate;


-- TODO: Show The Invoice with all infomation for each item. 

SELECT
    Invoice.InvoiceID,
    Customer.FirstName,
    Customer.LastName,
    Invoice.InvoiceDate,
    (Item.UnitPrice * Invoice_Item.Quantity) AS TotalAmount,
    Item.ItemName,
    Invoice_Item.Quantity
FROM Invoice
JOIN Customer ON Invoice.CustomerID = Customer.CustomerID
JOIN Invoice_Item ON Invoice.InvoiceID = Invoice_Item.InvoiceID
JOIN Item ON Invoice_Item.ItemID = Item.ItemID;






