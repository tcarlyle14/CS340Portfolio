# CS 340 Project Step 3 Draft DML
# Project Title: Oregon Real Estate Sales Management System
# Team Name: Team 10
# Member Names: Trevor Carlyle, Farad Wahab

-- SELECT queries to display data from each table
-- Select all sellers
SELECT * FROM Sellers;
-- Select all agents
SELECT * FROM Agents;
-- Select all properties
SELECT * FROM Properties;
-- Select all sale transactions
SELECT * FROM SaleTransactions;
-- Select all agent-property relationships
SELECT * FROM AgentPropertyJunction;

-- INSERT queries to add new data
-- Insert a new seller
INSERT INTO Sellers (Name, Phone, Email)
VALUES (:nameInput, :phoneInput, :emailInput);
-- Insert a new agent
INSERT INTO Agents (Name, Phone, Territory, HireDate)
VALUES (:nameInput, :phoneInput, :territoryInput, :hireDateInput);
-- Insert a new property
INSERT INTO Properties (Address, City, County, SaleStatus, ListingPrice, SaleDate, SellerID)
VALUES (:addressInput, :cityInput, :countyInput, :saleStatusInput, :listingPriceInput, :saleDateInput, :sellerIdInput);
-- Insert a new sale transaction
INSERT INTO SaleTransactions (CommissionPercent, CommissionAmount, TransactionDate, PropertyID, SellerID, AgentID, SalePrice)
VALUES (:commissionPercentInput, :commissionAmountInput, :transactionDateInput, :propertyIdInput, :sellerIdInput, :agentIdInput, :salePriceInput);
-- Insert a new agent-property relationship
INSERT INTO AgentPropertyJunction (PropertyID, AgentID)
VALUES (:propertyIdInput, :agentIdInput);

-- UPDATE queries to modify existing data
-- Update a seller's information
UPDATE Sellers
SET Name = :nameInput, Phone = :phoneInput, Email = :emailInput
WHERE SellerID = :sellerIdInput;
-- Update an agent's information
UPDATE Agents
SET Name = :nameInput, Phone = :phoneInput, Territory = :territoryInput, HireDate = :hireDateInput
WHERE AgentID = :agentIdInput;
-- Update a property's information
UPDATE Properties
SET Address = :addressInput, City = :cityInput, County = :countyInput, SaleStatus = :saleStatusInput, 
    ListingPrice = :listingPriceInput, SaleDate = :saleDateInput, SellerID = :sellerIdInput
WHERE PropertyID = :propertyIdInput;
-- Update a sale transaction's information
UPDATE SaleTransactions
SET CommissionPercent = :commissionPercentInput, CommissionAmount = :commissionAmountInput, 
    TransactionDate = :transactionDateInput, PropertyID = :propertyIdInput, 
    SellerID = :sellerIdInput, AgentID = :agentIdInput, SalePrice = :salePriceInput
WHERE TransactionID = :transactionIdInput;
-- Update an agent-property relationship using JunctionID
UPDATE AgentPropertyJunction
SET PropertyID = :propertyIdInput, AgentID = :agentIdInput
WHERE JunctionID = :junctionIdInput;
-- Update a property's seller to NULL
UPDATE Properties
SET SellerID = NULL
WHERE PropertyID = :propertyIdInput;

-- DELETE queries to remove data
-- Delete a seller
DELETE FROM Sellers
WHERE SellerID = :sellerIdInput;
-- Delete an agent
DELETE FROM Agents
WHERE AgentID = :agentIdInput;
-- Delete a property
DELETE FROM Properties
WHERE PropertyID = :propertyIdInput;
-- Delete a sale transaction
DELETE FROM SaleTransactions
WHERE TransactionID = :transactionIdInput;
-- Delete an agent-property relationship using JunctionID
DELETE FROM AgentPropertyJunction
WHERE JunctionID = :junctionIdInput;