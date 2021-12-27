-- ***********************
-- Name: Siran Cao
-- ID: 159235209
-- Date: 10/08/2021
-- Purpose: Lab 04 DBS211
-- ***********************

SET AUTOCOMMIT ON;

-- Q1 SOLUTION --
CREATE TABLE employee2 AS
(SELECT * FROM dbs211_employees);

ALTER TABLE employee2
ADD PRIMARY KEY (employeenumber);

ALTER TABLE employee2
ADD CONSTRAINT office_fk FOREIGN KEY (officecode) REFERENCES dbs211_offices(officecode);

ALTER TABLE employee2
ADD CONSTRAINT report_fk FOREIGN KEY (reportsto) REFERENCES employee2(employeenumber);


-- Q2 SOLUTION --
ALTER TABLE employee2
ADD username VARCHAR(20) NULL;


-- Q3 SOLUTION --
DELETE FROM employee2;


-- Q4 SOLUTION --
INSERT INTO employee2 (employeenumber, lastname, firstname, extension, email, officecode, reportsto, jobtitle)
    SELECT * FROM dbs211_employees;


-- Q5 SOLUTION --
INSERT INTO employee2
    VALUES (1703, 'Cao', 'Siran', 'x2222', 'scao34@myseneca.ca', '4', 1088, 'Cashier', null);


-- Q6 SOLUTION --
SELECT * FROM employee2
    WHERE employeenumber = 1703;


-- Q7 SOLUTION --
UPDATE employee2 SET jobtitle = 'Head Cashier'
    WHERE employeenumber = 1703;


-- Q8 SOLUTION --
INSERT INTO employee2
    VALUES (1704, 'Fake', 'Man', 'x2233', 'fakeman@myseneca.ca', '4', 1703, 'Cashier', null);


-- Q9 SOLUTION --
DELETE FROM employee2
    WHERE employeenumber = 1703;
--Unable to delete this row. Because employeenumber 1703 is the reference of the FOREIGN KEY(reportsto) in another row
--When there is a child row/table has foreign key points to the parent row/table, we should delete the child first
--Unless we can set ON DELETE CASCADE or ON DELETE SET NULL


-- Q10 SOLUTION --
DELETE FROM employee2
    WHERE employeenumber = 1704;
DELETE FROM employee2
    WHERE employeenumber = 1703;
--Yes, we can now delete two of them. The order of deletion is important, the child row/table should be deleted before the parent
--If we delete the 1704 first, there is no more foreign key points to 1703, thus 1703 can be deleted without error 


-- Q11 SOLUTION --
INSERT ALL
    INTO employee2 VALUES (1703, 'Cao', 'Siran', 'x2222', 'scao34@myseneca.ca', '4', 1088, 'Cashier', null)
    INTO employee2 VALUES (1704, 'Fake', 'Man', 'x2233', 'fakeman@myseneca.ca', '4', 1088, 'Cashier', null)
SELECT * FROM dual;


-- Q12 SOLUTION --
DELETE FROM employee2
    WHERE employeenumber = 1703 OR employeenumber = 1704;


-- Q13 SOLUTION --
UPDATE employee2 SET
    username = LOWER(CONCAT( SUBSTR(firstname,1,1), lastname));


-- Q14 SOLUTION --
ALTER TABLE employee2
DROP CONSTRAINT report_fk;

ALTER TABLE employee2
ADD CONSTRAINT report_fk FOREIGN KEY (reportsto) REFERENCES employee2(employeenumber) ON DELETE CASCADE;


DELETE FROM employee2
    WHERE officecode = '4';

-- Q15 SOLUTION --
DROP TABLE employee2;






