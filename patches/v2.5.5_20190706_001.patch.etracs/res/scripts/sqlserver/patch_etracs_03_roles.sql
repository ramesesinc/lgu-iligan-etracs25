if object_id('dbo.zpatch20190707_sys_usergroup_permission', 'U') IS NOT NULL 
  drop table dbo.zpatch20190707_sys_usergroup_permission; 
go 
if object_id('dbo.zpatch20190707_sys_usergroup', 'U') IS NOT NULL 
  drop table dbo.zpatch20190707_sys_usergroup; 
go 

select * into zpatch20190707_sys_usergroup from sys_usergroup 
select * into zpatch20190707_sys_usergroup_permission from sys_usergroup_permission 
go 

delete from zpatch20190707_sys_usergroup_permission
delete from zpatch20190707_sys_usergroup
go 


INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('ADMIN.NOTIFICATION', 'SYSTEM ADMINISTRATOR', 'ADMIN', 'usergroup', NULL, 'NOTIFICATION');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('ADMIN.SYSADMIN', 'SYSTEM ADMINISTRATOR', 'ADMIN', 'usergroup', NULL, 'SYSADMIN');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('DEVELOPER.REPORT', 'SYSTEM ADMINISTRATOR', 'DEVELOPER', 'usergroup', NULL, 'REPORT');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('ENTERPRISE.MASTER', 'ENTERPRISE MASTER', 'ENTERPRISE', 'usergroup', NULL, 'MASTER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('ENTITY.ADMIN', 'ENTITY ADMIN', 'ENTITY', 'usergroup', NULL, 'ADMIN');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('ENTITY.APPROVER', 'ENTITY APPROVER', 'ENTITY', 'usergroup', NULL, 'APPROVER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('ENTITY.MASTER', 'ENTITY MASTER', 'ENTITY', 'usergroup', NULL, 'MASTER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('EPAYMENT.MASTER', 'EPAYMENT MASTER', 'EPAYMENT', 'usergroup', NULL, 'MASTER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('FINANCIAL.ADMIN', 'FINANCIAL ADMIN', 'FINANCIAL', 'usergroup', NULL, 'ADMIN');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('FINANCIAL.COLLECTOR', 'FINANCIAL', 'FINANCIAL', 'usergroup', NULL, 'COLLECTOR');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('FINANCIAL.MASTER', 'FINANCIAL MASTER', 'FINANCIAL', 'usergroup', NULL, 'MASTER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('FINANCIAL.REPORT', 'FINANCIAL REPORT', 'FINANCIAL', 'usergroup', NULL, 'REPORT');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('RULEMGMT.MASTER', 'RULEMGMT MASTER', 'RULEMGMT', 'usergroup', NULL, 'MASTER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.ADMIN', 'TREASURY ADMIN', 'TREASURY', 'usergroup', NULL, 'ADMIN');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.AFO', 'ACCOUNTABLE FORM OFFICER', 'TREASURY', 'usergroup', NULL, 'AFO');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.APPROVER', 'TREASURY APPROVER', 'TREASURY', 'usergroup', NULL, 'APPROVER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.CASHIER', 'CASHIER', 'TREASURY', 'usergroup', NULL, 'CASHIER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.COLLECTOR', 'COLLECTOR', 'TREASURY', 'usergroup', NULL, 'COLLECTOR');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.DATA_CONTROLLER', 'TREASURY DATA CONTROLLER', 'TREASURY', 'usergroup', NULL, 'DATA_CONTROLLER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.LIQUIDATING_OFFICER', 'LIQUIDATING OFFICER', 'TREASURY', 'usergroup', NULL, 'LIQUIDATING_OFFICER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.MASTER', 'TREASURY MASTER', 'TREASURY', 'usergroup', NULL, 'MASTER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.REPORT', 'TREASURY REPORT', 'TREASURY', 'usergroup', NULL, 'REPORT');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.RIS_APPROVER', 'TREASURY RIS_APPROVER', 'TREASURY', 'usergroup', NULL, 'RIS_APPROVER');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.RULE_AUTHOR', 'TREASURY RULE AUTHOR', 'TREASURY', 'usergroup', NULL, 'RULE_AUTHOR');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.SHARED', 'TREASURY SHARED', 'TREASURY', 'usergroup', NULL, 'SHARED');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('TREASURY.SUBCOLLECTOR', 'SUBCOLLECTOR', 'TREASURY', 'usergroup', NULL, 'SUBCOLLECTOR');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('WORKFLOW.ADMIN', 'WORKFLOW ADMIN', 'WORKFLOW', 'usergroup', NULL, 'ADMIN');
INSERT INTO zpatch20190707_sys_usergroup (objid, title, domain, userclass, orgclass, role) VALUES ('WORKFLOW.MASTER', 'WORKFLOW MASTER', 'WORKFLOW', 'usergroup', NULL, 'MASTER');

INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-createIndividual', 'ENTITY.MASTER', 'individualentity', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-createJuridical', 'ENTITY.MASTER', 'juridicalentity', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-createMultiple', 'ENTITY.MASTER', 'multipleentity', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-deleteIndividual', 'ENTITY.MASTER', 'individualentity', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-deleteJuridical', 'ENTITY.MASTER', 'juridicalentity', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-deleteMultiple', 'ENTITY.MASTER', 'multipleentity', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-editIndividual', 'ENTITY.MASTER', 'individualentity', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-editJuridical', 'ENTITY.MASTER', 'juridicalentity', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-editMultiple', 'ENTITY.MASTER', 'multipleentity', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-editname', 'ENTITY.MASTER', 'individualentity', 'editname', 'Edit Name');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-openIndividual', 'ENTITY.MASTER', 'individualentity', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-openJuridical', 'ENTITY.MASTER', 'juridicalentity', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('ENTITY-MASTER-openMultiple', 'ENTITY.MASTER', 'multipleentity', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('SUBCOLLECTOR-DISAPPROVED', 'TREASURY.SUBCOLLECTOR', 'batchcapture', 'disapprove', 'disapprove');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('SUBCOLLECTOR-POST', 'TREASURY.SUBCOLLECTOR', 'batchcapture', 'post', 'post');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-ADMIN-receipt-void', 'TREASURY.ADMIN', 'receipt', 'void', 'Void Receipt');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-AFO-afserial-forward', 'TREASURY.AFO', 'afserial', 'forward', 'Forward');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-AFO-cashticket-forward', 'TREASURY.AFO', 'cashticket', 'forward', 'Forward');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-COLLECTOR', 'TREASURY.COLLECTOR', 'receipt', 'online', 'online');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-COLLECTOR-receipt-void', 'TREASURY.COLLECTOR', 'receipt', 'void', 'Void Receipt');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-DATA_CONTROLLER-batchcapture-manage', 'TREASURY.DATA_CONTROLLER', 'batchcapture', 'manage', 'Manage Batch Capture');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-LIQUIDATING_OFFICER', 'TREASURY.LIQUIDATING_OFFICER', 'cashbook', 'list', 'list');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createbank', 'TREASURY.MASTER', 'bank', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createcashbook', 'TREASURY.MASTER', 'cashbook', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createcollectiongroup', 'TREASURY.MASTER', 'collectiongroup', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createcollectiontype', 'TREASURY.MASTER', 'collectiontype', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createFund', 'TREASURY.MASTER', 'fund', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createRevenueItem', 'TREASURY.MASTER', 'revenueitem', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-createsreaccount', 'TREASURY.MASTER', 'sreaccount', 'create', 'Create');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deletebank', 'TREASURY.MASTER', 'bank', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deletecashbook', 'TREASURY.MASTER', 'cashbook', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deletecollectiongroup', 'TREASURY.MASTER', 'collectiongroup', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deletecollectiontype', 'TREASURY.MASTER', 'collectiontype', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deleteFund', 'TREASURY.MASTER', 'fund', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deleteRevenueItem', 'TREASURY.MASTER', 'revenueitem', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-deletesreaccount', 'TREASURY.MASTER', 'sreaccount', 'delete', 'Delete');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editbank', 'TREASURY.MASTER', 'bank', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editcashbook', 'TREASURY.MASTER', 'cashbook', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editcollectiongroup', 'TREASURY.MASTER', 'collectiongroup', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editcollectiontype', 'TREASURY.MASTER', 'collectiontype', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editFund', 'TREASURY.MASTER', 'fund', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editRevenueItem', 'TREASURY.MASTER', 'revenueitem', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-editsreaccount', 'TREASURY.MASTER', 'sreaccount', 'edit', 'Edit');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-openbank', 'TREASURY.MASTER', 'bank', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-opencashbook', 'TREASURY.MASTER', 'cashbook', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-opencollectiongroup', 'TREASURY.MASTER', 'collectiongroup', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-opencollectiontype', 'TREASURY.MASTER', 'collectiontype', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-openFund', 'TREASURY.MASTER', 'fund', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-openRevenueItem', 'TREASURY.MASTER', 'revenueitem', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-opensreaccount', 'TREASURY.MASTER', 'sreaccount', 'open', 'Open');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewbank', 'TREASURY.MASTER', 'bank', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewcashbook', 'TREASURY.MASTER', 'cashbook', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewcollectiongroup', 'TREASURY.MASTER', 'collectiongroup', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewcollectiontype', 'TREASURY.MASTER', 'collectiontype', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewFund', 'TREASURY.MASTER', 'fund', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewRevenueItem', 'TREASURY.MASTER', 'revenueitem', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-MASTER-viewsreaccount', 'TREASURY.MASTER', 'sreaccount', 'view', 'View');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-REPORT-collectionbyfund-viewreport', 'TREASURY.REPORT', 'collectionbyfund', 'viewreport', 'View Report');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-REPORT-directtocash-viewreport', 'TREASURY.REPORT', 'directtocash', 'viewreport', 'View Report');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-REPORT-srs-viewreport', 'TREASURY.REPORT', 'srs', 'viewreport', 'View Report');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-REPORT-statementofrevenue-viewreport', 'TREASURY.REPORT', 'statementofrevenue', 'viewreport', 'View Report');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-SHARED-bankdeposit-view', 'TREASURY.SHARED', 'bankdeposit', 'view', 'View List');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-SHARED-liquidation-view', 'TREASURY.SHARED', 'liquidation', 'view', 'View List');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-SHARED-remittance-view', 'TREASURY.SHARED', 'remittance', 'view', 'View List');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY-SUBCOLLECTOR-receipt-void', 'TREASURY.SUBCOLLECTOR', 'receipt', 'void', 'Void Receipt');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.ADMIN.checkpayment_dishonored.view', 'TREASURY.ADMIN', 'checkpayment_dishonored', 'view', 'View Dishonored Checks');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.CASHIER.checkpayment_dishonored.view', 'TREASURY.CASHIER', 'checkpayment_dishonored', 'view', 'View Dishonored Checks');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.COLLECTOR.cashreceipt.convertCashToCheck', 'TREASURY.COLLECTOR', 'cashreceipt', 'convertCashToCheck', 'Convert Cash To Check');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.COLLECTOR.cashreceipt.convertCheckToCash', 'TREASURY.COLLECTOR', 'cashreceipt', 'convertCheckToCash', 'Convert Check To Cash');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.SHARED.checkpayment_dishonored.view', 'TREASURY.SHARED', 'checkpayment_dishonored', 'view', 'View Dishonored Checks');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.SUBCOLLECTOR.cashreceipt.convertCashToCheck', 'TREASURY.SUBCOLLECTOR', 'cashreceipt', 'convertCashToCheck', 'Convert Cash To Check');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('TREASURY.SUBCOLLECTOR.cashreceipt.convertCheckToCash', 'TREASURY.SUBCOLLECTOR', 'cashreceipt', 'convertCheckToCash', 'Convert Check To Cash');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('USRGRPPERMS-4bed8ed4:1679ca684b3:-7510', 'TREASURY.APPROVER', 'cashreceipt', 'approve_void', 'Void Cash Receipt');
INSERT INTO zpatch20190707_sys_usergroup_permission (objid, usergroup_objid, object, permission, title) VALUES ('USRGRPPERMS-4bed8ed4:1679ca684b3:-759f', 'TREASURY.APPROVER', 'cashreceipt', 'approve_reprint', 'Reprint Cash Receipt');

insert into sys_usergroup ( 
  objid, title, domain, userclass, orgclass, role 
) 
select 
  objid, title, domain, userclass, orgclass, role 
from zpatch20190707_sys_usergroup z 
where objid not in (select objid from sys_usergroup where objid = z.objid)
; 

insert into sys_usergroup_permission ( 
  objid, usergroup_objid, object, permission, title 
) 
select 
  objid, usergroup_objid, object, permission, title 
from zpatch20190707_sys_usergroup_permission z 
where objid not in (select objid from sys_usergroup_permission where objid = z.objid) 
; 

update sys_usergroup_permission set object='entityindividual' where object = 'individualentity'; 
update sys_usergroup_permission set object='entityjuridical' where usergroup_objid = 'ENTITY.MASTER' and object like '%juridical%';
update sys_usergroup_permission set object='entitymultiple' where usergroup_objid = 'ENTITY.MASTER' and object like '%multiple%';

update sys_usergroup_member set usergroup_objid='FINANCIAL.MASTER' where usergroup_objid='ACCOUNTING.MASTER';
update sys_usergroup_member set usergroup_objid='FINANCIAL.REPORT' where usergroup_objid='ACCOUNTING.REPORT';

insert into sys_usergroup_member ( 
  objid, state, usergroup_objid, user_objid, user_username, user_firstname, user_lastname, 
  org_objid, org_name, org_orgclass, securitygroup_objid, exclude, displayname, jobtitle 
) 
select * from ( 
  select 
  	('UGM-'+ convert(varchar(50), HashBytes('MD5', ('FINANCIAL.MASTER|' + ugm.user_objid +'|'+ ISNULL(ugm.org_objid,'_'))), 2)) as objid, 
    null as state, 'FINANCIAL.MASTER' as usergroup_objid, ugm.user_objid, 
    ugm.user_username, ugm.user_firstname, ugm.user_lastname, 
    ugm.org_objid, ugm.org_name, ugm.org_orgclass, ugm.securitygroup_objid, 
    ugm.exclude, ugm.displayname, ugm.jobtitle 
  from sys_usergroup_member ugm 
  where ugm.usergroup_objid = 'TREASURY.MASTER'
)t1 
where objid not in (
	select objid from sys_usergroup_member where objid = t1.objid
)
; 

if object_id('dbo.zpatch20190707_sys_usergroup_permission', 'U') IS NOT NULL 
  drop table dbo.zpatch20190707_sys_usergroup_permission; 
go 
if object_id('dbo.zpatch20190707_sys_usergroup', 'U') IS NOT NULL 
  drop table dbo.zpatch20190707_sys_usergroup; 
go 

delete from sys_securitygroup where usergroup_objid like 'ACCOUNTING%'
;
delete from sys_securitygroup where usergroup_objid in ( 
	select objid from sys_usergroup where objid like 'ACCOUNT%' 
)
;
delete from sys_usergroup_permission where usergroup_objid like 'ACCOUNTING%';
delete from sys_usergroup_member where usergroup_objid like 'ACCOUNT%';
delete from sys_usergroup where objid like 'ACCOUNT%';
