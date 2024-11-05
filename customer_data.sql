SELECT count(`CustomerID`)
FROM lita_db.`customer data`;

Rename table `customer data` to customer_data;

Select *
from customer_data;

-- total number of customers from each region
select Region, Count(distinct CustomerID) as Unique_customer_count
from customer_data
group by Region;

-- most popular subscription type by the number of customers
select SubscriptionType, Count(distinct CustomerID) as Unique_customer_count
from customer_data
group by SubscriptionType
Order by 2 Desc
Limit 1;

-- Changing the SubscriptionStart date column to the right format
Select SubscriptionStart, 
str_to_date(SubscriptionStart, '%m/%d/%Y') 
from customer_data;

update customer_data
set SubscriptionStart = str_to_date(SubscriptionStart, '%m/%d/%Y');

Alter table customer_data
modify column SubscriptionStart Date;

-- Changing the SubsciptionEnd date column to the right format
Select SubscriptionEnd, 
str_to_date(SubscriptionEnd, '%m/%d/%Y') 
from customer_data;

update customer_data
set SubscriptionEnd = str_to_date(SubscriptionEnd, '%m/%d/%Y');

Alter table customer_data
modify column SubscriptionEnd Date;

-- customers who canceled their subscription within 6 months
 select CustomerName
from customer_data
where canceled = "True"
and  timestampdiff(month, SubscriptionStart, SubscriptionEnd) <=6;

-- average subscription duration for all customers
Select CustomerName, Avg(timestampdiff(month, SubscriptionStart, SubscriptionEnd)) as AVG_Duration_in_months
From customer_data
group by CustomerName;

-- customers with subscriptions longer than 12 months.
select CustomerName
from customer_data
where canceled = "False"
and  timestampdiff(month, SubscriptionStart, SubscriptionEnd) > 12;

-- total revenue by subscription type.
Select SubscriptionType, Sum(Revenue)
from customer_data
group by SubscriptionType;

-- top 3 regions by subscription cancellations
Select Region, count(Canceled)
from customer_data
Where Canceled = "True"
group by Region
Order by 2 DESC
Limit 3;

-- total number of active and canceled subscriptions.
Select 
Count(Case when Canceled = "False" Then 1 End) as Active_Subscriptions,
Count(Case when Canceled = "True" Then 1 End) as Canceled_Subscriptions
from  customer_data;


