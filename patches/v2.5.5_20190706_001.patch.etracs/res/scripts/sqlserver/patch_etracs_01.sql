alter table account_maingroup alter column title varchar(255) not null
go 

alter table account_maingroup alter column [version] int not null
go 


alter table af_allocation alter column [name] varchar(100) not null 
go 

drop index uix_primary on af_control 
go 
drop index ix_afid on af_control 
go 
alter table af_control alter column afid varchar(50) not null 
go 
alter table af_control alter column startseries int not null 
go 
alter table af_control alter column currentseries int not null 
go 
alter table af_control alter column endseries int not null 
go 

create index ix_afid on af_control (afid) 
go 
create unique index uix_primary on af_control (afid, startseries, prefix, suffix, ukey)
go 

alter table af_control alter column fund_objid varchar(100) null
go 

update aaa set 
	aaa.dtfiled = bbb.startdate 
from af_control aaa, ( 
	select a.objid, min(c.receiptdate) as startdate 
	from af_control a 
		left join cashreceipt c on c.controlid = a.objid 
	where a.dtfiled is null 
	group by a.objid 
)bbb 
where aaa.objid = bbb.objid 
; 

select a.* 
into z20190630_invalid_afcontrol
from af_control a 
where a.dtfiled is null 
go 

delete from af_control where objid in ( 
	select objid from z20190630_invalid_afcontrol 
)
;

drop index ix_dtfiled on af_control 
go 

alter table af_control alter column dtfiled date not null
go 

create index ix_dtfiled on af_control (dtfiled) 
go 


alter table af_control alter column state varchar(50) not null
go 

drop index ix_state on afrequest 
go 

alter table afrequest alter column state varchar(25) not null
go 

create index ix_state on afrequest (state) 
go 

alter table afrequest add 
	[dtapproved] datetime NULL ,
	[approvedby_objid] varchar(50) NULL ,
	[approvedby_name] varchar(160) NULL
go 


alter table bankaccount_ledger alter column objid varchar(150) not null 
go 

alter table bankaccount_ledger alter column jevid varchar(150) not null 
go 

alter table bankaccount_ledger alter column bankacctid varchar(50) not null 
go 

alter table bankaccount_ledger alter column itemacctid varchar(50) not null 
go 

alter table bankaccount_ledger alter column dr decimal(16,4) not null 
go 

alter table bankaccount_ledger alter column cr decimal(16,4) not null 
go 


alter table batchcapture_collection_entry_item alter column fund_objid varchar(100) not null 
go 

alter table batchcapture_collection_entry_item alter column fund_title varchar(255) not null 
go 


CREATE TABLE [dbo].[business_application_task_lock] (
[refid] varchar(50) NOT NULL ,
[state] varchar(50) NOT NULL 
)
GO


CREATE TABLE [dbo].[business_closure] (
[objid] varchar(50) NOT NULL ,
[businessid] varchar(50) NOT NULL ,
[dtcreated] datetime NOT NULL ,
[createdby_objid] varchar(50) NOT NULL ,
[createdby_name] varchar(150) NOT NULL ,
[dtceased] date NOT NULL ,
[dtissued] datetime NOT NULL ,
[remarks] text NULL 
)
GO


CREATE TABLE [dbo].[cashbook_revolving_fund] (
[objid] varchar(50) NOT NULL ,
[state] varchar(25) NOT NULL ,
[dtfiled] datetime NOT NULL ,
[filedby_objid] varchar(50) NOT NULL ,
[filedby_name] varchar(150) NOT NULL ,
[issueto_objid] varchar(50) NOT NULL ,
[issueto_name] varchar(150) NOT NULL ,
[controldate] date NOT NULL ,
[amount] decimal(16,2) NOT NULL ,
[remarks] varchar(255) NOT NULL ,
[fund_objid] varchar(100) NOT NULL ,
[fund_title] varchar(255) NOT NULL 
)
GO


CREATE TABLE [dbo].[cashreceipt_changelog] (
[objid] varchar(50) NOT NULL ,
[receiptid] varchar(50) NOT NULL ,
[dtfiled] datetime NOT NULL ,
[filedby_objid] varchar(50) NOT NULL ,
[filedby_name] varchar(150) NOT NULL ,
[action] varchar(255) NOT NULL ,
[remarks] varchar(255) NOT NULL ,
[oldvalue] text NOT NULL ,
[newvalue] text NOT NULL 
)
GO


alter table cashreceiptpayment_creditmemo alter column account_fund_objid varchar(100) null 
go 


alter table cashreceiptpayment_noncash alter column account_fund_objid varchar(100) null 
go 
alter table cashreceiptpayment_noncash alter column fund_objid varchar(100) null 
go 


CREATE TABLE [dbo].[checkpayment_dishonored] (
[objid] varchar(50) NOT NULL ,
[checkpaymentid] varchar(50) NOT NULL ,
[dtfiled] datetime NOT NULL ,
[filedby_objid] varchar(50) NOT NULL ,
[filedby_name] varchar(150) NOT NULL ,
[remarks] varchar(255) NOT NULL 
)
GO


alter table collectiontype alter column fund_objid varchar(100) null 
go 
alter table collectiontype alter column fund_title varchar(255) null 
go 


alter table collectiontype_account alter column objid varchar(100) not null 
go 


drop index ix_liquidationid on collectionvoucher_fund
go 
alter table collectionvoucher_fund alter column parentid varchar(50) not null
go 
create index ix_liquidationid on collectionvoucher_fund (parentid) 
go 


alter table creditmemotype alter column fund_objid varchar(100) 
go 


alter table depositvoucher_fund alter column parentid varchar(50) not null 
go 


drop index ix_parentid on depositvoucher_fund
go 
alter table depositvoucher_fund alter column parentid varchar(50) not null 
go
create index ix_parentid on depositvoucher_fund (parentid) 
go 


alter table entity alter column [name] varchar(MAX) not null 
go 
alter table entity add state varchar(25) null 
go 
update entity set state = 'ACTIVE' where state IS NULL 
go 
alter table entity alter column state varchar(25) not null 
go 


alter table entity_fingerprint alter column entityid varchar(50) not null 
go 


if object_id('dbo.epayment', 'U') IS NOT NULL 
  drop table dbo.epayment; 
go 

alter table fundgroup alter column indexno int not null 
go 


CREATE TABLE [dbo].[holiday] (
[objid] varchar(50) NOT NULL ,
[year] int NULL ,
[month] int NULL ,
[day] int NULL ,
[week] int NULL ,
[dow] int NULL ,
[name] varchar(255) NULL 
)
go 

alter table holiday add constraint pk_holiday primary key (objid) 
go 


alter table income_ledger alter column dr decimal(16,4) not null 
go 
alter table income_ledger alter column cr decimal(16,4) not null 
go 


alter table itemaccount alter column fund_objid varchar(100) null 
go 


CREATE TABLE [dbo].[lob_report_category] (
[objid] varchar(50) NOT NULL ,
[parentid] varchar(50) NULL ,
[groupid] varchar(50) NULL ,
[title] varchar(255) NULL ,
[itemtype] varchar(25) NULL 
)
GO
alter table lob_report_category add constraint pk_lob_report_category primary key (objid) 
go 

CREATE TABLE [dbo].[lob_report_category_mapping] (
[objid] varchar(50) NOT NULL ,
[lobid] varchar(50) NOT NULL ,
[categoryid] varchar(50) NOT NULL 
)
GO
alter table lob_report_category_mapping add constraint pk_lob_report_category_mapping primary key (objid) 
go 

CREATE TABLE [dbo].[lob_report_group] (
[objid] varchar(50) NOT NULL ,
[title] varchar(255) NULL 
)
go 
alter table lob_report_group add constraint pk_lob_report_group primary key (objid) 
go 


if object_id('dbo.sys_report', 'U') IS NOT NULL 
  drop table dbo.sys_report; 
go 

CREATE TABLE [dbo].[sys_report] (
[objid] varchar(50) NOT NULL ,
[folderid] varchar(50) NULL ,
[title] varchar(255) NULL ,
[filetype] varchar(25) NULL ,
[dtcreated] datetime NULL ,
[createdby_objid] varchar(50) NULL ,
[createdby_name] varchar(255) NULL ,
[datasetid] varchar(50) NULL ,
[template] varchar(MAX) NULL ,
[outputtype] varchar(50) NULL ,
[system] int NULL 
)
GO
alter table sys_report add constraint pk_sys_report primary key (objid) 
go 


alter table sys_requirement_type alter column title varchar(255) not null 
go 


alter table sys_rule alter column [name] varchar(255) not null 
go 
alter table sys_rule add default '1' for noloop 
go 


alter table sys_rule_action_param alter column [actiondefparam_objid] varchar(255) NOT NULL
go 


alter table sys_rule_condition_constraint alter column [field_objid] varchar(255) NULL
go 


alter table sys_rule_fact_field alter column objid varchar(255) not null 
go 


alter table sys_usergroup_member drop constraint FK_sys_usergroup_member_securitygorup
go 
alter table sys_usergroup_member drop constraint sys_usergroup_member_ibfk_3
go 
alter table sys_securitygroup alter column objid varchar(100) not null 
go 
alter table sys_usergroup_member alter column securitygroup_objid varchar(100) null 
go 
alter table sys_usergroup_member add constraint fk_sys_usergroup_member_securitygroup
	foreign key (securitygroup_objid) references sys_securitygroup (objid) 
go 


alter table sys_session add terminalid varchar(50) null 
go 

alter table sys_session_log  add terminalid varchar(50) null 
go 


alter table sys_usergroup_permission alter column objid varchar(100) not null 
go 


