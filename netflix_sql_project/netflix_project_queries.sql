use netflix_project;

select * from titles limit 5;
select * from genres limit 5;
select  * from title_genres limit 5;
select *from customers limit 5;
select*from watch_history limit 5;
select*from ratings limit 5;

-----------Top 3 most popular genres overall based on total watch count------------
----Description: helps in identifying top performing genres
----Tables used: watch_history, title_genres, genres

select G.genre_id, genre_name, watch_count from genres as G join (
select genre_id, count(*) as watch_count from watch_history as W left join title_genres as T on W.title_id = T.title_id
group by genre_id
order by genre_id) as total_watch_count on G.genre_id = total_watch_count.genre_id
order by watch_count desc
limit 3;

----------Top 5 customers who have watched most content------
----Description: helps in identifying most active customers
----Tables used: watch_history
select customer_id, count(*) as total_views from watch_history 
group by customer_id
order by total_views desc
limit 5;

-------Titles having highest rating-------------
---Description: finding out top rated titles
---Tables used: ratings
select title_id, avg(rating) as avg_rating from ratings 
group by title_id
order by avg_rating desc
limit 10;

---------Age group wise performance for various genres-------
---Description: Helps personalize recommendations and understand viewer taste by age
---Tables used: customers, title_genres, genres, watch_history

with genre_wise_views as (with genre_views as(select customer_id, age, genre_id from title_genres as T join (select C.customer_id, age, title_id from customers as C right join watch_history as W on C.customer_id = W.customer_id)
as age_table on T.title_id = age_table.title_id)
select case
when age < 18 then 'under 18' 
when age between 19 and 40 then '19-40'
when age between 41 and 60 then '41-60'
else '60+'
end as age_category, genre_id,
count(*) as total_views
from genre_views
group by age_category, genre_id) 
select age_category, genre_name, total_views from genre_wise_views as GW join genres as G on GW.genre_id = G.genre_id
order by age_category;

------Average time gap between consecutive watches for each customers--------
---Description: understanding customer engagement frequency or binge behaviour
---Tables used: watch_history

with days_between_watch as (with previous_watch as (select customer_id, watch_date, lag(watch_date) over (partition by customer_id order by watch_date) as previous_watch_date
from watch_history) 
select customer_id, watch_date, previous_watch_date, datediff(watch_date, previous_watch_date) as watch_gaps
from previous_watch where previous_watch_date is not null)
select customer_id, avg(watch_gaps) as avg_gap_days from days_between_watch
group by customer_id
order by avg_gap_days;

-----Top 3 titles watched per country-------
---Description: understanding country-wise content popularity
--- Tables used: customers, titles, watch_history

select * from (
select c.country, title, t.title_id, count(w.watch_id) as watch_count,
row_number() over (partition by c.country order by count(w.watch_id) desc) as rn
from watch_history as w
join customers as c on w.customer_id = c.customer_id
join titles as t on w.title_id = t.title_id
group by c.country, t.title_id
) sub
where rn <= 3;


--------Device used to watch across countries-------------
---Description: understing the device used to watch accorss countries
---Tables used: watch_history, customers
select country, sum(case when device_used = 'Smart TV' then 1 else 0 end) as Smart_tv,
sum(case when device_used = 'Laptop' then 1 else 0 end) as Laptop,
sum(case when device_used = 'Desktop' then 1 else 0 end) as Desktop,
sum(case when device_used = 'Mobile' then 1 else 0 end) as Mobile,
sum(case when device_used = 'Tablet' then 1 else 0 end) as Tablet
from watch_history as W left join customers as C on W.customer_id = C.customer_id
group by country;


---------top genres watched accross countries----------
---Description: understanging genre watching pattern accross countries
---Tables used: watch_history, customers, title_genres, genres
with ranked_genres as (select 
    C.country,
    G.genre_name,
    count(*) as watch_count,
    row_number() over (partition by C.country order by COUNT(*) desc) as genre_rank
from 
    customers as C  
    right join watch_history as W on C.customer_id = W.customer_id
    join title_genres as T on W.title_id = T.title_id
    join genres as G on T.genre_id = G.genre_id
group by 
    C.country, 
    G.genre_name)
    select * from ranked_genres where genre_rank <= 3;

-------------genre rating as per total viewers--------------
---Description: distribution of rating across each genres
---Tables used: ratings, title_genres, genres
select genre_name, rating, count(*) as cnt 
from(select G.genre_name, R.rating from ratings as R join title_genres as T on R.title_id = T.title_id join genres as G on T.genre_id = G.genre_id) 
as sub 
group by genre_name, rating;
