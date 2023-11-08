-- 创建临时表
create table temp_behavior(like user_behavior including all);

-- 截取
insert into temp_behavior
select * from user_behavior limit 100000;

select * from temp_behavior;

-- pv
select dates,count(*) as "pv"
from temp_behavior
where behavior_type='pv'
GROUP BY dates;
-- uv
select dates
,count(distinct user_id) as "pv"
from temp_behavior
where behavior_type='pv'
GROUP BY dates;

-- 一条语句
select dates
,count(*) as "pv"
,count(distinct user_id) "uv"
,round(count(*)/count(distinct user_id),1) as "pv/uv"
from temp_behavior
where behavior_type='pv'
GROUP BY dates;

-- 处理真实数据
create table pv_uv_puv (
dates char(10),
pv int,
uv int,
puv decimal(10,1)
);

insert into pv_uv_puv
select dates
,count(*) as "pv"
,count(distinct user_id) as "uv"
,round(count(*)/count(distinct user_id),1) as "pv/uv"
from user_behavior
where behavior_type='pv'
GROUP BY dates;

select * from pv_uv_puv;

delete from pv_uv_puv where dates is null;
