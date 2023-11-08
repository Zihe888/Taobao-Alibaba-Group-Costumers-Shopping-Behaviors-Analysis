-- 统计日期-小时的行为
select dates,hours
,count(case when behavior_type='pv' then behavior_type end) as "pv"
,count(case when behavior_type='cart' then behavior_type end) as "cart"
,count(case when behavior_type='fav' then behavior_type end) as "fav"
,count(case when behavior_type='buy' then behavior_type end) as "buy"
from temp_behavior
group by dates,hours
order by dates,hours;

-- 存储
create table date_hour_behavior(
dates char(10),
hours char(2),
pv int,
cart int,
fav int,
buy int);

-- 结果插入
insert into date_hour_behavior
select dates,hours
,count(case when behavior_type='pv' then behavior_type end) as "pv"
,count(case when behavior_type='cart' then behavior_type end) as "cart"
,count(case when behavior_type='fav' then behavior_type end) as "fav"
,count(case when behavior_type='buy' then behavior_type end) as "buy"

from user_behavior
group by dates,hours
order by dates,hours;

select * from date_hour_behavior;
