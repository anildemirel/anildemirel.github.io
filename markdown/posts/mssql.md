---
title: My Notes on MS SQL Server
---
## View

**Definition.** A view in SQL Server is a virtual table that is derived from the result of a query. It consists of a stored SELECT statement that retrieves data from one or more tables or views. The retrieved data is stored in the view, and the view can be queried and manipulated like a regular table.

Views are used for several purposes:

* Simplifying complex queries
* Data security and access control
* Data abstraction and consistency
* Performance optimization
* Simplifying data manipulation

**Example.** 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.sql}
Select ProductName, UnitPrice, CategoryName 
From Products Inner Join Categories
on Products.CategoryID = Categories.CategoryID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
We will create a view for the above query:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.sql}
Create View GetProducts.vw
As
Select ProductName, UnitPrice, CategoryName
From Products Inner Join Categories
on Products.CategoryID = Categories.CategoryID
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So we are done.

This note will be further developed (Index concept, Stored Procedure, Trigger etc.).
