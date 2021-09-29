use inclass;

-- --------------------------------------------------------------
# Dataset Used: wine.csv
-- --------------------------------------------------------------

SELECT * FROM wine;

# Q1. Rank the winery according to the quality of the wine (points).-- Should use dense rank

-- solution --
SELECT winery,dense_rank() over(order by points) as ranking from wine;
-- 462 rows --
-- #### ---

# Q2. Give a dense rank to the wine varities on the basis of the price.
-- solution --
select *, dense_rank() over (partition by variety order by price ) as price_ranking from wine;
-- 462 rows--
-- ######## --

# Q3. Use aggregate window functions to find the average of points for each row within its partition (country). 
-- -- Also arrange the result in the descending order by country.

-- solution --
select distinct country,avg(points) 
over(partition by country )as ang_results from wine 
order by country desc;
-- 21 rows --
-- #### --
-----------------------------------------------------------------
# Dataset Used: students.csv
-- --------------------------------------------------------------
select* from students;
# Q4. Rank the students on the basis of their marks subjectwise.

-- solution --
select *,rank() over(partition by subject order by marks) 
as ranking_besis_of_marks from students;
-- 11 rows --
-- #### ---

# Q5. Provide the new roll numbers to the students on the basis of their names alphabetically.

-- solution --
select *, row_number() over(order by name desc)  from students;
-- 11 rows --
-- ##### --

# Q6. Use the aggregate window functions to display the sum of marks in each row within its partition (Subject).

-- sollution --
select * ,sum(marks) over(partition by subject) as sum_of_marks from students;
-- 11 rows --
-- #### --


# Q7. Display the records from the students table where partition should be done 
-- on subjects and use sum as a window function on marks, 
-- -- arrange the rows in unbounded preceding manner.

-- solution --
select *,sum(marks) over(partition by subject
Range between unbounded preceding and current row) as sum_marks from students;
-- 11 rows --
-- ##### --

# Q8. Find the dense rank of the students on the basis of their marks subjectwise. Store the result in a new table 'Students_Ranked'
-- solution --
create table students_rank
as
select * ,dense_rank() over (partition by subject order by marks desc)from students;
select* from students_rank;
-- 11 rows --
-- ######### --
-----------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
-----------------------------------------------------------------
select * from website_stats;
select * from web;

# Q9. Show day, number of users and the number of users the next day (for all days when the website was used
-- solution --
select website_id, day, no_users as same_day_views, 
lead(no_users,1) over (partition by website_id) result_views_next 
from website_stats ;
-- 20 rows --
-- ##### --

# Q10. Display the difference in ad_clicks between the current day and the next day for the website 'Olympus'

-- solution --
select website_id,day, ad_clicks - lead(ad_clicks)
 over (partition by website_id order by day) 
from website_stats w
where w.website_id=
                     (select id from web 
                      where name='Olympus');
                      
-- 7 rows --
-- ###### --

# Q11. Write a query that displays the statistics for website_id = 3 such that for each row, show the day, the number of users and the smallest number of users ever.
-- solution --
select day, no_users, min(no_users) over() 
as less_no_user from website_stats where website_id = 3;
-- 6 rows --
-- #### --

# Q12. Write a query that displays name of the website and it's launch date. The query should also display the date of recently launched website in the third column.
-- solution --
select name,str_to_date(launch_date,'%d-%c-%Y') AS launch_date,
last_value(str_to_date(launch_date,'%d-%c-%Y')) over (order by str_to_date(launch_date, '%d-%c-%Y')
RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as recent_launch_date
from web;
-- 3 rows --
-- ##### --
-----------------------------------------------------------------
# Dataset Used: play_store.csv and sale.csv
select* from play_store;
select * from sale;
-----------------------------------------------------------------
# Q13. Write a query thats orders games in the play store into three buckets as per editor ratings received  

-- solution --
select *,ntile(3) 
over(order by editor_rating desc) as bucket_per_editor_ratings from play_store;
-- 12 rows --
-- ###### --

# Q14. Write a query that displays the name of the game, the price, the sale date and the 4th column should display 
# the sales consecutive number i.e. ranking of game as per the sale took place, so that the latest game sold gets number 1. Order the result by editor's rating of the game

-- solution --
select a.id,name,price,
str_to_date(b.date,'%d-%c-%Y') as date,editor_rating,
dense_rank() over (order by str_to_date(b.date,'%d-%c-%Y') desc) as gaming_rank
from play_store a join sale b
on a.id = b.game_id order by editor_rating;

-- 20 rows --
-- ######### --


# Q15. Write a query to display games which were both recently released and recently updated. For each game, show name, 
#date of release and last update date, as well as their rank
#Hint: use ROW_NUMBER(), sort by release date and then by update date, both in the descending order

-- solution --
select name,str_to_date(released,'%d-%c-%Y') as released,
str_to_date(updated,'%d-%c-%Y') as updated,
row_number() over (order by str_to_date(released,'%d-%c-%Y') desc,
str_to_date(updated,'%d-%c-%Y')desc) as ranking 
from play_store;

-- 12 rows --
-- ########### --

-----------------------------------------------------------------
# Dataset Used: movies.csv, customers.csv, ratings.csv, rent.csv
-----------------------------------------------------------------
select* from movies;
select * from customers_1;
select * from ratings;
select * from rent;


# Q16. Write a query that displays basic movie informations as well as the previous rating provided by customer for that same movie 
# make sure that the list is sorted by the id of the reviews.

-- solution --
select a.id,title,release_year,genre,rating,
lag(rating) over (Partition by a.id order by b.rating) as old_ratings
from movies a
join ratings b
on a.id = b.movie_id;
-- 18 rows --
-- ######### --

# Q17. For each movie, show the following information: title, genre, average user rating for that movie 
# and its rank in the respective genre based on that average rating in descending order (so that the best movies will be shown first).

-- solution --
select *,
dense_rank() over(partition by genre order by avg_rating desc) as genre_ranking
from (select title,genre,
	  avg(rating) over(partition by id) as avg_rating 
	  from movies a join ratings b using (ID)) alias;

-- 10 rows --
-- ########### --


# Q18. For each rental date, show the rental_date, the sum of payment amounts (column name payment_amounts) from rent 
#on that day, the sum of payment_amounts on the previous day and the difference between these two values.

-- solution --
select str_to_date(rental_date,'%d-%c-%Y') as rental_date,
current_day_payments,previous_day_payments,
(current_day_payments - previous_day_payments) AS diff_payment
from (select rental_date,current_day_payments,
lag(current_day_payments) over (order by str_to_date(rental_date,'%d-%c-%Y') desc) as previous_day_payments
from (select rental_date,
sum(payment_amount) as current_day_payments
from rent group by (str_to_date(rental_date,'%d-%c-%Y'))) alias) alias_1; 

-- 19 rows --
-- ######### --