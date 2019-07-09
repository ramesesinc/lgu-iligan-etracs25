-- 
-- Insert data into account_maingroup 
-- 
insert into account_maingroup (
	objid, title, version, reporttype, role, domain, system 
)
select * 
from ( 
	select  
		'SRE-V254' as objid, 'SRE-V254' as title, 0 as version, 
		'SRE' as reporttype, NULL as role, NULL as domain, 0 as system 
)t1
where t1.objid not in (select objid from account_maingroup where objid = t1.objid)
;

-- 
-- Insert data into account 
-- 
insert into account ( 
	objid, maingroupid, code, title, groupid, 
	type, leftindex, rightindex, [level] 
) 
select * 
from ( 
	select 
		objid, 'SRE-V254' as maingroupid, code, title, parentid as groupid, 
		'root' as type, null as leftindex, null as rightindex, null as [level] 
	from sreaccount where parentid is null
	union all 
	select 
		a.objid, 'SRE-V254' as maingroupid, a.code, a.title, a.parentid as groupid, 
		'group' as type, null as leftindex, null as rightindex, null as [level] 
	from sreaccount a, sreaccount p  
	where a.parentid is not null 
		and a.parentid = p.objid 
		and a.type = 'group' 
	union all 
	select 
		a.objid, 'SRE-V254' as maingroupid, a.code, a.title, a.parentid as groupid, 
		'item' as type, null as leftindex, null as rightindex, null as [level] 
	from sreaccount a, sreaccount p  
	where a.parentid is not null 
		and a.parentid = p.objid 
		and a.type = 'detail' 
	union all 
	select 
		a.objid, 'SRE-V254' as maingroupid, a.code, a.title, a.parentid as groupid, 
		'detail' as type, null as leftindex, null as rightindex, null as [level] 
	from sreaccount a, sreaccount p  
	where a.parentid is not null 
		and a.parentid = p.objid 
		and a.type = 'subaccount'  
)t1 
where t1.objid not in (select objid from account where objid = t1.objid) 
;


-- 
-- Insert data into account_item_mapping 
-- 
insert into account_item_mapping ( 
	objid, maingroupid, acctid, itemid 
) 
select 
	rm.objid, a.maingroupid, 
	rm.acctid, rm.revenueitemid as itemid 
from sre_revenue_mapping rm 
	inner join account a on a.objid = rm.acctid 
	inner join itemaccount ia on ia.objid = rm.revenueitemid 
where rm.objid not in (select objid from account_item_mapping where objid = rm.objid)
;


-- 
-- Insert data into account_incometarget 
-- 

insert into account_incometarget (
	objid, itemid, year, target 
)
select * 
from (  
	select 
		(''+ convert(char(4), a.year) +'|'+ a.objid) as objid, 
		a.objid as itemid, a.year, a.target 
	from sreaccount_incometarget a 
		inner join account aa on aa.objid = a.objid
	where a.target is not null 
)t1 
where (select count(*) from account_incometarget where itemid = t1.itemid and year = t1.year) = 0 
order by t1.year, t1.objid 
;
