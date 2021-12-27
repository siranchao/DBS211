-- ***********************
-- Name: Siran Cao
-- ID: 159235209
-- Date: 09/24/2021
-- Purpose: Lab 02 DBS211
-- ***********************


-- Q1 Solution --
SELECT
    officecode,
    city,
    state,
    country,
    phone
FROM 
    dbs211_offices;

    
-- Q2 Solution --
SELECT
    employeenumber,
    firstname,
    lastname,
    extension
FROM 
    dbs211_employees
WHERE 
    officecode = 1
ORDER BY 
    employeenumber ASC;


-- Q3 Solution --
SELECT 
    customernumber,
    customername,
    contactfirstname,
    contactlastname,
    phone
FROM 
    dbs211_customers
WHERE 
    city = 'Paris'
ORDER BY 
    customernumber ASC;


-- Q4 Solution --
SELECT
    customernumber AS "Customer Number",
    customername AS "Customer Name",
    contactlastname || ', ' || contactfirstname AS "Contact Name",
    phone
FROM 
    dbs211_customers
WHERE 
    country = 'Canada'
ORDER BY 
    customername ASC;


-- Q5 Solution --
SELECT DISTINCT
    customernumber
FROM 
    dbs211_payments
ORDER BY 
    customernumber ASC;
    
    
-- Q6 Solution --
SELECT
    customernumber,
    checknumber,
    amount
FROM 
    dbs211_payments
WHERE 
    amount < 1500 OR amount > 120000
ORDER BY 
    amount DESC;


-- Q7 Solution --
SELECT
    ordernumber,
    orderdate,
    status,
    customernumber
FROM 
    dbs211_orders
WHERE 
    status = 'Cancelled'
ORDER BY 
    orderdate ASC;


-- Q8 Solution --
SELECT
    productcode,
    productname,
    buyprice,
    msrp,
    (msrp - buyprice) AS markup,
    ROUND((100 * (msrp - buyprice) / buyprice), 1) AS percmarkup
FROM 
    dbs211_products
WHERE 
    ROUND((100 * (msrp - buyprice) / buyprice), 1) > 140
ORDER BY 
    ROUND((100 * (msrp - buyprice) / buyprice), 1) ASC;


-- Q9 Solution --
SELECT
    productcode,
    productname,
    quantityinStock
FROM dbs211_products
WHERE 
    LOWER(productname) LIKE '%co%'
ORDER BY 
    quantityinstock;
    
    
-- Q10 Solution --
SELECT 
    customernumber,
    contactfirstname,
    contactlastname
FROM dbs211_customers
WHERE 
    LOWER(contactfirstname) LIKE 's%e%'
ORDER BY
    customernumber;