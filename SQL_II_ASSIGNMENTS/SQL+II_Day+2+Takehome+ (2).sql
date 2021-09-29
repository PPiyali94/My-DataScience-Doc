CREATE SCHEMA IF NOT EXISTS Video_Games;
USE Video_Games;
SELECT * FROM Video_Games_Sales;

# 1. Display the names of the Games, platform and total sales in North America for respective platforms.
-- solution --
select name,platform,
sum(NA_sales) over (partition by platform)as total_sale 
from video_games_sales ;

-- 4586 rows --
-- ######## --

# 2. Display the name of the game, platform , Genre and total sales in North America for corresponding Genre as Genre_Sales,total sales for the given platform as Platformm_Sales and also display the global sales as total sales .
# Also arrange the results in descending order according to the Total Sales.

-- solution --
select name,platform,genre,global_sales as sum_of_sales,
sum(na_sales) over (partition by genre) as genre_sales_of_NA,
sum(global_sales) over(partition by platform) as global_sales
from video_games_sales
order by  sum_of_sales desc;
-- 4586 rows --
-- ########## --

# 3. Use nonaggregate window functions to produce the row number for each row 
# within its partition (Platform) ordered by release year.

-- solution --
select *,row_number() 
over(partition by platform order by Year_of_Release desc) as released_year
from Video_Games_Sales;
-- 4586 rows --
-- ######### --

# 4. Use aggregate window functions to produce the average global sales of each row within its partition (Year of release). Also arrange the result in the descending order by year of release.
 
 -- solution --
  select *,avg(Global_Sales) 
  over(partition by Year_of_Release ) as avg_sales
  from video_games_sales 
  order by Year_of_Release desc;
  -- 4586 rows --
  -- ######### --

# 5. Display the name of the top 5 Games with highest Critic Score For Each Publisher. 

-- solution --
select name,publisher,critic_score,Score_rank 
from (select name,publisher,platform,critic_score,
	  dense_rank() over (partition by publisher order by critic_score DESC) AS score_rank
	  from video_games_sales) as alias where score_rank <=5;
-- 821 rows --
-- ######### --
------------------------------------------------------------------------------------
# Dataset Used: website_stats.csv and web.csv
select * from website_stats;
select * from web;
------------------------------------------------------------------------------------
# 6. Write a query that displays the opening date two rows forward i.e. the 1st row should display the 3rd website launch date

-- solution --
select *,lead(str_to_date(launch_date,'%d-%c-%Y'),2) 
over (order by str_to_date(launch_date,'%d-%c-%Y')) AS 3rd_website_launch_date
from web;
-- 3 rows --
-- ######## --

# 7. Write a query that displays the statistics for website_id = 1 i.e. for each row, show the day, the income and the income on the first day.

-- solution --
select website_id,str_to_date(day,'%d-%c-%Y') as first_day,income,
first_value(income) over (order by str_to_date(DAY,'%d-%c-%Y')) as Income_of_first_day
from website_stats
where website_id = 1;
-- 7 rows --
-- ######## --
-----------------------------------------------------------------
# Dataset Used: play_store.csv 
select * from play_store;
-----------------------------------------------------------------
# 8. For each game, show its name, genre and date of release. In the next three columns, show RANK(), DENSE_RANK() and ROW_NUMBER() sorted by the date of release.

-- solution --
select name,genre,released,rank() over (order by str_to_date(released,'%d-%c-%Y') ) as new_rank,
dense_rank() over (order by str_to_date(released,'%d-%c-%Y') ) as dense_ranking,
row_number() over (order by str_to_date(released,'%d-%c-%Y') ) as new_row_number
from play_store;
-- 12 rows --
-- ######## --