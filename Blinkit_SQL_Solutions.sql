Create database BlinkitDB

use BlinkitDB ;

select 
	*
from Blinkit_data 

-- Basic Data Exploration 

select 
	count(*)as total_records 
from Blinkit_Data

select 
	distinct Item_Fat_Content
from Blinkit_Data


select 
	min(outlet_establishment_year)as starting_store_year,
	max(outlet_establishment_year)as ending_store_year
from Blinkit_Data


select 
	*
from Blinkit_Data
where Item_Weight is null 


select 
	Outlet_Identifier,
	count(*)as total_count 
from Blinkit_Data
group by Outlet_Identifier
order by total_count


-- Data Cleaning 

update Blinkit_Data
set Item_Fat_Content ='Low Fat'
where Item_Fat_Content ='LF'

select 
	distinct Item_Fat_Content
from Blinkit_Data

update Blinkit_Data
set Item_Fat_Content ='Regular'
where Item_Fat_Content ='reg'

select 
	count(*)as total_count 
from Blinkit_Data


select 
	distinct Item_Fat_Content
from Blinkit_Data

select 
*
from Blinkit_Data

select 
	* 
from Blinkit_Data
where Item_Weight is null 


-- KPI'S Creation

--Q1. Total Sales: The overall revenue generated from all items sold.​
select  
    concat(
        cast(sum(total_sales) / 1000000.0 as decimal(10,1)),
        'M'
    ) as total_sales_Millions
from Blinkit_Data;

--Q2. Average Sales: The average revenue per sale.​
select  
    concat(
        cast(avg(total_sales) as decimal(10,1)) ,
        'M'
    ) as avg_total_sales_Millions
from Blinkit_Data;


--Q3.Number of Items: The total count of different items sold.​

select 
	count(*)as no_of_items
from Blinkit_Data

--Q4.Average Rating: The average customer rating for items sold. ​

select 
	cast(avg(rating) as decimal (10,1))as avg_ratings
from Blinkit_Data


-- Business Requirement Details :

--Q5. Total Sales by Fat Content

select 
	Item_Fat_Content,
	concat(cast(sum(total_sales)/1000000 as decimal (13,2)),'M')as total_fat_content_millions
from Blinkit_Data
group by Item_Fat_Content

-- Q6.Total Sales by Item Type
select 
	Item_Type,
	concat(cast(sum(total_sales)/100000 as decimal (10,2)),'K')as total_item_type_millions
from Blinkit_Data
group by Item_Type

--Q7. Fat Content by Outlet for Total Sales 
with cte as (
select 
	outlet_location_type,
	Item_Fat_Content,
	sum(total_sales)as total_sales 
from Blinkit_Data
group by outlet_location_type,Item_Fat_Content)

, cte3 as (
select 
	outlet_location_type,
	max(case when Item_Fat_Content ='Low Fat' then total_sales end )as Low_Fat_sales,
	max(case when Item_Fat_Content ='Regular' then total_sales end )as Regular_sales
from cte
group by outlet_location_type)

select * from cte3 

--Q8 Total Sales by Outlet Establishment:

select 
Outlet_Establishment_Year,
	count(*)as no_of_items,
	cast(sum(total_sales)as decimal(10,2))as total_sales,
	cast (avg(total_sales)as decimal(10,2))as avg_sales,
	cast(avg(rating)as decimal (10,2))as avg_ratins 
	from Blinkit_Data
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year asc 

--Q9 Percentage of Sales by Outlet Size:
select 
	Outlet_Size,
	cast(sum(total_sales)as decimal(10,2))as total_sales,
	cast(sum(total_sales)*100.0 /(sum(sum(total_sales))over()) as decimal(10,2)) as percentage_growth
from Blinkit_Data
group by Outlet_Size
order by percentage_growth
