# Datasets used: employee.csv and membership.csv

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- Schema EmpMemb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS EmpMemb;
USE EmpMemb;


-- 1. Create a table Employee by refering the data file given. 

-- Follow the instructions given below: 
-- -- Q1. Values in the columns Emp_id and Members_Exclusive_Offers should not be null.
-- -- Q2. Column Age should contain values greater than or equal to 18.
-- -- Q3. When inserting values in Employee table, if the value of salary column is left null, then a value 20000 should be assigned at that position. 
-- -- Q4. Assign primary key to Emp_ID
-- -- Q5. All the email ids should not be same.

-- SOLUTION --
CREATE TABLE EMPLOYEE
(
EMP_ID VARCHAR(5)NOT NULL PRIMARY KEY,
MEMBERS_EXCLUSIVE_OFFERS VARCHAR(10) NOT NULL,
AGE INT CHECK(AGE>=18),
EMAIL_ID VARCHAR(50)NOT NULL UNIQUE,
SALARY INT DEFAULT 20000
);

-- 2. Create a table Membership by refering the data file given. 

-- Follow the instructions given below: 
-- -- Q6. Values in the columns Prime_Membership_Active_Status and Employee_Emp_ID should not be null.
-- -- Q7. Assign a foreign key constraint on Employee_Emp_ID.
-- -- Q8. If any row from employee table is deleted, then the corresponding row from the Membership table should also get deleted.

-- SOLUTION --
CREATE TABLE MEMBERSHIP
(
EMPLOYEE_EMP_ID VARCHAR(5) NOT NULL ,
MEMBERSHIP_ACTIVE_STATUS VARCHAR(10),
ENROLLMENT_DATE INT,
END_DATE INT,
FOREIGN KEY(EMPLOYEE_EMP_ID)REFERENCES EMPLOYEE(EMP_ID)
ON UPDATE RESTRICT ON DELETE CASCADE);

# ACCORDING TO THE QUESTION THEY WANT DELETE FUNCTION SO THAT I GIVE ON DELETE CASCADE AND RESTRICT UPDATATION.