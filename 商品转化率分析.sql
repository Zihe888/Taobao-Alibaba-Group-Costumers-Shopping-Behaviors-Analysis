-- 特定商品转化率
select item_id
,count(case when behavior_type='pv' then behavior_type end) as "pv"
,count(case when behavior_type='cart' then behavior_type end) as "cart"
,count(case when behavior_type='fav' then behavior_type end) as "fav"
,count(case when behavior_type='buy' then behavior_type end) as "buy"
,count(distinct case when behavior_type='buy' then user_id end)/count(distinct user_id) “商品转化率”
from temp_behavior
group by item_id
order by “商品转化率” desc;


-- 保存
create table item_detail(
item_id int,
pv int,
fav int,
cart int,
buy int,
user_buy_rate float);

insert into item_detail
select item_id
,count(case when behavior_type='pv' then behavior_type end) as "pv"
,count(case when behavior_type='cart' then behavior_type end) as "cart"
,count(case when behavior_type='fav' then behavior_type end) as "fav"
,count(case when behavior_type='buy' then behavior_type end) as "buy"
,count(distinct case when behavior_type='buy' then user_id end)/count(distinct user_id) “商品转化率”
from user_behavior
group by item_id
order by “商品转化率” desc;

select * from item_detail;

-- 品类转化率

create table category_detail(
category_id int,
pv int,
fav int,
cart int,
buy int,
user_buy_rate float);

insert into category_detail
select category_id
,count(case when behavior_type='pv' then behavior_type end) as "pv"
,count(case when behavior_type='cart' then behavior_type end) as "cart"
,count(case when behavior_type='fav' then behavior_type end) as "fav"
,count(case when behavior_type='buy' then behavior_type end) as "buy"
,count(distinct case when behavior_type='buy' then user_id end)/count(distinct user_id) “品类转化率”
from user_behavior
group by category_id
order by “品类转化率” desc;

select * from category_detail;
