--=========================================================
-- DBMS ASSIGNMENT
-- Oracle 23ai / Oracle FreeSQL Compatible
-- PART 1
--=========================================================

SET SERVEROUTPUT ON;

PROMPT ======================================
PROMPT CLEANING OLD TABLES
PROMPT ======================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COPYOFDEPT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE WORKS_ON CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DEPENDENT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PROJECT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DEPT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DEPARTMENT CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

PROMPT ======================================
PROMPT Q1 CREATE EMPLOYEE TABLE
PROMPT ======================================

CREATE TABLE Employee
(
    FName           VARCHAR2(20),
    LName           VARCHAR2(20),
    SSN             NUMBER(9),
    Address         VARCHAR2(100),
    Salary          NUMBER(10,2),
    BDate           DATE,
    Sex             CHAR(1),
    SuperSSN        NUMBER(9),
    DepartmentNo    NUMBER,

    CONSTRAINT PK_EMP PRIMARY KEY(SSN)
);

PROMPT ======================================
PROMPT Q2 CREATE DEPARTMENT TABLE
PROMPT ======================================

CREATE TABLE Department
(
    DNo             NUMBER,
    DName           VARCHAR2(30),
    ManagerSSN      NUMBER(9),
    MgrStartDate    DATE,

    CONSTRAINT PK_DEPT PRIMARY KEY(DNo)
);

PROMPT ======================================
PROMPT CREATE PROJECT TABLE
PROMPT ======================================

CREATE TABLE Project
(
    PNo             NUMBER,
    PName           VARCHAR2(40),
    Location        VARCHAR2(30),
    DNo             NUMBER,

    CONSTRAINT PK_PROJECT PRIMARY KEY(PNo)
);

PROMPT ======================================
PROMPT CREATE WORKS_ON TABLE
PROMPT ======================================

CREATE TABLE Works_On
(
    ESSN            NUMBER(9),
    PNo             NUMBER,
    Hours           NUMBER(5,1),

    CONSTRAINT PK_WORKS PRIMARY KEY(ESSN,PNo)
);

PROMPT ======================================
PROMPT CREATE DEPENDENT TABLE
PROMPT ======================================

CREATE TABLE Dependent
(
    ESSN                NUMBER(9),
    Dependent_Name      VARCHAR2(30),
    Sex                 CHAR(1),
    BDate               DATE,
    Relationship        VARCHAR2(20),

    CONSTRAINT PK_DEP PRIMARY KEY(ESSN,Dependent_Name)
);

PROMPT ======================================
PROMPT Q3 INSERT DEPARTMENT DATA
PROMPT ======================================

INSERT INTO Department VALUES
(1,'Finance',333445555,DATE '2018-01-01');

INSERT INTO Department VALUES
(2,'Marketing',987654321,DATE '2019-02-15');

INSERT INTO Department VALUES
(3,'Research',123456789,DATE '2020-03-10');

INSERT INTO Department VALUES
(4,'Sales',444555666,DATE '2017-06-01');

INSERT INTO Department VALUES
(5,'HR',333445555,DATE '2021-01-01');

PROMPT ======================================
PROMPT INSERT EMPLOYEE DATA
PROMPT ======================================

INSERT INTO Employee VALUES
('John','Smith',123456789,
'Bangalore',
50000,
DATE '1975-01-09',
'M',
333445555,
3);

INSERT INTO Employee VALUES
('Joyce','English',453453453,
'Salt Lake, Kolkata',
35000,
DATE '1959-03-29',
'F',
333445555,
1);

INSERT INTO Employee VALUES
('James','Borg',333445555,
'Delhi',
70000,
DATE '1965-11-10',
'M',
NULL,
1);

INSERT INTO Employee VALUES
('Jennifer','Wallace',987654321,
'Mumbai',
43000,
DATE '1978-06-20',
'F',
333445555,
2);

INSERT INTO Employee VALUES
('Ahmad','Jabbar',444555666,
'Hyderabad',
28000,
DATE '1980-04-14',
'M',
333445555,
4);

PROMPT ======================================
PROMPT INSERT PROJECT DATA
PROMPT ======================================

INSERT INTO Project VALUES
(101,'Payroll','Delhi',1);

INSERT INTO Project VALUES
(102,'CRM','Mumbai',2);

INSERT INTO Project VALUES
(103,'Research AI','Bangalore',3);

INSERT INTO Project VALUES
(104,'Sales Portal','Hyderabad',4);

PROMPT ======================================
PROMPT INSERT WORKS_ON DATA
PROMPT ======================================

INSERT INTO Works_On VALUES
(123456789,103,20);

INSERT INTO Works_On VALUES
(453453453,101,15);

INSERT INTO Works_On VALUES
(333445555,101,10);

INSERT INTO Works_On VALUES
(987654321,102,25);

INSERT INTO Works_On VALUES
(444555666,104,18);

PROMPT ======================================
PROMPT INSERT DEPENDENT DATA
PROMPT ======================================

INSERT INTO Dependent VALUES
(123456789,'Sam','M',DATE '2005-05-05','Son');

INSERT INTO Dependent VALUES
(333445555,'Mary','F',DATE '2000-08-20','Daughter');

COMMIT;

--=========================================================
-- PART 2
-- Q4 - Q19
--=========================================================

PROMPT ======================================
PROMPT Q4 DISPLAY ALL EMPLOYEES
PROMPT ======================================

SELECT * FROM Employee;

PROMPT ======================================
PROMPT Q5 EMPLOYEE NAME, SSN, SUPERVISOR SSN
PROMPT ======================================

SELECT
    FName || ' ' || LName AS Employee_Name,
    SSN,
    SuperSSN
FROM Employee;

PROMPT ======================================
PROMPT Q6 EMPLOYEES BORN ON 29-MAR-1959
PROMPT ======================================

SELECT *
FROM Employee
WHERE BDate = DATE '1959-03-29';

PROMPT ======================================
PROMPT Q7 DISTINCT SALARY
PROMPT ======================================

SELECT DISTINCT Salary
FROM Employee;

PROMPT ======================================
PROMPT Q8 MANAGER OF FINANCE DEPARTMENT
PROMPT ======================================

SELECT
    ManagerSSN,
    MgrStartDate
FROM Department
WHERE DName='Finance';

PROMPT ======================================
PROMPT Q9 UPDATE JOYCE DEPARTMENT TO 5
PROMPT ======================================

UPDATE Employee
SET DepartmentNo=5
WHERE FName='Joyce';

COMMIT;

PROMPT ======================================
PROMPT Q10 ADD PHONE COLUMN
PROMPT ======================================

ALTER TABLE Department
ADD DepartmentPhoneNum NUMBER(15);

UPDATE Department
SET DepartmentPhoneNum=9876543210;

COMMIT;

PROMPT ======================================
PROMPT Q11 MODIFY PHONE COLUMN SIZE
PROMPT ======================================

ALTER TABLE Department
MODIFY DepartmentPhoneNum NUMBER(20);

PROMPT ======================================
PROMPT Q12 RENAME PHONE COLUMN
PROMPT ======================================

ALTER TABLE Department
RENAME COLUMN DepartmentPhoneNum TO PhNo;

PROMPT ======================================
PROMPT Q13 RENAME DEPARTMENT TABLE
PROMPT ======================================

RENAME Department TO DEPT;

PROMPT ======================================
PROMPT Q14 DROP PHONE COLUMN
PROMPT ======================================

ALTER TABLE DEPT
DROP COLUMN PhNo;

PROMPT ======================================
PROMPT Q15 CREATE COPYOFDEPT
PROMPT ======================================

CREATE TABLE COPYOFDEPT
AS
SELECT *
FROM DEPT;

PROMPT ======================================
PROMPT Q16 DELETE ALL ROWS
PROMPT ======================================

DELETE FROM COPYOFDEPT;

COMMIT;

PROMPT ======================================
PROMPT Q17 DROP COPYOFDEPT
PROMPT ======================================

DROP TABLE COPYOFDEPT;

PROMPT ======================================
PROMPT Q18 ADD FOREIGN KEYS
PROMPT ======================================

ALTER TABLE Employee
ADD CONSTRAINT FK_EMP_DEPT
FOREIGN KEY (DepartmentNo)
REFERENCES DEPT(DNo);

ALTER TABLE Employee
ADD CONSTRAINT FK_EMP_SUPER
FOREIGN KEY (SuperSSN)
REFERENCES Employee(SSN);

ALTER TABLE Project
ADD CONSTRAINT FK_PROJECT_DEPT
FOREIGN KEY (DNo)
REFERENCES DEPT(DNo);

ALTER TABLE Works_On
ADD CONSTRAINT FK_WORKS_EMP
FOREIGN KEY (ESSN)
REFERENCES Employee(SSN);

ALTER TABLE Works_On
ADD CONSTRAINT FK_WORKS_PROJECT
FOREIGN KEY (PNo)
REFERENCES Project(PNo);

ALTER TABLE Dependent
ADD CONSTRAINT FK_DEP_EMP
FOREIGN KEY (ESSN)
REFERENCES Employee(SSN);

PROMPT ======================================
PROMPT Q19 DROP AND RECREATE SUPERVISOR FK
PROMPT ======================================

ALTER TABLE Employee
DROP CONSTRAINT FK_EMP_SUPER;

ALTER TABLE Employee
ADD CONSTRAINT FK_EMP_SUPER
FOREIGN KEY (SuperSSN)
REFERENCES Employee(SSN);

COMMIT;

--=========================================================
-- PART 3
-- Q20 - Q32
--=========================================================

PROMPT ======================================
PROMPT Q20 EMPLOYEES WITH SALARY > 25000
PROMPT ======================================

SELECT
    FName,
    LName,
    Salary
FROM Employee
WHERE Salary > 25000;

PROMPT ======================================
PROMPT Q21 SALARY BETWEEN 30000 AND 70000
PROMPT ======================================

SELECT
    FName,
    LName,
    Salary
FROM Employee
WHERE Salary BETWEEN 30000 AND 70000;

PROMPT ======================================
PROMPT Q22 EMPLOYEES HAVING NO SUPERVISOR
PROMPT ======================================

SELECT
    FName,
    LName
FROM Employee
WHERE SuperSSN IS NULL;

PROMPT ======================================
PROMPT Q23 DISPLAY BDATE FORMAT DDthMonthYYYY
PROMPT ======================================

SELECT
    FName,
    TO_CHAR(BDate,'DDthMonthYYYY') AS Birth_Date
FROM Employee;

PROMPT ======================================
PROMPT Q24 EMPLOYEES BORN ON OR BEFORE 1978
PROMPT ======================================

SELECT
    FName,
    LName
FROM Employee
WHERE EXTRACT(YEAR FROM BDate) <= 1978;

PROMPT ======================================
PROMPT Q25 EMPLOYEES HAVING 'SALT LAKE' IN ADDRESS
PROMPT ======================================

SELECT
    FName,
    LName,
    Address
FROM Employee
WHERE LOWER(Address) LIKE '%salt lake%';

PROMPT ======================================
PROMPT Q26 DEPARTMENT NAME STARTING WITH M
PROMPT ======================================

SELECT
    DName
FROM DEPT
WHERE DName LIKE 'M%';

PROMPT ======================================
PROMPT Q27 DEPARTMENT NAME ENDING WITH E
PROMPT ======================================

SELECT
    DName
FROM DEPT
WHERE UPPER(DName) LIKE '%E';

PROMPT ======================================
PROMPT Q28 EMPLOYEES HAVING SUPERVISOR
PROMPT ======================================

SELECT
    FName,
    LName,
    SuperSSN
FROM Employee
WHERE SuperSSN IN (554433221,333445555);

PROMPT ======================================
PROMPT Q29 DISPLAY UPPER AND LOWER CASE
PROMPT ======================================

SELECT
    DName,
    UPPER(DName) AS UPPER_CASE,
    LOWER(DName) AS LOWER_CASE
FROM DEPT;

PROMPT ======================================
PROMPT Q30 FIRST FOUR AND LAST FOUR CHARACTERS
PROMPT ======================================

SELECT
    DName,
    SUBSTR(DName,1,4) AS FIRST4,
    SUBSTR(DName,-4) AS LAST4
FROM DEPT;

PROMPT ======================================
PROMPT Q31 SUBSTRING OF ADDRESS
PROMPT ======================================

SELECT
    Address,
    SUBSTR(Address,5,7) AS ADDRESS_PART
FROM Employee;

PROMPT ======================================
PROMPT Q32 ADD THREE MONTHS TO MANAGER START DATE
PROMPT ======================================

SELECT
    MgrStartDate,
    ADD_MONTHS(MgrStartDate,3) AS NEW_DATE
FROM DEPT;

COMMIT;

PROMPT ======================================
PROMPT ******** DBMS ASSIGNMENT COMPLETED ********
PROMPT ======================================
