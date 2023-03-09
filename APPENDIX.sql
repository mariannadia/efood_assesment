---APPENDIX----
--Calculate total users, orders, average order per user and average amount per order for breakfast cuisine
select count(distinct user_id) users, count(order_id) orders, count(order_id)/count(distinct user_id) as avg_order_per_user, sum(amount)/count(order_id) as avg_amount_per_order
from  efood2022-379810.main_assessment.orders
 where cuisine = 'Breakfast'

 --Calculate total users, orders, average order per user and average amount per order for total efood
select count(distinct user_id) users, count(order_id) orders, count(order_id)/count(distinct user_id) as avg_order_per_user, sum(amount)/count(order_id) as avg_amount_per_order
from  efood2022-379810.main_assessment.orders

--Calculate the percentage of breakfast users with more than 3 orders from total users 
 select break_usersfreq3, total_users, break_usersfreq3/total_users
 from
 (
  select  count(user_id) as break_usersfreq3
  from
  (select user_id, count(order_id) as breakfast_usersfreq3
from efood2022-379810.main_assessment.orders
where  cuisine = 'Breakfast'
  group by 1
  having count(order_id)>3 
  )
 
 )a,
(select count(distinct user_id) total_users
from efood2022-379810.main_assessment.orders
where cuisine = 'Breakfast'
) b
  group by 1,2

--Calculate the breakfast orders vs total orders
   select breakfast_orders, total_orders, breakfast_orders/total_orders
 from

  (select count(order_id) as breakfast_orders
from efood2022-379810.main_assessment.orders
where  cuisine = 'Breakfast'
  )a,
(select count(order_id) as total_orders
from efood2022-379810.main_assessment.orders

  ) b
  group by 1,2

--kpis
  SELECT 
count(DISTINCT user_id) as no_of_users
, count(order_id) as orders
, sum(amount) as basket_value
,count(order_id)/count(distinct user_id) as avg_order_per_user 
,sum(amount)/count(order_id) as avg_order_value
FROM efood2022-379810.main_assessment.orders