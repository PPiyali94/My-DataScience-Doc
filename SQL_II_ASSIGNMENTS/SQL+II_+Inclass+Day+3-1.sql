# Datasets used: AirlineDetails.csv, passengers.csv and senior_citizen.csv
-- -----------------------------------------------------
-- Schema Airlines
CREATE DATABASE AIRLINES;
USE AIRLINES;
-- -----------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Create a table Airline_Details. Follow the instructions given below: 
-- -- Q1. Values in the columns Flight_ID should not be null.
-- -- Q2. Each name of the airline should be unique.
-- -- Q3. No country other than United Kingdom, USA, India, Canada and Singapore should be accepted
-- -- Q4. Assign primary key to Flight_ID

-- SOLUTION --
CREATE TABLE AIRLINE_DETAILS
(
FLIGHT_ID INT PRIMARY KEY NOT NULL,
AIRLINE_NAME VARCHAR(30) UNIQUE,
COUNTRY VARCHAR(20) CHECK (COUNTRY IN ("UNITED KINGDOM", "USA", "INDIA", "CANADA" , "SINGAPORE")),
PUNTUALTY INT ,
SERVICE_QUALITY INT,
AIRHELP_SCORE INT
);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 2. Create a table Passengers. Follow the instructions given below: 
-- -- Q1. Values in the columns Traveller_ID and PNR should not be null.
-- -- Q2. Only passengers having age greater than 18 are allowed.
-- -- Q3. Assign primary key to Traveller_ID

-- Questions for table Passengers:  
-- -- Q3. PNR status should be unique and should not be null.
-- -- Q4. Flight Id should not be null.

-- SOLUTION --
CREATE TABLE PASSENGERS
(
TRAVELLER_ID VARCHAR(5) PRIMARY KEY NOT NULL,
FLIGHT_ID INT NOT NULL,
PNR VARCHAR(10) UNIQUE NOT NULL,
NEME VARCHAR(30),
AGE INT CHECK(AGE>18),
TICKET_PRICE INT 

);



-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Create a table Senior_Citizen_Details. Follow the instructions given below: 
-- -- Q1. Column Traveller_ID should not contain any null value.
-- -- Q2. Assign primary key to Traveller_ID
-- -- Q3. Assign foreign key constraint on Traveller_ID such that if any row from passenger table is updated, then the Senior_Citizen_Details table should also get updated.
-- -- --  Also deletion of any row from passenger table should not be allowed.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- SOLUTION --
CREATE TABLE SENIOR_CITIZEN_DETAILS
(
TRAVELLER_ID VARCHAR(5) PRIMARY KEY NOT NULL,
SENIOR_CITIZEN VARCHAR(50),
DISCOUNTED_PRICE INT,
FOREIGN KEY (TRAVELLER_ID)REFERENCES PASSENGERS(TRAVELLER_ID)
ON UPDATE CASCADE ON DELETE RESTRICT
);
-- -----------------------------------------------------
-- Table Senior_Citizen_Details
-- -- Q6. Create a new column Age in Passengers table that takes values greater than 18. 

-- EXPLAINATION --
 # IN PASSENGERS TABLE WE HAVE CREATED THE VALUE OF AGE IN THE PASSENGER TABLE ALREADY SO WE DO NOT NEED TO
 #CREATE ONCE AGAIN
 
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Create a table books. Follow the instructions given below: 
-- -- Columns: books_no, description, author_name, cost
-- -- Qa. The cost should not be less than or equal to 0.
-- -- Qb. The cost column should not be null.
-- -- Qc. Assign a primary key to the column books_no.
-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- SOLUTION --
CREATE TABLE BOOKS
(
BOOK_NO INT PRIMARY KEY,
DESCRIPTION VARCHAR(30),
AUTHOR_NAME VARCHAR(20),
COST FLOAT NOT NULL CHECK(COST>0));

# Q8. Update the table 'books' such that the values in the columns 'description' and author' must be unique.
ALTER TABLE BOOKS 
MODIFY DESCRIPTION VARCHAR(50) UNIQUE,
MODIFY AUTHOR_NAME VARCHAR(50) UNIQUE;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Create a table bike_sales. Follow the instructions given below: 
-- -- Columns: id, product, quantity, release_year, release_month
-- -- Q1. Assign a primary key to ID. Also the id should auto increment.
-- -- Q2. None of the columns should be left null.
-- -- Q3. The release_month should be between 1 and 12 (including the boundries i.e. 1 and 12).
-- -- Q4. The release_year should be between 2000 and 2010.
-- -- Q5. The quantity should be greater than 0.

-- SOLUTION --
CREATE TABLE BIKE_SALES
(
ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
PRODUCT VARCHAR(20) NOT NULL,
QUANTITY INT NOT NULL CHECK (QUANTITY>0),
RELEASE_YEAR INT NOT NULL CHECK (RELEASE_YEAR BETWEEN 2000 AND 2010),
RELEASE_MONTH INT NOT NULL CHECK(RELEASE_MONTH BETWEEN 1 AND 12)
);


-- --------------------------------------------------------------------------
-- Use the following comands to insert the values in the table bike_sales
/*('1','Pulsar','1','2001','7');
('2','yamaha','3','2002','3');
('3','Splender','2','2004','5');
('4','KTM','2','2003','1');
('5','Hero','1','2005','9');
('6','Royal Enfield','2','2001','3');
('7','Bullet','1','2005','7');
('8','Revolt RV400','2','2010','7');
('9','Jawa 42','1','2011','5');*/

#INSERTING VALUES TO THE BIKE_SALES TABLE
INSERT INTO BIKE_SALES VALUES('1','Pulsar','1','2001','7');
INSERT INTO BIKE_SALES (product, quantity, release_year, release_month) VALUES('yamaha','3','2002','3');
INSERT INTO BIKE_SALES  (product, quantity, release_year, release_month) VALUES('Splender','2','2004','5');
INSERT INTO BIKE_SALES (product, quantity, release_year, release_month) VALUES('KTM','2','2003','1');
INSERT INTO BIKE_SALES  (product, quantity, release_year, release_month)VALUES('Hero','1','2005','9');
INSERT INTO BIKE_SALES (product, quantity, release_year, release_month) VALUES('Royal Enfield','2','2001','3');
INSERT INTO BIKE_SALES (product, quantity, release_year, release_month)VALUES('Bullet','1','2005','7');
INSERT INTO BIKE_SALES (product, quantity, release_year, release_month)VALUES('Revolt RV400','2','2010','7');
INSERT INTO BIKE_SALES (product, quantity, release_year, release_month) VALUES('Jawa 42','1','2011','5');

## ID NO 8 IS NOT EXECUTED BECAUSE CHEK CONSTAIN VIOLATED YEAR SHOUD BETWEEN 2000-2010 BUT IT IS 2011.
-- --------------------------------------------------------------------------
SELECT* FROM BIKE_SALES;



