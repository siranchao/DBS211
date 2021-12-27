-- ***********************
-- Name: Siran Cao
-- ID: 159235209
-- Date: 10/15/2021
-- Purpose: Lab 05 DBS211
-- ***********************
SET AUTOCOMMIT ON;


-- Q1 SOLUTION --
-- Answer in ANSI-89 Join
SELECT
    e.employeenumber,
    e.firstname,
    e.lastname,
    o.city,
    o.phone,
    o.postalcode
FROM 
    dbs211_employees e, dbs211_offices o
WHERE
    e.officecode = o.officecode AND o.city = 'Paris';
    
-- Answer in ANSI-92 Join
SELECT
    e.employeenumber,
    e.firstname,
    e.lastname,
    o.city,
    o.phone,
    o.postalcode
FROM 
    dbs211_employees e INNER JOIN dbs211_offices o ON e.officecode = o.officecode
WHERE 
    o.city = 'Paris';

      
-- Q2 SOLUTION --    
SELECT
    p.customernumber,
    c.customername,
    TO_CHAR(p.paymentdate, 'MM/DD/YYYY'), 
    p.amount
FROM 
    dbs211_payments p INNER JOIN dbs211_customers c ON p.customernumber = c.customernumber
WHERE 
    c.country = 'Canada'
ORDER BY 
    p.customernumber ASC;
    
    
-- Q3 SOLUTION --  
SELECT
    c.customernumber,
    c.customername,
    c.country,
    p.checknumber    
FROM 
    dbs211_customers c LEFT JOIN dbs211_payments p ON c.customernumber = p.customernumber
WHERE
    c.country = 'USA' AND p.checknumber IS NULL
ORDER BY 
    c.customername ASC;
    
    
-- Q4 SOLUTION --  
CREATE VIEW vwCustomerOrder AS
SELECT 
    o.customernumber,
    o.ordernumber,
    o.orderdate,
    p.productname,
    od.quantityordered,
    od.priceeach
FROM 
    dbs211_orders o 
	LEFT JOIN dbs211_orderdetails od ON o.ordernumber = od.ordernumber
    LEFT JOIN dbs211_products p ON od.productcode = p.productcode;
    
SELECT *
FROM vwCustomerOrder;
    

-- Q5 SOLUTION --     
CREATE OR REPLACE VIEW vwCustomerOrder AS
SELECT 
    o.customernumber,
    o.ordernumber,
    o.orderdate,
    p.productname,
    od.quantityordered,
    od.priceeach,
    od.orderlinenumber
FROM 
    dbs211_orders o 
    LEFT JOIN dbs211_orderdetails od ON o.ordernumber = od.ordernumber
    LEFT JOIN dbs211_products p ON od.productcode = p.productcode;

SELECT *
FROM vwCustomerOrder
WHERE customernumber = 124
ORDER BY customernumber ASC, orderlinenumber ASC;

    
-- Q6 SOLUTION --     
SELECT
    c.customernumber,
    c.contactfirstname AS firstname,
    c.contactlastname AS lastname,
    c.phone,
    c.creditlimit
FROM 
    dbs211_orders o RIGHT JOIN dbs211_customers c ON o.customernumber = c.customernumber
WHERE
    o.customernumber IS NULL;
    
    
-- Q7 SOLUTION --       
CREATE VIEW vwEmployeeManager AS 
SELECT
    e.employeenumber,
    (e.firstname || '  ' || e.lastname) AS employee,
    e.extension,
    e.email,
    e.officecode,
    e.reportsto,
    (m.firstname || '  ' || m.lastname) AS manager,
    e.jobtitle
FROM 
    dbs211_employees e LEFT JOIN dbs211_employees m ON e.employeenumber = m.employeenumber
ORDER BY 
    manager ASC;
    

-- Q8 SOLUTION --    
CREATE OR REPLACE VIEW vwEmployeeManager AS 
SELECT
    e.employeenumber,
    (e.firstname || '  ' || e.lastname) AS employee,
    e.extension,
    e.email,
    e.officecode,
    e.reportsto,
    (m.firstname || '  ' || m.lastname) AS manager,
    e.jobtitle
FROM 
    dbs211_employees e LEFT JOIN dbs211_employees m ON e.employeenumber = m.employeenumber
WHERE
    e.reportsto IS NOT NULL
ORDER BY 
    manager ASC;
    
    
-- Q9 SOLUTION --     
DROP VIEW vwCustomerOrder;
DROP VIEW vwEmployeeManager;
    
    

    
    
    
    