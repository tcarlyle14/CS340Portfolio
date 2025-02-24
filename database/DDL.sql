# CS 340 Project Step 3 Draft DDL
# Project Title: Oregon Real Estate Sales Management System
# Team Name: Team 10
# Member Names: Trevor Carlyle, Farad Wahab

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT=0;
# Drop existing tables if they exist
DROP TABLE IF EXISTS AgentPropertyJunction;
DROP TABLE IF EXISTS SaleTransactions;
DROP TABLE IF EXISTS Properties;
DROP TABLE IF EXISTS Agents;
DROP TABLE IF EXISTS Sellers;
# Create Sellers table
CREATE TABLE Sellers (
    SellerID INT AUTO_INCREMENT PRIMARY KEY, 
    Name VARCHAR(100) NOT NULL,    -- Name cannot be NULL
    Phone VARCHAR(15) NOT NULL,    -- Phone cannot be NULL
    Email VARCHAR(255)             -- Email is optional (NULLable)
);
# Create Agents table
CREATE TABLE Agents (
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Territory VARCHAR(255) NOT NULL,
    HireDate DATE NOT NULL
);
# Create Properties table
CREATE TABLE Properties (
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,
    Address VARCHAR(100) NOT NULL,        -- Address must be provided
    City VARCHAR(100) NOT NULL,
    County VARCHAR(100) NOT NULL,
    SaleStatus VARCHAR(100) NOT NULL,
    ListingPrice DECIMAL(10, 2) NOT NULL,
    SaleDate DATE,
    SellerID INT,
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID) ON DELETE CASCADE
);
# Create SaleTransactions table
CREATE TABLE SaleTransactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    CommissionPercent DECIMAL(10, 2) NOT NULL,
    CommissionAmount DECIMAL(10, 2) NOT NULL,
    TransactionDate DATE NOT NULL,
    PropertyID INT NOT NULL,
    SellerID INT NOT NULL,
    AgentID INT NOT NULL,
    SalePrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID) ON DELETE CASCADE,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID) ON DELETE CASCADE
);
# Create AgentPropertyJunction table
CREATE TABLE AgentPropertyJunction (  -- made adjustment based on comments
    JunctionID INT AUTO_INCREMENT PRIMARY KEY,   -- Unique ID for each entry
    PropertyID INT NOT NULL,
    AgentID INT NOT NULL,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID) ON DELETE CASCADE,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID) ON DELETE CASCADE
);
SET FOREIGN_KEY_CHECKS=1;

# Insert data into Sellers table
INSERT INTO Sellers (Name, Phone, Email) VALUES
('John Apple', '808-222-1111', 'johnapple@gmail.com'),
('Jerry Beach', '808-222-1112', 'jerrybeach@gmail.com'),
('Joy Smith', '808-222-1113', 'joysmith@gmail.com');
# Insert data into Agents table
INSERT INTO Agents (Name, Phone, Territory, HireDate) VALUES
('Agent A', '808-333-1111', 'North', '2022-01-15'),
('Agent B', '808-333-1112', 'South', '2021-06-20'),
('Agent C', '808-333-1113', 'East', '2023-03-10');
# Insert data into Properties table
INSERT INTO Properties (Address, City, County, SaleStatus, ListingPrice, SaleDate, SellerID) VALUES
('111 Kent Ave', 'Corvallis', 'Benton', 'Sold', 250000.00, '2023-10-01', 1),
('222 Wythe St', 'Corvallis', 'Benton', 'Sold', 300000.00, '2023-09-15', 2),
('333 Berry St', 'Corvallis', 'Benton', 'For Sale', 275000.00, NULL, 3);
# Insert data into SaleTransactions table
INSERT INTO SaleTransactions (CommissionPercent, CommissionAmount, TransactionDate, PropertyID, SellerID, AgentID, SalePrice) VALUES
(3.00, 7500.00, '2023-10-01', 1, 1, 1, 250000.00),
(2.00, 5000.00, '2023-11-01', 1, 1, 2, 250000.00),
(5.00, 15000.00, '2023-09-15', 2, 2, 3, 300000.00);
# Insert data into AgentPropertyJunction table
INSERT INTO AgentPropertyJunction (PropertyID, AgentID) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 3);
COMMIT;