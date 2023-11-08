select * from user_behavior where dates is null;
delete from user_behavior where dates is null;


select user_id,dates
from temp_behavior
group by user_id,dates;

-- 自关联
select * from
(select user_id,dates
from temp_behavior
group by user_id,dates
) a
,(select user_id,dates
from temp_behavior
group by user_id,dates
) b
where a.user_id=b.user_id;

-- 筛选
select * from
(select user_id,dates
from temp_behavior
group by user_id,dates
) a
,(select user_id,dates
from temp_behavior
group by user_id,dates
) b
where a.user_id=b.user_id and a.dates<b.dates;

-- 留存数
select a.dates
,count(case when (date(b.dates) - date(a.dates)) = 0 then b.user_id end) as retention_0
,count(case when (date(b.dates) - date(a.dates)) = 1 then b.user_id end) as retention_1
,count(case when (date(b.dates) - date(a.dates)) = 3 then b.user_id end) as retention_3 from

(select user_id,dates
from temp_behavior
group by user_id,dates
) as a
,(select user_id,dates
from temp_behavior
group by user_id,dates
) as b
where a.user_id=b.user_id and a.dates<=b.dates
group by a.dates;

-- 留存率
select a.dates
,0.01*(count(case when (date(b.dates) - date(a.dates)) = 1 then b.user_id end)*10000/count(case when (date(b.dates) - date(a.dates)) = 0 then b.user_id end)) as retention_1
from
(select user_id,dates
from temp_behavior
group by user_id,dates
) as a
,(select user_id,dates
from temp_behavior
group by user_id,dates
) as b
where a.user_id=b.user_id and a.dates<=b.dates
group by a.dates;

-- 保存结果
create table retention_rate (
dates char(10),
retention_1 float
);

insert into retention_rate
select a.dates
,count(case when (date(b.dates) - date(a.dates)) = 1 then b.user_id end)/count(case when (date(b.dates) - date(a.dates)) = 0 then b.user_id end) as retention_1
from
(select user_id,dates
-- from temp_behavior
-- 纠错，这里漏改为原表了
from user_behavior
group by user_id,dates
) a
,(select user_id,dates
from user_behavior
group by user_id,dates
) b
where a.user_id=b.user_id and a.dates<=b.dates
group by a.dates;

select * from retention_rate;

-- 跳失率
-- 跳失用户  -- 88
select count(*)
from
(
select user_id from user_behavior
group by user_id
having count(behavior_type)=1
) as a;


select sum(pv) from pv_uv_puv; -- 89660670

-- 88/89660670
