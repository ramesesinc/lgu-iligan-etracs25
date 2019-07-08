CREATE INDEX [ix_year] ON [dbo].[account_incometarget] ([year] ASC)  
GO

CREATE INDEX [ix_name] ON [dbo].[af_allocation] ([name] ASC) 
GO
CREATE INDEX [ix_respcenter_objid] ON [dbo].[af_allocation] ([respcenter_objid] ASC) 
GO
CREATE INDEX [ix_respcenter_name] ON [dbo].[af_allocation] ([respcenter_name] ASC) 
GO

CREATE INDEX [ix_state] ON [dbo].[af_control] ([state] ASC) 
GO

CREATE INDEX [ix_allocid] ON [dbo].[af_control] ([allocid] ASC) 
GO


CREATE INDEX [ix_name] ON [dbo].[bank] ([name] ASC) 
GO
CREATE INDEX [ix_state] ON [dbo].[bank] ([state] ASC) 
GO
CREATE INDEX [ix_code] ON [dbo].[bank] ([code] ASC) 
GO


CREATE INDEX [ix_jevid] ON [dbo].[bankaccount_ledger]
([jevid] ASC) 
GO
CREATE INDEX [ix_bankacctid] ON [dbo].[bankaccount_ledger]
([bankacctid] ASC) 
GO
CREATE INDEX [ix_itemacctid] ON [dbo].[bankaccount_ledger]
([itemacctid] ASC) 
GO


CREATE INDEX [ix_lobid] ON [dbo].[business_active_lob]
([lobid] ASC) 
GO


CREATE INDEX [ix_yearstate] ON [dbo].[business_application]
([appyear] ASC, [state] ASC) 
GO


CREATE INDEX [ix_refid] ON [dbo].[business_application_task_lock]
([refid] ASC) 
GO


ALTER TABLE [dbo].[business_application_task_lock] ADD constraint pk_business_application_task_lock PRIMARY KEY ([refid], [state])
GO


CREATE INDEX [ix_businessid] ON [dbo].[business_closure]
([businessid] ASC) 
GO
CREATE INDEX [ix_dtcreated] ON [dbo].[business_closure]
([dtcreated] ASC) 
GO
CREATE INDEX [ix_createdby_objid] ON [dbo].[business_closure]
([createdby_objid] ASC) 
GO
CREATE INDEX [ix_createdby_name] ON [dbo].[business_closure]
([createdby_name] ASC) 
GO
CREATE INDEX [ix_dtceased] ON [dbo].[business_closure]
([dtceased] ASC) 
GO
CREATE INDEX [ix_dtissued] ON [dbo].[business_closure]
([dtissued] ASC) 
GO


ALTER TABLE [dbo].[business_closure] ADD constraint pk_business_closure PRIMARY KEY ([objid])
GO


if object_id('dbo.ztmp_business_recurringfee_duplicates', 'U') IS NOT NULL 
  drop table dbo.ztmp_business_recurringfee_duplicates; 
go 
select rf.* 
into ztmp_business_recurringfee_duplicates 
from ( 
  select t1.*, 
    (
      select top 1 objid from business_recurringfee 
      where businessid=t1.businessid and account_objid=t1.account_objid 
      order by amount desc 
    ) as recfeeid 
  from ( 
    select businessid, account_objid, count(*) as icount 
    from business_recurringfee 
    group by businessid, account_objid 
    having count(*) > 1 
  )t1 
)t2, business_recurringfee rf 
where rf.businessid = t2.businessid 
  and rf.account_objid = t2.account_objid 
  and rf.objid <> t2.recfeeid 
go 
delete from business_recurringfee where objid in ( 
  select objid from ztmp_business_recurringfee_duplicates 
)
;

CREATE UNIQUE INDEX [uix_businessid_acctid] ON [dbo].[business_recurringfee]
([businessid] ASC, [account_objid] ASC) 
GO


CREATE INDEX [ix_state] ON [dbo].[cashbook_revolving_fund]
([state] ASC) 
GO
CREATE INDEX [ix_dtfiled] ON [dbo].[cashbook_revolving_fund]
([dtfiled] ASC) 
GO
CREATE INDEX [ix_filedby_objid] ON [dbo].[cashbook_revolving_fund]
([filedby_objid] ASC) 
GO
CREATE INDEX [ix_filedby_name] ON [dbo].[cashbook_revolving_fund]
([filedby_name] ASC) 
GO
CREATE INDEX [ix_issueto_objid] ON [dbo].[cashbook_revolving_fund]
([issueto_objid] ASC) 
GO
CREATE INDEX [ix_issueto_name] ON [dbo].[cashbook_revolving_fund]
([issueto_name] ASC) 
GO
CREATE INDEX [ix_controldate] ON [dbo].[cashbook_revolving_fund]
([controldate] ASC) 
GO
CREATE INDEX [ix_fund_objid] ON [dbo].[cashbook_revolving_fund]
([fund_objid] ASC) 
GO
CREATE INDEX [ix_fund_title] ON [dbo].[cashbook_revolving_fund]
([fund_title] ASC) 
GO

ALTER TABLE [dbo].[cashbook_revolving_fund] ADD constraint pk_cashbook_revolving_fund PRIMARY KEY ([objid])
GO

CREATE UNIQUE INDEX [uix_receiptid] ON [dbo].[cashreceipt_cancelseries] ([receiptid] ASC) 
GO


CREATE INDEX [ix_receiptid] ON [dbo].[cashreceipt_changelog]
([receiptid] ASC) 
GO
CREATE INDEX [ix_dtfiled] ON [dbo].[cashreceipt_changelog]
([dtfiled] ASC) 
GO
CREATE INDEX [ix_filedby_objid] ON [dbo].[cashreceipt_changelog]
([filedby_objid] ASC) 
GO
CREATE INDEX [ix_filedby_name] ON [dbo].[cashreceipt_changelog]
([filedby_name] ASC) 
GO
CREATE INDEX [ix_action] ON [dbo].[cashreceipt_changelog]
([action] ASC) 
GO
ALTER TABLE [dbo].[cashreceipt_changelog] ADD constraint pk_cashreceipt_changelog PRIMARY KEY ([objid])
GO


CREATE UNIQUE INDEX [uix_receiptid] ON [dbo].[cashreceipt_void]
([receiptid] ASC) 
GO


CREATE INDEX [ix_item_code] ON [dbo].[cashreceiptitem]
([item_code] ASC) 
GO


CREATE INDEX [ix_txnno] ON [dbo].[certification]
([txnno] ASC) 
GO
CREATE INDEX [ix_txndate] ON [dbo].[certification]
([txndate] ASC) 
GO
CREATE INDEX [ix_type] ON [dbo].[certification]
([type] ASC) 
GO
CREATE INDEX [ix_name] ON [dbo].[certification]
([name] ASC) 
GO
CREATE INDEX [ix_orno] ON [dbo].[certification]
([orno] ASC) 
GO
CREATE INDEX [ix_ordate] ON [dbo].[certification]
([ordate] ASC) 
GO
CREATE INDEX [ix_createdbyid] ON [dbo].[certification]
([createdbyid] ASC) 
GO
CREATE INDEX [ix_createdby] ON [dbo].[certification]
([createdby] ASC) 
GO


CREATE INDEX [ix_checkpaymentid] ON [dbo].[checkpayment_dishonored]
([checkpaymentid] ASC) 
GO
CREATE INDEX [ix_dtfiled] ON [dbo].[checkpayment_dishonored]
([dtfiled] ASC) 
GO
CREATE INDEX [ix_filedby_objid] ON [dbo].[checkpayment_dishonored]
([filedby_objid] ASC) 
GO
CREATE INDEX [ix_filedby_name] ON [dbo].[checkpayment_dishonored]
([filedby_name] ASC) 
GO
ALTER TABLE [dbo].[checkpayment_dishonored] ADD constraint pk_checkpayment_dishonored PRIMARY KEY ([objid])
GO


CREATE INDEX [ix_state] ON [dbo].[collectiongroup]
([state] ASC) 
GO


CREATE INDEX [ix_state] ON [dbo].[collectiontype]
([state] ASC) 
GO


CREATE INDEX [ix_account_title] ON [dbo].[collectiontype_account]
([account_title] ASC) 
GO


CREATE UNIQUE INDEX [uix_controlno] ON [dbo].[collectionvoucher]
([controlno] ASC) 
GO


CREATE INDEX [ix_controldate] ON [dbo].[collectionvoucher]
([controldate] ASC) 
GO


alter table collectionvoucher_fund add ukey varchar(50) not null default ''
go 
update collectionvoucher_fund set ukey = NEWID() where ukey = ''
go 

CREATE UNIQUE INDEX [uix_parentid_fund_objid] ON [dbo].[collectionvoucher_fund]
([parentid] ASC, [fund_objid] ASC, ukey) 
GO
CREATE INDEX [ix_controlno] ON [dbo].[collectionvoucher_fund]
([controlno] ASC) 
GO
CREATE INDEX [ix_parentid] ON [dbo].[collectionvoucher_fund]
([parentid] ASC) 
GO
CREATE INDEX [ix_fund_objid] ON [dbo].[collectionvoucher_fund]
([fund_objid] ASC) 
GO


CREATE INDEX [ix_createdby_name] ON [dbo].[depositslip]
([createdby_name] ASC) 
GO


CREATE INDEX [ix_validation_refno] ON [dbo].[depositslip]
([validation_refno] ASC) 
GO
CREATE INDEX [ix_validation_refdate] ON [dbo].[depositslip]
([validation_refdate] ASC) 
GO


CREATE UNIQUE INDEX [uix_controlno] ON [dbo].[depositvoucher]
([controlno] ASC) 
GO


CREATE UNIQUE INDEX [uix_parentid_fundid] ON [dbo].[depositvoucher_fund]
([parentid] ASC, [fundid] ASC) 
GO
CREATE INDEX [ix_state] ON [dbo].[depositvoucher_fund]
([state] ASC) 
GO


CREATE INDEX [ix_dtposted] ON [dbo].[depositvoucher_fund]
([dtposted] ASC) 
GO
CREATE INDEX [ix_postedby_objid] ON [dbo].[depositvoucher_fund]
([postedby_objid] ASC) 
GO
CREATE INDEX [ix_postedby_name] ON [dbo].[depositvoucher_fund]
([postedby_name] ASC) 
GO


CREATE INDEX [ix_state] ON [dbo].[eftpayment]
([state] ASC) 
GO
CREATE INDEX [ix_refdate] ON [dbo].[eftpayment]
([refdate] ASC) 
GO
CREATE INDEX [ix_createdby_objid] ON [dbo].[eftpayment]
([createdby_objid] ASC) 
GO
CREATE INDEX [ix_receiptid] ON [dbo].[eftpayment]
([receiptid] ASC) 
GO
CREATE INDEX [ix_payer_objid] ON [dbo].[eftpayment]
([payer_objid] ASC) 
GO
CREATE INDEX [ix_payer_address_objid] ON [dbo].[eftpayment]
([payer_address_objid] ASC) 
GO


CREATE INDEX [ix_state] ON [dbo].[entity]
([state] ASC) 
GO
CREATE INDEX [ix_entityname_state] ON [dbo].[entity]
([state] ASC, [entityname] ASC) 
GO


CREATE INDEX [FK_entity_reconciled_entity] ON [dbo].[entity_reconciled]
([masterid] ASC) 
GO


CREATE UNIQUE INDEX [uix_idtype_idno] ON [dbo].[entityid]
([idtype] ASC, [idno] ASC) 
GO


CREATE INDEX [ix_dtregistered] ON [dbo].[entityjuridical]
([dtregistered] ASC) 
GO
CREATE INDEX [ix_administrator_address_objid] ON [dbo].[entityjuridical]
([administrator_address_objid] ASC) 
GO


CREATE UNIQUE INDEX [uix_title] ON [dbo].[fundgroup]
([title] ASC) 
GO


CREATE INDEX [ix_orgid] ON [dbo].[income_summary]
([orgid] ASC) 
GO


CREATE UNIQUE INDEX [uix_acctid_tag] ON [dbo].[itemaccount_tag]
([acctid] ASC, [tag] ASC) 
GO
CREATE INDEX [ix_acctid] ON [dbo].[itemaccount_tag]
([acctid] ASC) 
GO


CREATE INDEX [ix_name] ON [dbo].[lobattribute]
([name] ASC) 
GO


CREATE INDEX [ix_name] ON [dbo].[lobclassification]
([name] ASC) 
GO


ALTER TABLE [dbo].[lobclassification] ADD constraint pk_lobclassification PRIMARY KEY ([objid])
GO


CREATE UNIQUE INDEX [uix_controlno] ON [dbo].[remittance]
([controlno] ASC) 
GO


create unique index uix_sys_org on sys_org ([name] ASC, [parent_objid] ASC)
GO


CREATE INDEX [ix_folderid] ON [dbo].[sys_report]
([folderid] ASC) 
GO


CREATE UNIQUE INDEX [uix_username] ON [dbo].[sys_user]
([username] ASC) 
GO


ALTER TABLE [dbo].[bankaccount_ledger] ADD constraint fk_bankaccount_ledger_jevid 
	FOREIGN KEY ([jevid]) REFERENCES [dbo].[jev] ([objid]) 
go 


delete from business_active_lob where objid in ( 
	select al.objid  
	from business_active_lob al 
		left join lob on lob.objid = al.lobid 
	where lob.objid is null 
		and al.lobid is not null 
)
; 
ALTER TABLE [dbo].[business_active_lob] ADD constraint fk_business_active_lob_lobid 
	FOREIGN KEY ([lobid]) REFERENCES [dbo].[lob] ([objid]) 
GO


ALTER TABLE [dbo].[business_application_lob] ADD constraint fk_business_application_lob_businessid 
	FOREIGN KEY ([businessid]) REFERENCES [dbo].[business] ([objid]) 
GO
ALTER TABLE [dbo].[business_application_lob] ADD constraint fk_business_application_lob_lobid 
	FOREIGN KEY ([lobid]) REFERENCES [dbo].[lob] ([objid]) 
GO


ALTER TABLE [dbo].[business_application_task_lock] ADD constraint fk_business_application_task_lock_refid 
	FOREIGN KEY ([refid]) REFERENCES [dbo].[business_application] ([objid]) 
GO


ALTER TABLE [dbo].[business_payment] ADD constraint fk_business_payment_businessid 
	FOREIGN KEY ([businessid]) REFERENCES [dbo].[business] ([objid]) 
GO


update aa set 
	aa.subcollector_remittanceid = null 
from cashreceipt aa, ( 
	select c.objid, c.subcollector_remittanceid  
	from cashreceipt c 
		left join subcollector_remittance sr on sr.objid = c.subcollector_remittanceid
	where c.subcollector_remittanceid is not null 
		and sr.objid is null 
)bb 
where aa.objid = bb.objid 
; 


ALTER TABLE [dbo].[cashreceipt] ADD constraint fk_cashreceipt_collectiontype_objid 
	FOREIGN KEY ([collectiontype_objid]) REFERENCES [dbo].[collectiontype] ([objid]) 
GO
ALTER TABLE [dbo].[cashreceipt] ADD constraint fk_cashreceipt_subcollector_remittanceid 
	FOREIGN KEY ([subcollector_remittanceid]) REFERENCES [dbo].[subcollector_remittance] ([objid]) 
GO


ALTER TABLE [dbo].[cashreceipt_changelog] ADD constraint fk_cashreceipt_changelog_receiptid 
	FOREIGN KEY ([receiptid]) REFERENCES [dbo].[cashreceipt] ([objid]) 
GO


ALTER TABLE [dbo].[cashreceipt_reprint_log] ADD constraint fk_cashreceipt_reprint_log_receiptid 
	FOREIGN KEY ([receiptid]) REFERENCES [dbo].[cashreceipt] ([objid]) 
GO


ALTER TABLE [dbo].[cashreceipt_share] ADD constraint fk_cashreceipt_share_payableitem_objid 
	FOREIGN KEY ([payableitem_objid]) REFERENCES [dbo].[itemaccount] ([objid]) 
GO
ALTER TABLE [dbo].[cashreceipt_share] ADD constraint fk_cashreceipt_share_receiptid 
	FOREIGN KEY ([receiptid]) REFERENCES [dbo].[cashreceipt] ([objid]) 
GO
ALTER TABLE [dbo].[cashreceipt_share] ADD constraint fk_cashreceipt_share_refitem_objid 
	FOREIGN KEY ([refitem_objid]) REFERENCES [dbo].[itemaccount] ([objid]) 
GO


select ci.* 
into z20190708_invalid_cashreceiptitem 
from cashreceiptitem ci 
where ci.receiptid not in ( 
	select objid from cashreceipt where objid = ci.receiptid 
) 
;
delete from cashreceiptitem where objid in ( 
	select objid from z20190708_invalid_cashreceiptitem 
	where objid = cashreceiptitem.objid 
)
;

ALTER TABLE [dbo].[cashreceiptitem] ADD constraint fk_cashreceiptitem_receiptid 
	FOREIGN KEY ([receiptid]) REFERENCES [dbo].[cashreceipt] ([objid]) 
GO


ALTER TABLE [dbo].[checkpayment_dishonored] ADD constraint fk_checkpayment_dishonored_checkpaymentid 
	FOREIGN KEY ([checkpaymentid]) REFERENCES [dbo].[checkpayment] ([objid]) 
GO


ALTER TABLE [dbo].[collectiongroup_account] ADD constraint fk_collectiongroup_account_collectiongroupid 
	FOREIGN KEY ([collectiongroupid]) REFERENCES [dbo].[collectiongroup] ([objid]) 
GO


ALTER TABLE [dbo].[collectiontype] ADD constraint fk_collectiontype_fund_objid 
	FOREIGN KEY ([fund_objid]) REFERENCES [dbo].[fund] ([objid]) 
GO


ALTER TABLE [dbo].[collectiontype_account] ADD constraint fk_collectiontype_account_collectiontypeid 
	FOREIGN KEY ([collectiontypeid]) REFERENCES [dbo].[collectiontype] ([objid]) 
GO
ALTER TABLE [dbo].[collectiontype_account] ADD constraint fk_collectiontype_account_account_objid 
	FOREIGN KEY ([account_objid]) REFERENCES [dbo].[itemaccount] ([objid]) 
GO


ALTER TABLE [dbo].[collectiontype_org] ADD constraint fk_collectiontype_org_collectiontypeid 
	FOREIGN KEY ([collectiontypeid]) REFERENCES [dbo].[collectiontype] ([objid]) 
GO


ALTER TABLE [dbo].[creditmemotype] ADD constraint fk_creditmemotype_fund_objid 
	FOREIGN KEY ([fund_objid]) REFERENCES [dbo].[fund] ([objid]) 
GO


select a.* 
into z20190708_invalid_entity_address 
from entity_address a 
where a.parentid not in ( 
	select objid from entity 
	where objid = a.parentid 
)
go 
delete from entity_address where objid in (
	select objid from z20190708_invalid_entity_address 
	where objid = entity_address.objid 
)
;

ALTER TABLE [dbo].[entity_address] ADD constraint fk_entity_address_parentid 
	FOREIGN KEY ([parentid]) REFERENCES [dbo].[entity] ([objid]) 
GO


ALTER TABLE [dbo].[entityid] ADD constraint fk_entityid_entityid 
	FOREIGN KEY ([entityid]) REFERENCES [dbo].[entity] ([objid]) 
GO


alter table entity alter column entityno varchar(50) not null 
go 

insert into entity (
	objid, entityno, name, address_text, type, entityname, state 
) 
select 
	a.objid, a.objid as entityno, 
	(a.firstname +(case when isnull(a.middlename,'')='' then '' else (' '+ a.middlename) end)+' '+ a.lastname) as name, 
	'' as address_text, 'INDIVIDUAL' as type, 
	(a.firstname +(case when isnull(a.middlename,'')='' then '' else (' '+ a.middlename) end)+' '+ a.lastname) as entityname, 
	'INACTIVE' as state 
from entityindividual a 
where a.objid not in (
	select objid from entity 
	where objid = a.objid 
)
go 

ALTER TABLE [dbo].[entityindividual] ADD constraint fk_entityindividual_objid 
	FOREIGN KEY ([objid]) REFERENCES [dbo].[entity] ([objid]) 
GO


select a.* 
into z20190708_invalid_entityjuridical
from entityjuridical a 
where a.objid not in (
	select objid from entity 
	where objid = a.objid 
)
go 
delete from entityjuridical where objid in (
	select objid from z20190708_invalid_entityjuridical 
	where objid = entityjuridical.objid 
)
; 

ALTER TABLE [dbo].[entityjuridical] ADD constraint fk_entityjuridical_objid 
	FOREIGN KEY ([objid]) REFERENCES [dbo].[entity] ([objid]) 
GO


ALTER TABLE [dbo].[income_ledger] ADD constraint fk_income_ledger_itemacctid 
	FOREIGN KEY ([itemacctid]) REFERENCES [dbo].[itemaccount] ([objid]) 
GO


ALTER TABLE [dbo].[jevitem] ADD constraint fk_jevitem_jevid 
	FOREIGN KEY ([jevid]) REFERENCES [dbo].[jev] ([objid]) 
GO


update aa set 
	aa.classification_objid = 'OTHER'
from lob aa, ( 
	select a.objid from lob a 
	where a.classification_objid not in (
		select objid from lobclassification 
	)
)bb 
where aa.objid = bb.objid 
go 

ALTER TABLE [dbo].[lob] ADD constraint fk_lob_classification_objid 
	FOREIGN KEY ([classification_objid]) REFERENCES [dbo].[lobclassification] ([objid]) 
GO


ALTER TABLE [dbo].[remittance] ADD constraint fk_remittance_collectionvoucherid 
	FOREIGN KEY ([collectionvoucherid]) REFERENCES [dbo].[collectionvoucher] ([objid]) 
GO


select * 
into z20190708_invalid_remittance_fund 
from remittance_fund  
where fund_objid not in (
	select objid from fund 
) 
go 
delete from remittance_fund where objid in (
	select objid from z20190708_invalid_remittance_fund 
)
; 
ALTER TABLE [dbo].[remittance_fund] ADD constraint fk_remittance_fund_fund_objid 
	FOREIGN KEY ([fund_objid]) REFERENCES [dbo].[fund] ([objid]) 
GO


ALTER TABLE [dbo].[sys_usergroup_member] ADD constraint fk_sys_usergroup_member_user_objid 
	FOREIGN KEY ([user_objid]) REFERENCES [dbo].[sys_user] ([objid]) 
GO
ALTER TABLE [dbo].[sys_usergroup_member] ADD constraint fk_sys_usergroup_member_usergroup_objid 
	FOREIGN KEY ([usergroup_objid]) REFERENCES [dbo].[sys_usergroup] ([objid]) 
GO
ALTER TABLE [dbo].[sys_usergroup_member] ADD constraint fk_sys_usergroup_member_securitygroup_objid 
	FOREIGN KEY ([securitygroup_objid]) REFERENCES [dbo].[sys_securitygroup] ([objid]) 
GO

