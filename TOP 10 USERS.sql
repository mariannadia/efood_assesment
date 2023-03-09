with total_city_orders as 
(select  city, 
count(order_id) as total_orders
from efood2022-379810.main_assessment.orders
group by 1),


orders_per_user as 
(select city, user_id, count(order_id)  as orders_per_user_city
from efood2022-379810.main_assessment.orders
group by 1,2
order by 3 desc),

 ranking as 
 (select city,user_id,orders_per_user_city,  rank () over (partition by city order by orders_per_user_city desc) as rank_
from orders_per_user
 ),

 top_10 as 
 (select city,  count(user_id) as top_10_users, sum(orders_per_user_city) as top_10 from ranking
 where rank_ <= 10
 group by city)

select a.city,top_10_users, top_10/total_orders as percentage_contribution
from total_city_orders a left join top_10 b on a.city = b.city
order by 2 desc




