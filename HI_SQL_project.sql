-- Q1 --
SELECT AccountNumber
FROM [Purchasing].[Vendor]
WHERE BusinessEntityID = 1512
-----------------------------------------------------------------
-- Q2
SELECT COUNT(*) AS 'total_number of Design Engineer'
FROM [HumanResources].[Employee]
WHERE JobTitle = 'Design Engineer'
-- to see the list 
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
-- It's pretty simple and slelf explanitory : 
-- the commend will select three columns BusinessEntityID, Rate, PayFrequency from the 
-- [EmployeePayHistory] table only when PayFrequency is less than 22 AND BusinessEntityID is 
-- equal to 16.

-----------------------------------------------------------------
-- Q6 
SELECT COUNT(BusinessEntityID)
FROM [HumanResources].[Employee]
WHERE JobTitle = 'Design Engineers'

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

-- Q8 ( Adding Mr.Carl Rickman)
SET IDENTITY_INSERT [AdventureWorks2019].[Person].[ContactType] ON;
INSERT INTO [Person].[ContactType] (ContactTypeID,Name, ModifiedDate )
VALUES(21,'Data Analyst', GETDATE()); -- CAST() if we only need the Date 

-- Now lets check whether is is updated or not:
SELECT *
FROM [Person].[ContactType] ; 
-----------------------------------------------------------------
-- Q9 
INSERT INTO [Person].[ContactType] (ContactTypeID,Name, ModifiedDate) 
VALUES ( 22, 'Data Analyst', '2008-04-30 00:00:00.000');

-- Error : Cannot insert duplicate key row in object 'Person.ContactType' with unique index 'AK_ContactType_Name'. 
-- The duplicate key value is (Data Analyst).

-- Answer : It's obvious becuase the NAME column is UNIQUE and since we already HAVE the Data Analyst 
--          in that so it is not possible to have another one.

-----------------------------------------------------------------
-- Q10 
-- first lets look at the data that we should change:
SELECT * 
FROM Sales.SpecialOffer
WHERE [Description] = 'Mountain Tire Sale' ; 

-- now lets look whether it changed:
UPDATE Sales.SpecialOffer
SET [DiscountPct] = [DiscountPct] + 0.25 
WHERE [Description] = 'Mountain Tire Sale';
-- yay!

-----------------------------------------------------------------
-- Q11

SELECT AVG(DiscountPct) 
FROM Sales.SpecialOffer;
-----------------------------------------------------------------
-- Q12
SELECT TOP(1)   [Name] ,[TaxType] , [TaxRate]
FROM [Sales].[SalesTaxRate]
ORDER BY TaxRate DESC ; 

-----------------------------------------------------------------

-- Q13

DELETE
FROM [Sales].SalesTaxRate 
WHERE SalesTaxRateID = 1 

-- check it :
SELECT * FROM [Sales].SalesTaxRate ;
-- YEAH! There is no Tax with SalesTaxRateID = 1
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
ORDER BY ModifiedDate ; 
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
-- Q18 -- 
IF EXISTS ( SELECT * FROM Person.Person WHERE FirstName = 'Terri')
BEGIN
DELETE FROM Person.Person WHERE  FirstName = 'Terri' ; 
END

-- The answer is : It's not possible to delete this name because it is a foreign key for another table ( EmailAddress)
-----------------------------------------------------------------
-- Q19 
SELECT COUNT(TaxRate) AS TOTAL_NUMBER,
	   AVG(TaxRate) AS AVERAGE,
       SUM(TaxRate) AS SUM   
FROM [Sales].SalesTaxRate 
-----------------------------------------------------------------

-- Q20 
SELECT p.FirstName , p.LastName , pe.EmailAddress
FROM Person.Person p
JOIN Person.EmailAddress pe 
ON pe.BusinessEntityID = p.BusinessEntityID  -- Q: is it possible to use USING(BusinessEntityID)?
WHERE p.MiddleName is NULL ;
