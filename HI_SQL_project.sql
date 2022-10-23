-- Q1

SELECT AccountNumber
FROM [Purchasing].[Vendor]
WHERE BusinessEntityID = 1512
-----------------------------------------------------------------
-- Q2

SELECT COUNT(*) AS 'total_number of Design Engineer'
FROM [HumanResources].[Employee]
WHERE JobTitle = 'Design Engineer'

-- list:
SELECT *
FROM [HumanResources].[Employee]
WHERE JobTitle = 'Design Engineer'

-----------------------------------------------------------------
-- Q3

SELECT *
FROM [HumanResources].[Employee]
WHERE BirthDate IN ('1969-01-29','1974-11-12','1984-11-30','1987-05-03'); 

-----------------------------------------------------------------
-- Q4

SELECT ContactTypeID
FROM Person.ContactType
WHERE Name = 'Accounting Manager';
-----------------------------------------------------------------

-- Q5--
-- It's pretty simple and self explanatory : 
-- the commend will select three columns BusinessEntityID, Rate, PayFrequency from the 
-- [EmployeePayHistory] table only when PayFrequency is less than 22 AND BusinessEntityID is equal to 16.

-----------------------------------------------------------------
-- Q6

SELECT COUNT(*) AS 'total_number of Design Engineer'
FROM [HumanResources].[Employee]
WHERE JobTitle = 'Design Engineer'

-- list:
SELECT *
FROM [HumanResources].[Employee]
WHERE JobTitle = 'Design Engineer'

-----------------------------------------------------------------
-- Q7

SELECT COUNT(*)
FROM [HumanResources].[Employee]
WHERE JobTitle LIKE '%Design%'

-- list:
SELECT *
FROM [HumanResources].[Employee]
WHERE JobTitle LIKE '%Design%'

-----------------------------------------------------------------
-- Q8 

INSERT INTO [Person].[ContactType] (ContactTypeID,Name, ModifiedDate )
VALUES(21,'Data Analyst', GETDATE());
-- CAST() if we only need the Date 

-----------------------------------------------------------------
-- Q9 

INSERT INTO [Person].[ContactType] (ContactTypeID,Name, ModifiedDate) 
VALUES ( 22, 'Data Analyst', '2008-04-30 00:00:00.000');

-- Error : Cannot insert duplicate key row in object 'Person.ContactType' with unique index 'AK_ContactType_Name'. 
-- The duplicate key value is (Data Analyst).

-- Reason : It's obvious becuase the NAME column is UNIQUE and since we already HAVE the Data Analyst 
--          in that so it is not possible to have another one.

-- Solution : 
   SET IDENTITY_INSERT [Person].[ContactType] ON    	   -- To be able to insert data on that table 
   DROP INDEX AK_ContacType_Name ON [Person].[ContactType] -- To be able have similar value in different rows
   
   INSERT INTO [Person].[ContactType] (ContactTypeID,Name, ModifiedDate) 
   VALUES ( 22, 'Data Analyst', '2008-04-30 00:00:00.000');

   SET IDENTITY_INSERT Person.ContactType OFF;
-----------------------------------------------------------------
-- Q10 

UPDATE Sales.SpecialOffer
SET [DiscountPct] = [DiscountPct] + 0.25 
WHERE [Description] = 'Mountain Tire Sale';

-----------------------------------------------------------------
-- Q11

SELECT AVG(DiscountPct) 
FROM Sales.SpecialOffer;
-----------------------------------------------------------------
-- Q12

SELECT TOP(1)  [Name] ,[TaxType] , [TaxRate]
FROM Sales.SalesTaxRate
ORDER BY TaxRate DESC ; 

-- Other Way : 
SELECT  [Name] ,[TaxType] , [TaxRate]
FROM Sales.SalesTaxRate
WHERE TaxRate = (SELECT MAX(TaxRate) FROM Sales.SalesTaxRate);

-----------------------------------------------------------------
-- Q13

DELETE
FROM [Sales].SalesTaxRate 
WHERE SalesTaxRateID = 1 

-----------------------------------------------------------------
-- Q14

SELECT AccountNumber
FROM [Purchasing].[Vendor]
WHERE Name = 'Cycling Master';
-----------------------------------------------------------------
-- Q15

SELECT Name, ReasonType
FROM Sales.SalesReason;
-----------------------------------------------------------------
-- Q16 

SELECT TOP(10) *
FROM Purchasing.Vendor
WHERE CreditRating = 2
ORDER BY ModifiedDate ;  -- by saying " 10 first"  I assume that we should show them by the time they have been registered 
-----------------------------------------------------------------
-- Q17

IF EXISTS ( SELECT * FROM Person.Person WHERE BusinessEntityID = 3 )
BEGIN 
UPDATE Person.Person
SET FirstName = 'Kinza' , LastName = 'Shehzad'
WHERE BusinessEntityID = 3  ;
END

-- QCHECK:
SELECT TOP(10) *
FROM Person.Person;

-----------------------------------------------------------------
-- Q18 

IF EXISTS ( SELECT * FROM Person.Person WHERE FirstName = 'Terri')
BEGIN
DELETE FROM Person.Person WHERE  FirstName = 'Terri' ; 
END

-- The answer is : It's not possible to delete this name because it is a foreign key for another table ( EmailAddress)
-----------------------------------------------------------------
-- Q19 

SELECT 
	COUNT(TaxRate) AS TOTAL_NUMBER,
	AVG(TaxRate) AS AVERAGE,
	SUM(TaxRate) AS SUM   
FROM [Sales].SalesTaxRate 

-----------------------------------------------------------------
-- Q20 

SELECT pp.FirstName , pp.MiddleName, pp.LastName , pe.EmailAddress
FROM Person.Person pp
JOIN Person.EmailAddress pe 
ON pe.BusinessEntityID = pp.BusinessEntityID  -- Q: is it possible to use USING(BusinessEntityID)?
WHERE pp.MiddleName is NULL ;
