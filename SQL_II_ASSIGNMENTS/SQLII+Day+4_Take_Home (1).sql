
###################### Use 'account_details' table from in-class exercise for below questions
select * from account_details;
# Q.1 Kim wants to pay Jeff 550 dollars after they both had lunch together. At the same time, GL NEWSLETTER is going to deduct 
# 150 dollars from Jeff's bank account as annual subscription. Write a query such that GL NEWSLETTER should be able to deduct the amount once Kim transfers 
# the amount to Jeff's account
# Solution:
 
#At a same time 2 set of operation cannot be performed.
#connection1
set autocommit=False;
start transaction;
update account_details
set balance=balance+550 where first_name='Jeff';

update account_details
set balance=balance-550 where first_name='kim';
commit;
#in connection1 user 1 have to complete the set of operation first and then commiting the data only then user2 can 
# complete the connection2 operation.

#connection2
start transaction;
update account_details
set balance=balance-150
where first_name='Jeff';
commit;
#in connection1 first kim has to complete the transaction then commit after releasing the access by commiting then only
# GL NEWSLETTER in connection2 can execute their set of operation.

######################################################################################################################################
# Create table:
CREATE TABLE BANK_ACCOUNT ( Customer_id INT, 		   			  
							Account_Number VARCHAR(19),
							Account_type VARCHAR(25),
							Balance_amount INT ,
                            Account_status VARCHAR(10), 
                            Relationship_type varchar(1), 
                            Primary Key (Customer_id));
# Insert records:
INSERT INTO BANK_ACCOUNT  VALUES (123001, "4000-1956-3456",  "SAVINGS"            , 200000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123001, "5000-1700-3456",  "RECURRING DEPOSITS" ,9400000 ,"ACTIVE","S");  
INSERT INTO BANK_ACCOUNT  VALUES (123002, "4000-1956-2001",  "SAVINGS"            , 400000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123002, "5000-1700-5001",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123003, "4000-1956-2900",  "SAVINGS"            ,750000,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "5000-1700-6091",  "RECURRING DEPOSITS" ,7500000 ,"ACTIVE","S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123004, "4000-1956-3401",  "SAVINGS"            , 655000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123005, "4000-1956-5102",  "SAVINGS"            , 300000 ,"ACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123006, "4000-1956-5698",  "SAVINGS"            , 455000 ,"ACTIVE" ,"P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "5000-1700-9800",  "SAVINGS"            , 355000 ,"ACTIVE" ,"P"); INSERT INTO BANK_ACCOUNT  VALUES (123007, "4000-1956-9977",  "RECURRING DEPOSITS" , 7025000,"ACTIVE" ,"S"); 
INSERT INTO BANK_ACCOUNT  VALUES (123007, "9000-1700-7777-4321",  "CREDITCARD"    ,0      ,"INACTIVE","P"); 
INSERT INTO BANK_ACCOUNT  VALUES (123008, "5000-1700-7755",  "SAVINGS"            ,NULL   ,"INACTIVE","P"); 

select * from bank_account; 

# Q.2 Write a lock query such that whenever an User X perform trasaction customer_id 123001 in table bank_account, it should only allow other users
# to read the table and not perfrom any transaction till the lock is released by User X
# Solution:
set autocommit=False;
start transaction;
select * from bank_account where Customer_id=123001 lock in share mode;
commit;
-- userx perform the operation in share mode so that no other operation can be perform with out releasing the 
-- share mode by commiting the operation.In share mode there is only read accessibility possible but after commiting
-- one share will be released any other operation can be performed. 

############################################################################################################################################
# Q.3 A customer approaches a bank and wishes to open a new account. Unknonwingly two bankers try to perform same entries in the bank_account table
#Table: Bank_account
#customer_id : 123009
#Account_number : '5000-1700-9800'
#Account_type: 'SAVINGS'
#balance: 20000
#status: 'ACTIVE'
#relationship: 'P'
#How the avoid duplicate entry into the table when two users try to insert the same record at a time.
#Solution:	
#connection1
set transaction isolation level serializable;
start transaction;
insert into Bank_account values (123009,'5000-1700-9800','SAVINGS', 20000,'ACTIVE','P');
commit;
-- connection1 is inserting some values in a serializable mode so that other user can have only the read access
-- but cannot have update or insert something before user1 commit ..
#connection2
start transaction;
insert into Bank_account values (123009,'5000-1700-9800','SAVINGS', 20000,'ACTIVE','P');
commit;
-- once the connection1 give the access by commiting the operation then only connection 2 
-- can perform the operation
#############################################################################################################################################
-- ----------------------------------------------------
# Datset Used: admission_predict.csv
select * from admission_predict;
-- ----------------------------------------------------
# Q.4 A university is looking for candidates with GRE score between 330 and 340. Also they should be proficient in english 
#i.e. their Toefl score should not be less than 115. Create a view for this university.
#Solution:	

create view score as
select * from admission_predict
where 'GRE Score' between 330 and 340 and 'TOEFL Score' > 115;
select * from score;
-- There are no data I found.

# Q.5 Create a view of the candidates with the CGPA greater than the average CGPA.
#Solution:	

create view candidate_view as
select * from admission_predict where CGPA>
(select avg(CGPA) from admission_predict);

select * from candidate_view;
-- 202 rows--
 #############################################################################################################################################
 
-- -------------------------------------------------------------------------------------
# Datsets Used: world_cup_2015.csv and world_cup_2016.csv 
-- -------------------------------------------------------------------------------------
select * from world_cup_2015;
select * from world_cup_2016;

# Q.6 Create a view "team_1516" of the players who played in world cup 2015 as well as in world cup 2016.
#Solution:	
create view team_1516 as
select * from world_cup_2015 
where player_name in (select player_name from world_cup_2016);

select* from team_1516;
-- 7 rows--
# Q.7 Create a view "All_From_15" that contains all the players who played in world cup 2015 but not in the year 2016Along with those players who played in both the world cup matches.

#Solution:	
create view all_from_15 as 
select w15.Player_Id, w15.Player_Name from world_cup_2015 w15 
left join world_cup_2016 w16 using(player_id) ;

select * from all_from_15;
-- 12 rows --

# Q.8 Create a view "All_From_16" that contains all the players who played in world cup 2016 but not in the year 2015 Along with those players who played in both the world cup matches.
#Solution:

create view all_from_16 as 
select w16.Player_Id, w16.Player_Name from world_cup_2015 w15 
right join world_cup_2016 w16 using(player_id);

 select * from all_from_16;
 -- 11 rows --
# Q.9 Drop multiple views "all_from_16", "all_from_15","all_from_15","players_rank"
#Solution:
drop view all_from_16,all_from_15
# there is no "players_rank" view created.

