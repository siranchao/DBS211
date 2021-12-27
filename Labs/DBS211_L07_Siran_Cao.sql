-- ***********************
-- Name: Siran Cao
-- ID: 159235209
-- Date: 11/12/2021
-- Purpose: Lab 07 DBS211
-- ***********************


-- Q1 Solution --
--4 ways a transaction can be started:
--(1). User establish a new connection to the server and has a blank sheet ready to go
--(2). Uses the BEGIN statement in Oracle SQL
--(3). Executes a COMMIT statement
--(4). Executes ANY DDL statement

-- Q2 Solution --
CREATE TABLE newEmployees (
employeeNumber  NUMBER(38,0)    NOT NULL,
lastName    VARCHAR2(50 BYTE)   NOT NULL,
firstName   VARCHAR2(50 BYTE)   NOT NULL,
extension   VARCHAR2(10 BYTE)   NOT NULL,
email   VARCHAR2(100 BYTE)   NOT NULL,
officecode  VARCHAR2(10 BYTE)   NOT NULL,
reportsTo   NUMBER(38,0),
jobTitle    VARCHAR2(50 BYTE)   NOT NULL,
PRIMARY KEY (employeeNumber)
);

-- Q3 Solution --
SET AUTOCOMMIT OFF;
SET TRANSACTION READ WRITE;

-- Q4 Solution --
INSERT ALL
    INTO newemployees VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
    INTO newemployees VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
    INTO newemployees VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
    INTO newemployees VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL, 'Sales Rep')
    INTO newemployees VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL, 'Sales Rep')
SELECT * FROM dual;

-- Q5 Solution --
SELECT * FROM newemployees;

-- Q6 Solution --
ROLLBACK;
SELECT * FROM newemployees;

-- Q7 Solution --
INSERT ALL
    INTO newemployees VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
    INTO newemployees VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
    INTO newemployees VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
    INTO newemployees VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL, 'Sales Rep')
    INTO newemployees VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL, 'Sales Rep')
SELECT * FROM dual;
COMMIT;

ROLLBACK;
SELECT * FROM newemployees;

-- Q8&9 Solution --
UPDATE newEmployees SET jobTitle = 'Unknown';
COMMIT;

-- Q10 Solution --
ROLLBACK;
SELECT * FROM newemployees WHERE jobTitle = 'Unknown';
-- All 5 rows can be displayed
-- The rollback command here will not work. Becasue the task 9 used COMMIT command to make the current transcation committed and starts an new empty transcation;
-- The task 6 only execute the SQL statement but not permanently take effective, so the results can be restore using ROLLBACK command;

-- Q11 Solution --
COMMIT;
DELETE FROM newemployees;

-- Q12 Solution --
CREATE OR REPLACE VIEW vwNewEmps AS
SELECT * FROM newemployees
ORDER BY lastName, firstName;

-- Q13 Solution --
ROLLBACK;
SELECT * FROM newemployees;
-- There is 0 employees in the table and the rollback to undo deletion is not effective
-- Becaise any DDL statement will trigger automatic commit. The CREATE VIEW statement execute after the deletion will commit the current transcation;
-- So the deletion will permanently take effective and the rollback doesn't work;

-- Q14 Solution --
COMMIT;
INSERT ALL
    INTO newemployees VALUES (100, 'Patel', 'Ralph', '22333', 'rpatel@mail.com', '1', NULL, 'Sales Rep')
    INTO newemployees VALUES (101, 'Denis', 'Betty', '33444', 'bdenis@mail.com', '4', NULL, 'Sales Rep')
    INTO newemployees VALUES (102, 'Biri', 'Ben', '44555', 'bbirir@mail.com', '2', NULL, 'Sales Rep')
    INTO newemployees VALUES (103, 'Newman', 'Chad', '66777', 'cnewman@mail.com', '3', NULL, 'Sales Rep')
    INTO newemployees VALUES (104, 'Ropeburn', 'Audrey', '77888', 'aropebur@mail.com', '1', NULL, 'Sales Rep')
SELECT * FROM dual;

-- Q15 Solution --
SAVEPOINT insertion;

-- Q16 Solution --
UPDATE newEmployees SET jobTitle = 'Unknown';
SELECT * FROM newemployees;

-- Q17 Solution --
ROLLBACK TO insertion;
SELECT * FROM newemployees;
-- The jobTitle in the table are rollbacked to "Sales Rep", which means the UPDATE statement is rollbacked

-- Q18 Solution --
ROLLBACK;
SELECT * FROM newemployees;
-- There is 0 data displayed and table is empty;
-- The last ROllBACK TO statement recover the transcation to previous statuas in task 16
-- ROLLBACK command in task 18 will recover the transcation further back to task 13. Which all data are deleted


-- Q19 Solution --
REVOKE ALL ON newEmployees FROM PUBLIC;

-- Q20 Solution --
GRANT SELECT ON newEmployees TO my_classmate; 

-- Q21 Solution --
GRANT INSERT, UPDATE, DELETE ON newEmployees TO my_classmate; 

-- Q22 Solution --
REVOKE ALL ON newEmployees FROM my_classmate;


-- Q23 Solution --
DROP VIEW vwNewEmps;
DROP TABLE newEmployees;
COMMIT;




