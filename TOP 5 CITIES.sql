with cities_with_more_than_1000_orders as 
(select 
city, 
count(order_id) as number_of_orders
FROM efood2022-379810.main_assessment.orders
group by 1
having count(order_id) > 1000
order by 2 desc),

efood_basket as 
(select city,count(order_id) as total_orders,count(distinct user_id) as total_users, sum(amount)/count(order_id) as efood_basket, count(order_id)/count(distinct user_id) as efood_freq
from efood2022-379810.main_assessment.orders
group by 1),

breakfast_basket as 
(select city, 
count(order_id) as breakfast_orders, 
count(distinct user_id) as breakfast_users,
sum(amount)/count(order_id) as breakfast_basket,
count(order_id)/count(distinct user_id) as breakfast_freq
from efood2022-379810.main_assessment.orders
where cuisine = 'Breakfast'
group by 1),

breakfast_users_more_than_3_orders as 
(select city, count(user_id) as break_usersfreq3
from
(select city, user_id, count(order_id) as breakfast_usersfreq3
from efood2022-379810.main_assessment.orders
where  cuisine = 'Breakfast'
  group by 1,2
  having count(order_id)>3 )
  group by 1
),

total_users_more_than_3_orders as 
(select city, count(user_id) as total_usersfreq3
  from
  (select city, user_id, count(order_id) as total_usersfreq3
from efood2022-379810.main_assessment.orders
  group by 1,2
  having count(order_id)>3 
  )
  group by 1
)

select 
a.city
--,breakfast_orders
,breakfast_basket
,efood_basket
,breakfast_freq
,efood_freq
,break_usersfreq3/breakfast_users as breakfast_users3freq_perc
,total_usersfreq3/total_users as breakfast_users3freq_perc
from cities_with_more_than_1000_orders a 
left join efood_basket b on a.city = b.city
left join breakfast_basket c on a.city = c.city
left join breakfast_users_more_than_3_orders d on a.city = d.city
left join total_users_more_than_3_orders e on a.city = e.city
order by breakfast_orders desc
limit 5

--COMMENTS ON THE FINDINGS AND THE QUERIES ARE IN APPENDIX
--Based on the findings we can see that the 5 cities with the most breakfast orders are Βόλος,Λάρισα, Ξάνθη, Ιωάννινα and Ρόδος.
--We observe that the last two cities have higher breakfast basket than the first three which follows the same pattern with total efood basket
--We can also observe that among the 5 cities only Ξανθη has lower breakfast basket (€4.9) than the total breakfast basket of efood (€5.1). 
--Last but not least, we can see that Ξανθη (34.6%) , Bolos(30.6%), and Rodos(30.6%) have higher percentage of users that exceed 3 orders than total   --efood breakfast (29.8%)
--The amount gained from breakfast orders is 23.3% of the total efood amount 


