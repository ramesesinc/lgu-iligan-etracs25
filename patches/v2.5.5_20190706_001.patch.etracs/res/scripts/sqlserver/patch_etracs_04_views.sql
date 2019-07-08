if object_id('dbo.sys_user_role', 'V') IS NOT NULL 
  drop view dbo.sys_user_role; 
go 
CREATE VIEW sys_user_role AS 
select  
u.objid AS objid, 
u.lastname AS lastname, 
u.firstname AS firstname, 
u.middlename AS middlename, 
u.username AS username,
(u.lastname +', '+ u.firstname +(case when u.middlename is null then '' else (' '+ u.middlename) end)) AS name, 
ug.role AS role, 
ug.domain AS domain, 
ugm.org_objid AS orgid, 
u.txncode AS txncode, 
u.jobtitle AS jobtitle, 
ugm.objid AS usergroupmemberid, 
ugm.usergroup_objid AS usergroup_objid 
from sys_usergroup_member ugm 
  inner join sys_usergroup ug on ug.objid = ugm.usergroup_objid 
  inner join sys_user u on u.objid = ugm.user_objid 
go 


if object_id('dbo.vw_af_control_detail', 'V') IS NOT NULL 
  drop view dbo.vw_af_control_detail; 
go 
CREATE VIEW vw_af_control_detail AS 
select  
  afd.objid AS objid, 
  afd.state AS state, 
  afd.controlid AS controlid, 
  afd.indexno AS indexno, 
  afd.refid AS refid, 
  afd.aftxnitemid AS aftxnitemid, 
  afd.refno AS refno, 
  afd.reftype AS reftype, 
  afd.refdate AS refdate, 
  afd.txndate AS txndate, 
  afd.txntype AS txntype, 
  afd.receivedstartseries AS receivedstartseries, 
  afd.receivedendseries AS receivedendseries, 
  afd.beginstartseries AS beginstartseries, 
  afd.beginendseries AS beginendseries, 
  afd.issuedstartseries AS issuedstartseries, 
  afd.issuedendseries AS issuedendseries, 
  afd.endingstartseries AS endingstartseries, 
  afd.endingendseries AS endingendseries, 
  afd.qtyreceived AS qtyreceived, 
  afd.qtybegin AS qtybegin, 
  afd.qtyissued AS qtyissued, 
  afd.qtyending AS qtyending, 
  afd.qtycancelled AS qtycancelled, 
  afd.remarks AS remarks, 
  afd.issuedto_objid AS issuedto_objid, 
  afd.issuedto_name AS issuedto_name, 
  afd.respcenter_objid AS respcenter_objid, 
  afd.respcenter_name AS respcenter_name, 
  afd.prevdetailid AS prevdetailid, 
  afd.aftxnid AS aftxnid, 
  afc.afid AS afid, 
  afc.unit AS unit, 
  af.formtype AS formtype, 
  af.denomination AS denomination, 
  af.serieslength AS serieslength, 
  afu.qty AS qty, 
  afu.saleprice AS saleprice, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.currentseries AS currentseries, 
  afc.stubno AS stubno, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix, 
  afc.cost AS cost, 
  afc.batchno AS batchno, 
  afc.state AS controlstate, 
  afd.qtyending AS qtybalance 
from af_control_detail afd 
  inner join af_control afc on afc.objid = afd.controlid 
  inner join af on af.objid = afc.afid 
  inner join afunit afu on (afu.itemid = af.objid and afu.unit = afc.unit)
go 



if object_id('dbo.vw_af_inventory_summary', 'V') IS NOT NULL 
  drop view dbo.vw_af_inventory_summary; 
go
CREATE VIEW vw_af_inventory_summary AS 
select  
  af.objid AS objid, 
  af.title AS title, 
  u.unit AS unit,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state in ('OPEN','RETURN')) AS countopen,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'ISSUED') AS countissued,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'CLOSED') AS countclosed,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'SOLD') AS countsold,
  (select count(0) from af_control where af_control.afid = af.objid and af_control.state = 'PROCESSING') AS countprocessing 
from af 
  inner join afunit u on af.objid = u.itemid 
go 


if object_id('dbo.vw_afunit', 'V') IS NOT NULL 
  drop view dbo.vw_afunit; 
go
CREATE VIEW vw_afunit AS 
select  
u.objid AS objid, 
af.title AS title, 
af.usetype AS usetype, 
af.serieslength AS serieslength, 
af.system AS system, 
af.denomination AS denomination, 
af.formtype AS formtype, 
u.itemid AS itemid, 
u.unit AS unit, 
u.qty AS qty, 
u.saleprice AS saleprice, 
u.interval AS interval, 
u.cashreceiptprintout AS cashreceiptprintout, 
u.cashreceiptdetailprintout AS cashreceiptdetailprintout 
from afunit u 
  inner join af on af.objid = u.itemid
go 


if object_id('dbo.vw_cashreceipt_itemaccount', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount; 
go
CREATE VIEW vw_cashreceipt_itemaccount AS 
select  
  itemaccount.objid AS objid, 
  itemaccount.state AS state, 
  itemaccount.code AS code, 
  itemaccount.title AS title, 
  itemaccount.description AS description, 
  itemaccount.type AS type, 
  itemaccount.fund_objid AS fund_objid, 
  itemaccount.fund_code AS fund_code, 
  itemaccount.fund_title AS fund_title, 
  itemaccount.defaultvalue AS defaultvalue, 
  itemaccount.valuetype AS valuetype, 
  itemaccount.sortorder AS sortorder, 
  itemaccount.org_objid AS orgid, 
  itemaccount.hidefromlookup AS hidefromlookup 
from itemaccount 
where itemaccount.state = 'ACTIVE' 
  and itemaccount.type in ('REVENUE','NONREVENUE','PAYABLE') 
  and isnull(itemaccount.generic,0) = 0 
go 


if object_id('dbo.vw_cashreceipt_itemaccount_collectiontype', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount_collectiontype; 
go
CREATE VIEW vw_cashreceipt_itemaccount_collectiontype AS 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title, 
  ca.defaultvalue AS defaultvalue,
  (case when ca.valuetype is null then 'ANY' else ca.valuetype end) AS valuetype,
  (case when ca.sortorder is null then 0 else ca.sortorder end) AS sortorder,
  NULL AS orgid, 
  ca.collectiontypeid AS collectiontypeid, 0 AS hasorg, 
  ia.hidefromlookup AS hidefromlookup 
from collectiontype ct 
  inner join collectiontype_account ca on ca.collectiontypeid = ct.objid 
  inner join itemaccount ia on ia.objid = ca.account_objid 
  left join collectiontype_org o on o.collectiontypeid = ca.objid 
where o.objid is null 
  and ia.state = 'ACTIVE' 
  and ia.type in ('REVENUE','NONREVENUE','PAYABLE') 
union all 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title, 
  ca.defaultvalue AS defaultvalue,
  (case when ca.valuetype is null then 'ANY' else ca.valuetype end) AS valuetype,
  (case when ca.sortorder is null then 0 else ca.sortorder end) AS sortorder, 
  o.org_objid AS orgid, 
  ca.collectiontypeid AS collectiontypeid, 1 AS hasorg, 
  ia.hidefromlookup AS hidefromlookup 
from collectiontype ct 
  inner join collectiontype_org o on o.collectiontypeid = ct.objid 
  inner join collectiontype_account ca on ca.collectiontypeid = ct.objid 
  inner join itemaccount ia on ia.objid = ca.account_objid 
where ia.state = 'ACTIVE' 
  and ia.type in ('REVENUE','NONREVENUE','PAYABLE')
go 


if object_id('dbo.vw_cashreceiptpayment_noncash', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceiptpayment_noncash; 
go
CREATE VIEW vw_cashreceiptpayment_noncash AS 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.amount AS amount, 
  nc.particulars AS particulars, 
  nc.account_objid AS account_objid, 
  nc.account_code AS account_code, 
  nc.account_name AS account_name, 
  nc.account_fund_objid AS account_fund_objid, 
  nc.account_fund_name AS account_fund_name, 
  nc.account_bank AS account_bank, 
  nc.fund_objid AS fund_objid, 
  nc.refid AS refid, 
  nc.checkid AS checkid, 
  nc.voidamount AS voidamount, 
  v.objid AS void_objid,
  (case when v.objid is null then 0 else 1 end) AS voided, 
  c.receiptno AS receipt_receiptno, 
  c.receiptdate AS receipt_receiptdate, 
  c.amount AS receipt_amount, 
  c.collector_objid AS receipt_collector_objid, 
  c.collector_name AS receipt_collector_name, 
  c.remittanceid AS remittanceid, 
  rem.objid AS remittance_objid, 
  rem.controlno AS remittance_controlno, 
  rem.controldate AS remittance_controldate 
from cashreceiptpayment_noncash nc 
  inner join cashreceipt c on c.objid = nc.receiptid 
  left join cashreceipt_void v on v.receiptid = c.objid 
  left join remittance rem on rem.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashreceiptpayment_noncash_liquidated', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceiptpayment_noncash_liquidated; 
go
CREATE VIEW vw_cashreceiptpayment_noncash_liquidated AS 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.amount AS amount, 
  nc.particulars AS particulars, 
  nc.account_objid AS account_objid, 
  nc.account_code AS account_code, 
  nc.account_name AS account_name, 
  nc.account_fund_objid AS account_fund_objid, 
  nc.account_fund_name AS account_fund_name, 
  nc.account_bank AS account_bank, 
  nc.fund_objid AS fund_objid, 
  nc.refid AS refid, 
  nc.checkid AS checkid, 
  nc.voidamount AS voidamount, 
  v.objid AS void_objid, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  c.receiptno AS receipt_receiptno, 
  c.receiptdate AS receipt_receiptdate, 
  c.amount AS receipt_amount, 
  c.collector_objid AS receipt_collector_objid, 
  c.collector_name AS receipt_collector_name, 
  c.remittanceid AS remittanceid, 
  r.objid AS remittance_objid, 
  r.controlno AS remittance_controlno, 
  r.controldate AS remittance_controldate, 
  r.collectionvoucherid AS collectionvoucherid, 
  cv.objid AS collectionvoucher_objid, 
  cv.controlno AS collectionvoucher_controlno, 
  cv.controldate AS collectionvoucher_controldate, 
  cv.depositvoucherid AS depositvoucherid 
from collectionvoucher cv 
  inner join remittance r on r.collectionvoucherid = cv.objid 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on nc.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid
go 


if object_id('dbo.vw_collectiongroup', 'V') IS NOT NULL 
  drop view dbo.vw_collectiongroup; 
go
CREATE VIEW vw_collectiongroup AS 
select  
  cg.objid AS objid, 
  cg.name AS name, 
  cg.sharing AS sharing, 
  NULL AS orgid 
from collectiongroup cg 
  left join collectiongroup_org co on co.collectiongroupid = cg.objid 
where cg.state = 'ACTIVE' 
  and co.objid is null 
union 
select  
  cg.objid AS objid, 
  cg.name AS name, 
  cg.sharing AS sharing, 
  co.org_objid AS orgid 
from collectiongroup cg 
  inner join collectiongroup_org co on co.collectiongroupid = cg.objid 
where cg.state = 'ACTIVE'
go 


if object_id('dbo.vw_collectiontype', 'V') IS NOT NULL 
  drop view dbo.vw_collectiontype; 
go
CREATE VIEW vw_collectiontype AS 
select  
  c.objid AS objid, 
  c.state AS state, 
  c.name AS name, 
  c.title AS title, 
  c.formno AS formno, 
  c.handler AS handler, 
  c.allowbatch AS allowbatch, 
  c.barcodekey AS barcodekey, 
  c.allowonline AS allowonline, 
  c.allowoffline AS allowoffline, 
  c.sortorder AS sortorder, 
  o.org_objid AS orgid, 
  c.fund_objid AS fund_objid, 
  c.fund_title AS fund_title, 
  c.category AS category, 
  c.queuesection AS queuesection, 
  c.system AS system, 
  af.formtype AS af_formtype, 
  af.serieslength AS af_serieslength, 
  af.denomination AS af_denomination, 
  af.baseunit AS af_baseunit, 
  c.allowpaymentorder AS allowpaymentorder, 
  c.allowkiosk AS allowkiosk, 
  c.allowcreditmemo AS allowcreditmemo 
from collectiontype_org o 
  inner join collectiontype c on c.objid = o.collectiontypeid 
  inner join af on af.objid = c.formno 
where c.state = 'ACTIVE' 
union 
select  
  c.objid AS objid, 
  c.state AS state, 
  c.name AS name, 
  c.title AS title, 
  c.formno AS formno, 
  c.handler AS handler, 
  c.allowbatch AS allowbatch, 
  c.barcodekey AS barcodekey, 
  c.allowonline AS allowonline, 
  c.allowoffline AS allowoffline, 
  c.sortorder AS sortorder,NULL AS orgid, 
  c.fund_objid AS fund_objid, 
  c.fund_title AS fund_title, 
  c.category AS category, 
  c.queuesection AS queuesection, 
  c.system AS system, 
  af.formtype AS af_formtype, 
  af.serieslength AS af_serieslength, 
  af.denomination AS af_denomination, 
  af.baseunit AS af_baseunit, 
  c.allowpaymentorder AS allowpaymentorder, 
  c.allowkiosk AS allowkiosk, 
  c.allowcreditmemo AS allowcreditmemo 
from collectiontype c 
  inner join af on af.objid = c.formno 
  left join collectiontype_org o on c.objid = o.collectiontypeid 
where c.state = 'ACTIVE' 
  and o.objid is null 
go 



if object_id('dbo.vw_collectiontype_account', 'V') IS NOT NULL 
  drop view dbo.vw_collectiontype_account; 
go
CREATE VIEW vw_collectiontype_account AS 
select  
  ia.objid AS objid, 
  ia.code AS code, 
  ia.title AS title, 
  ia.fund_objid AS fund_objid, 
  fund.code AS fund_code, 
  fund.title AS fund_title, 
  cta.collectiontypeid AS collectiontypeid, 
  cta.tag AS tag, 
  cta.valuetype AS valuetype, 
  cta.defaultvalue AS defaultvalue 
from collectiontype_account cta 
  inner join itemaccount ia on ia.objid = cta.account_objid 
  inner join fund on fund.objid = ia.fund_objid 
go 


if object_id('dbo.vw_remittance_cashreceipt', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceipt; 
go
CREATE VIEW vw_remittance_cashreceipt AS 
select  
  r.objid AS remittance_objid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.controlid AS controlid, 
  af.formtype AS formtype, 
  (case when af.formtype = 'serial' then 0 else 1 end) AS formtypeindexno, 
  c.formno AS formno, 
  c.stub AS stubno, 
  c.series AS series, 
  c.receiptno AS receiptno, 
  c.receiptdate AS receiptdate, 
  c.amount AS amount, 
  c.totalnoncash AS totalnoncash,
  (c.amount - c.totalnoncash) AS totalcash,
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0 else c.amount end) AS voidamount, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.payer_objid AS payer_objid, 
  c.payer_name AS payer_name, 
  c.collector_objid AS collector_objid, 
  c.collector_name AS collector_name, 
  c.collector_title AS collector_title, 
  c.objid AS receiptid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.org_objid AS org_objid 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join af on af.objid = c.formno 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 



if object_id('dbo.vw_remittance_cashreceipt_af', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceipt_af; 
go
CREATE VIEW vw_remittance_cashreceipt_af AS 
select  
  cr.remittanceid AS remittanceid, 
  cr.collector_objid AS collector_objid, 
  cr.controlid AS controlid,
  min(cr.receiptno) AS fromreceiptno,
  max(cr.receiptno) AS toreceiptno,
  min(cr.series) AS fromseries,
  max(cr.series) AS toseries,
  count(cr.objid) AS qty,
  sum(cr.amount) AS amount, 0 AS qtyvoided, 
  0.0 AS voidamt,0 AS qtycancelled, 0.0 AS cancelledamt, 
  af.formtype AS formtype, 
  af.serieslength AS serieslength, 
  af.denomination AS denomination, 
  cr.formno AS formno, 
  afc.stubno AS stubno, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix 
from cashreceipt cr join remittance rem on rem.objid = cr.remittanceid 
  inner join af_control afc on cr.controlid = afc.objid 
  inner join af on afc.afid = af.objid 
group by 
  cr.remittanceid,cr.collector_objid,cr.controlid,af.formtype,
  af.serieslength,af.denomination,cr.formno,afc.stubno,
  afc.startseries,afc.endseries,afc.prefix,afc.suffix 
union all 
select  
  cr.remittanceid AS remittanceid, 
  cr.collector_objid AS collector_objid, 
  cr.controlid AS controlid, 
  NULL AS fromreceiptno, NULL AS toreceiptno, 
  NULL AS fromseries, NULL AS toseries, 
  0 AS qty, 0.0 AS amount, 
  count(cr.objid) AS qtyvoided, 
  sum(cr.amount) AS voidamt, 
  0 AS qtycancelled, 
  0.0 AS cancelledamt, 
  af.formtype AS formtype, 
  af.serieslength AS serieslength, 
  af.denomination AS denomination, 
  cr.formno AS formno, 
  afc.stubno AS stubno, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix 
from cashreceipt cr 
  inner join cashreceipt_void cv on cv.receiptid = cr.objid 
  inner join remittance rem on rem.objid = cr.remittanceid 
  inner join af_control afc on cr.controlid = afc.objid 
  inner join af on afc.afid = af.objid 
group by 
  cr.remittanceid,cr.collector_objid,cr.controlid,af.formtype,
  af.serieslength,af.denomination,cr.formno,afc.stubno,
  afc.startseries,afc.endseries,afc.prefix,afc.suffix 
union all 
select  
  cr.remittanceid AS remittanceid, 
  cr.collector_objid AS collector_objid, 
  cr.controlid AS controlid,
  NULL AS fromreceiptno, NULL AS toreceiptno, 
  NULL AS fromseries, NULL AS toseries, 
  0 AS qty, 0.0 AS amount, 0 AS qtyvoided, 
  0.0 AS voidamt, count(cr.objid) AS qtycancelled, 
  sum(cr.amount) AS cancelledamt, 
  af.formtype AS formtype, 
  af.serieslength AS serieslength, 
  af.denomination AS denomination, 
  cr.formno AS formno, 
  afc.stubno AS stubno, 
  afc.startseries AS startseries, 
  afc.endseries AS endseries, 
  afc.prefix AS prefix, 
  afc.suffix AS suffix 
from cashreceipt cr 
  inner join remittance rem on rem.objid = cr.remittanceid 
  inner join af_control afc on cr.controlid = afc.objid 
  inner join af on afc.afid = af.objid 
where cr.state = 'CANCELLED' 
group by 
  cr.remittanceid,cr.collector_objid,cr.controlid,af.formtype,
  af.serieslength,af.denomination,cr.formno,afc.stubno,
  afc.startseries,afc.endseries,afc.prefix,afc.suffix
go 


if object_id('dbo.vw_remittance_cashreceipt_afsummary', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceipt_afsummary; 
go
CREATE VIEW vw_remittance_cashreceipt_afsummary AS 
select 
  (v.remittanceid +'|'+ v.collector_objid +'|'+ v.controlid) AS objid, 
  v.remittanceid AS remittanceid, 
  v.collector_objid AS collector_objid, 
  v.controlid AS controlid, 
  min(v.fromreceiptno) AS fromreceiptno, max(v.toreceiptno) AS toreceiptno, 
  min(v.fromseries) AS fromseries, max(v.toseries) AS toseries, 
  sum(v.qty) AS qty, sum(v.amount) AS amount, 
  sum(v.qtyvoided) AS qtyvoided, sum(v.voidamt) AS voidamt, 
  sum(v.qtycancelled) AS qtycancelled, sum(v.cancelledamt) AS cancelledamt, 
  v.formtype AS formtype, 
  v.serieslength AS serieslength, 
  v.denomination AS denomination, 
  v.formno AS formno, 
  v.stubno AS stubno, 
  v.startseries AS startseries, 
  v.endseries AS endseries, 
  v.prefix AS prefix, 
  v.suffix AS suffix 
from vw_remittance_cashreceipt_af v 
group by 
  v.remittanceid,v.collector_objid,v.controlid,v.formtype,
  v.serieslength,v.denomination,v.formno,v.stubno,
  v.startseries,v.endseries,v.prefix,v.suffix
go 


if object_id('dbo.vw_remittance_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptitem; 
go
CREATE VIEW vw_remittance_cashreceiptitem AS 
select  
  c.remittanceid AS remittanceid, 
  r.controldate AS remittance_controldate, 
  r.controlno AS remittance_controlno, 
  r.collectionvoucherid AS collectionvoucherid, 
  c.collectiontype_objid AS collectiontype_objid, 
  c.collectiontype_name AS collectiontype_name, 
  c.org_objid AS org_objid, 
  c.org_name AS org_name, 
  c.formtype AS formtype, 
  c.formno AS formno, 
  (case when c.formtype = 'serial' then 0 else 1 end) AS formtypeindex, 
  cri.receiptid AS receiptid, 
  c.receiptdate AS receiptdate, 
  c.receiptno AS receiptno, 
  c.paidby AS paidby, 
  c.paidbyaddress AS paidbyaddress, 
  c.collector_objid AS collectorid, 
  c.collector_name AS collectorname, 
  c.collector_title AS collectortitle, 
  cri.item_fund_objid AS fundid, 
  cri.item_objid AS acctid, 
  cri.item_code AS acctcode, 
  cri.item_title AS acctname, 
  cri.remarks AS remarks, 
  (case when v.objid is null then cri.amount else 0.0 end) AS amount,
  (case when v.objid is null then 0 else 1 end) AS voided,
  (case when v.objid is null then 0.0 else cri.amount end) AS voidamount 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptitem cri on cri.receiptid = c.objid 
  left join cashreceipt_void v on v.receiptid = c.objid
go 


if object_id('dbo.vw_remittance_cashreceiptpayment_noncash', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptpayment_noncash; 
go
CREATE VIEW vw_remittance_cashreceiptpayment_noncash AS 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate, 
  nc.reftype AS reftype, 
  nc.particulars AS particulars, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  cp.bankid AS bankid, 
  cp.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'CHECK') 
  inner join checkpayment cp on cp.objid = nc.refid 
  left join cashreceipt_void v on v.receiptid = c.objid 
union all 
select  
  nc.objid AS objid, 
  nc.receiptid AS receiptid, 
  nc.refno AS refno, 
  nc.refdate AS refdate,'EFT' AS reftype, 
  nc.particulars AS particulars, 
  nc.refid AS refid, 
  nc.amount AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else nc.amount end) AS voidamount, 
  ba.bank_objid AS bankid, 
  ba.bank_name AS bank_name, 
  c.remittanceid AS remittanceid, 
  r.collectionvoucherid AS collectionvoucherid 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceiptpayment_noncash nc on (nc.receiptid = c.objid and nc.reftype = 'EFT') 
  inner join eftpayment eft on eft.objid = nc.refid 
  inner join bankaccount ba on ba.objid = eft.bankacctid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_remittance_cashreceiptshare', 'V') IS NOT NULL 
  drop view dbo.vw_remittance_cashreceiptshare; 
go
CREATE VIEW vw_remittance_cashreceiptshare AS 
select 
  c.remittanceid AS remittanceid,
  r.controldate AS remittance_controldate,
  r.controlno AS remittance_controlno,
  r.collectionvoucherid AS collectionvoucherid,
  c.formno AS formno,
  c.formtype AS formtype,
  cs.receiptid AS receiptid,
  c.receiptdate AS receiptdate,
  c.receiptno AS receiptno,
  c.paidby AS paidby,
  c.paidbyaddress AS paidbyaddress,
  c.org_objid AS org_objid,
  c.org_name AS org_name,
  c.collectiontype_objid AS collectiontype_objid,
  c.collectiontype_name AS collectiontype_name,
  c.collector_objid AS collectorid,
  c.collector_name AS collectorname,
  c.collector_title AS collectortitle,
  cs.refitem_objid AS refacctid,
  ia.fund_objid AS fundid,
  ia.objid AS acctid,
  ia.code AS acctcode,
  ia.title AS acctname,
  (case when v.objid is null then cs.amount else 0.0 end) AS amount, 
  (case when v.objid is null then 0 else 1 end) AS voided, 
  (case when v.objid is null then 0.0 else cs.amount end) AS voidamount 
from remittance r 
  inner join cashreceipt c on c.remittanceid = r.objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid 
  left join cashreceipt_void v on v.receiptid = c.objid 
go 


if object_id('dbo.vw_collectionvoucher_cashreceiptitem', 'V') IS NOT NULL 
  drop view dbo.vw_collectionvoucher_cashreceiptitem; 
go
CREATE VIEW vw_collectionvoucher_cashreceiptitem AS 
select  
  cv.controldate AS collectionvoucher_controldate, 
  cv.controlno AS collectionvoucher_controlno, 
  v.remittanceid AS remittanceid, 
  v.remittance_controldate AS remittance_controldate, 
  v.remittance_controlno AS remittance_controlno, 
  v.collectionvoucherid AS collectionvoucherid, 
  v.collectiontype_objid AS collectiontype_objid, 
  v.collectiontype_name AS collectiontype_name, 
  v.org_objid AS org_objid, 
  v.org_name AS org_name, 
  v.formtype AS formtype, 
  v.formno AS formno, 
  v.formtypeindex AS formtypeindex, 
  v.receiptid AS receiptid, 
  v.receiptdate AS receiptdate, 
  v.receiptno AS receiptno, 
  v.paidby AS paidby, 
  v.paidbyaddress AS paidbyaddress, 
  v.collectorid AS collectorid, 
  v.collectorname AS collectorname, 
  v.collectortitle AS collectortitle, 
  v.fundid AS fundid, 
  v.acctid AS acctid, 
  v.acctcode AS acctcode, 
  v.acctname AS acctname, 
  v.amount AS amount, 
  v.voided AS voided, 
  v.voidamount AS voidamount 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptitem v on v.collectionvoucherid = cv.objid 
go 


if object_id('dbo.vw_collectionvoucher_cashreceiptshare', 'V') IS NOT NULL 
  drop view dbo.vw_collectionvoucher_cashreceiptshare; 
go
CREATE VIEW vw_collectionvoucher_cashreceiptshare AS 
select 
  cv.controldate AS collectionvoucher_controldate,
  cv.controlno AS collectionvoucher_controlno,
  v.remittanceid AS remittanceid,
  v.remittance_controldate AS remittance_controldate,
  v.remittance_controlno AS remittance_controlno,
  v.collectionvoucherid AS collectionvoucherid,
  v.formno AS formno,
  v.formtype AS formtype,
  v.receiptid AS receiptid,
  v.receiptdate AS receiptdate,
  v.receiptno AS receiptno,
  v.paidby AS paidby,
  v.paidbyaddress AS paidbyaddress,
  v.org_objid AS org_objid,
  v.org_name AS org_name,
  v.collectiontype_objid AS collectiontype_objid,
  v.collectiontype_name AS collectiontype_name,
  v.collectorid AS collectorid,
  v.collectorname AS collectorname,
  v.collectortitle AS collectortitle,
  v.refacctid AS refacctid,
  v.fundid AS fundid,
  v.acctid AS acctid,
  v.acctcode AS acctcode,
  v.acctname AS acctname,
  v.amount AS amount,
  v.voided AS voided,
  v.voidamount AS voidamount 
from collectionvoucher cv 
  inner join vw_remittance_cashreceiptshare v on v.collectionvoucherid = cv.objid 
go 


if object_id('dbo.vw_deposit_fund_transfer', 'V') IS NOT NULL 
  drop view dbo.vw_deposit_fund_transfer; 
go
CREATE VIEW vw_deposit_fund_transfer AS 
select  
  dft.objid AS objid, 
  dft.amount AS amount, 
  dft.todepositvoucherfundid AS todepositvoucherfundid, 
  tof.objid AS todepositvoucherfund_fund_objid, 
  tof.code AS todepositvoucherfund_fund_code, 
  tof.title AS todepositvoucherfund_fund_title, 
  dft.fromdepositvoucherfundid AS fromdepositvoucherfundid, 
  fromf.objid AS fromdepositvoucherfund_fund_objid, 
  fromf.code AS fromdepositvoucherfund_fund_code, 
  fromf.title AS fromdepositvoucherfund_fund_title 
from deposit_fund_transfer dft 
  inner join depositvoucher_fund todv on dft.todepositvoucherfundid = todv.objid 
  inner join fund tof on todv.fundid = tof.objid 
  inner join depositvoucher_fund fromdv on dft.fromdepositvoucherfundid = fromdv.objid 
  inner join fund fromf on fromdv.fundid = fromf.objid 
go  


if object_id('dbo.vw_entityindividual', 'V') IS NOT NULL 
  drop view dbo.vw_entityindividual; 
go
CREATE VIEW vw_entityindividual AS 
select  
  ei.objid AS objid, 
  ei.lastname AS lastname, 
  ei.firstname AS firstname, 
  ei.middlename AS middlename, 
  ei.birthdate AS birthdate, 
  ei.birthplace AS birthplace, 
  ei.citizenship AS citizenship, 
  ei.gender AS gender, 
  ei.civilstatus AS civilstatus, 
  ei.profession AS profession, 
  ei.tin AS tin, 
  ei.sss AS sss, 
  ei.height AS height, 
  ei.weight AS weight, 
  ei.acr AS acr, 
  ei.religion AS religion, 
  ei.photo AS photo, 
  ei.thumbnail AS thumbnail, 
  ei.profileid AS profileid, 
  e.entityno AS entityno, 
  e.type AS type, 
  e.name AS name, 
  e.entityname AS entityname, 
  e.mobileno AS mobileno, 
  e.phoneno AS phoneno, 
  e.address_objid AS address_objid, 
  e.address_text AS address_text 
from entityindividual ei 
  inner join entity e on e.objid = ei.objid 
go 


if object_id('dbo.vw_entity_relation', 'V') IS NOT NULL 
  drop view dbo.vw_entity_relation; 
go
CREATE VIEW vw_entity_relation AS 
select  
  er.objid AS objid, 
  er.entity_objid AS ownerid, 
  ei.objid AS entityid, 
  ei.entityno AS entityno, 
  ei.name AS name, 
  ei.firstname AS firstname, 
  ei.lastname AS lastname, 
  ei.middlename AS middlename, 
  ei.birthdate AS birthdate, 
  ei.gender AS gender, 
  er.relation_objid AS relationship 
from entity_relation er 
  inner join vw_entityindividual ei on er.relateto_objid = ei.objid 
union all 
select  
  er.objid AS objid, 
  er.relateto_objid AS ownerid, 
  ei.objid AS entityid, 
  ei.entityno AS entityno, 
  ei.name AS name, 
  ei.firstname AS firstname, 
  ei.lastname AS lastname, 
  ei.middlename AS middlename, 
  ei.birthdate AS birthdate, 
  ei.gender AS gender, 
  (case 
    when ei.gender = 'M' then et.inverse_male 
    when ei.gender = 'F' then et.inverse_female 
    else et.inverse_any 
  end) AS relationship 
from entity_relation er 
  inner join vw_entityindividual ei on er.entity_objid = ei.objid 
  inner join entity_relation_type et on er.relation_objid = et.objid
go 



if object_id('dbo.vw_entityindividual_lookup', 'V') IS NOT NULL 
  drop view dbo.vw_entityindividual_lookup; 
go
CREATE VIEW vw_entityindividual_lookup AS 
select  
  e.objid AS objid, 
  e.entityno AS entityno, 
  e.name AS name, 
  e.address_text AS addresstext, 
  e.type AS type, 
  ei.lastname AS lastname, 
  ei.firstname AS firstname, 
  ei.middlename AS middlename, 
  ei.gender AS gender, 
  ei.birthdate AS birthdate, 
  e.mobileno AS mobileno, 
  e.phoneno AS phoneno 
from entity e 
  inner join entityindividual ei on ei.objid = e.objid 
go 


if object_id('dbo.vw_entityrelation_lookup', 'V') IS NOT NULL 
  drop view dbo.vw_entityrelation_lookup; 
go
CREATE VIEW vw_entityrelation_lookup AS 
select  
  er.objid AS objid, 
  er.entity_objid AS entity_objid, 
  er.relateto_objid AS relateto_objid, 
  er.relation_objid AS relation_objid, 
  e.entityno AS entityno, 
  e.name AS name, 
  e.address_text AS addresstext, 
  e.type AS type, 
  ei.lastname AS lastname, 
  ei.firstname AS firstname, 
  ei.middlename AS middlename, 
  ei.gender AS gender, 
  ei.birthdate AS birthdate, 
  e.mobileno AS mobileno, 
  e.phoneno AS phoneno 
from entity_relation er 
  inner join entityindividual ei on ei.objid = er.relateto_objid 
  inner join entity e on e.objid = ei.objid 
go 


if object_id('dbo.vw_income_ledger', 'V') IS NOT NULL 
  drop view dbo.vw_income_ledger; 
go
CREATE VIEW vw_income_ledger AS 
select  
  year(jev.jevdate) AS year, 
  month(jev.jevdate) AS  month,
  jev.fundid AS  fundid,
  l.itemacctid AS  itemacctid,
  l.cr AS  amount, 
  l.jevid AS  jevid,
  l.objid AS objid 
from income_ledger l 
  inner join jev on jev.objid = l.jevid 
union all 
select  
  year(jev.jevdate) AS year, 
  month(jev.jevdate) AS month, 
  jev.fundid AS fundid, 
  l.refitemacctid AS itemacctid, 
  (l.cr - l.dr) AS amount, 
  l.jevid AS  jevid, 
  l.objid AS objid 
from payable_ledger l 
  inner join jev on jev.objid = l.jevid 
go 



if object_id('dbo.vw_account_item_mapping', 'V') IS NOT NULL 
  drop view dbo.vw_account_item_mapping; 
go
CREATE VIEW vw_account_item_mapping AS 
select  
  a.objid AS objid, 
  a.maingroupid AS maingroupid, 
  a.code AS code, 
  a.title AS title, 
  a.groupid AS groupid, 
  a.type AS type, 
  a.leftindex AS leftindex, 
  a.rightindex AS rightindex, 
  a.level AS level, 
  l.amount AS amount, 
  l.fundid AS fundid, 
  l.year AS year, 
  l.month AS month, 
  aim.itemid AS itemid, 
  ia.code AS itemcode, 
  ia.title AS itemtitle 
from account_item_mapping aim 
  inner join account a on a.objid = aim.acctid 
  inner join itemaccount ia on ia.objid = aim.itemid 
  inner join vw_income_ledger l on l.itemacctid = aim.itemid 
go 


if object_id('dbo.vw_account_income_summary', 'V') IS NOT NULL 
  drop view dbo.vw_account_income_summary; 
go
CREATE VIEW vw_account_income_summary AS 
select  
  a.objid AS objid, 
  a.maingroupid AS maingroupid, 
  a.code AS code, 
  a.title AS title, 
  a.groupid AS groupid, 
  a.type AS type, 
  a.leftindex AS leftindex, 
  a.rightindex AS rightindex, 
  a.level AS level, 
  inc.amount AS amount, 
  inc.acctid AS acctid, 
  inc.fundid AS fundid, 
  inc.collectorid AS collectorid, 
  inc.refdate AS refdate, 
  inc.remittancedate AS remittancedate, 
  inc.liquidationdate AS liquidationdate, 
  ia.type AS accttype 
from account_item_mapping aim 
  inner join account a on a.objid = aim.acctid 
  inner join itemaccount ia on ia.objid = aim.itemid 
  inner join income_summary inc on inc.acctid = ia.objid 
go 


if object_id('dbo.vw_cashreceipt_itemaccount_collectiongroup', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount_collectiongroup; 
go 
CREATE VIEW vw_cashreceipt_itemaccount_collectiongroup AS 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title,
  (case when ca.defaultvalue = 0 then ia.defaultvalue else ca.defaultvalue end) AS defaultvalue,
  (case when ca.defaultvalue = 0 then ia.valuetype else ca.valuetype end) AS valuetype, 
  ca.sortorder AS sortorder, 
  ia.org_objid AS orgid, 
  ca.collectiongroupid AS collectiongroupid, 
  ia.generic AS generic 
from collectiongroup_account ca 
  inner join itemaccount ia on ia.objid = ca.account_objid 
go 


if object_id('dbo.vw_cashbook_cashreceipt', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt; 
go
CREATE VIEW vw_cashbook_cashreceipt AS select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno,'cashreceipt' AS reftype,
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ci.item_fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  ci.amount AS dr,0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid 
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid
  inner join cashreceiptitem ci on ci.receiptid = c.objid
go 


if object_id('dbo.vw_cashbook_cashreceipt_share', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceipt_share; 
go
CREATE VIEW vw_cashbook_cashreceipt_share AS 
select  
  c.objid AS objid, 
  c.txndate AS txndate,
  cast(c.receiptdate as date) AS refdate, 
  c.objid AS refid, 
  c.receiptno AS refno,'cashreceipt' AS reftype,
  (ct.name +' ('+ c.paidby +')') AS particulars, 
  ia.fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  cs.amount AS dr,0.0 AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  c.txndate AS sortdate, 
  c.receiptdate AS receiptdate, 
  c.objid AS receiptid, 
  cs.refitem_objid AS refitemid 
from cashreceipt c 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  inner join cashreceipt_share cs on cs.receiptid = c.objid 
  inner join itemaccount ia on ia.objid = cs.payableitem_objid 
go 


if object_id('dbo.vw_cashbook_cashreceiptvoid', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_cashreceiptvoid; 
go
CREATE VIEW vw_cashbook_cashreceiptvoid AS 
select  
  v.objid AS objid, 
  v.txndate AS txndate,
  cast(v.txndate as date) AS refdate, 
  v.objid AS refid, 
  c.receiptno AS refno, 
  'cashreceipt:void' AS reftype,
  ('VOID '+ v.reason) AS particulars, 
  ci.item_fund_objid AS fundid, 
  c.collector_objid AS collectorid, 
  (ci.amount * -(1.0)) AS dr,
  (case 
    when r.liquidatingofficer_objid is null then 0.0 
    when v.txndate >= r.dtposted and cast(v.txndate as date) >= cast(r.controldate as date) then (ci.amount * -(1.0)) 
    else 0.0 
  end) AS cr, 
  c.formno AS formno, 
  c.formtype AS formtype, 
  c.series AS series, 
  c.controlid AS controlid, 
  v.txndate AS sortdate 
from cashreceipt_void v 
  inner join cashreceipt c on c.objid = v.receiptid 
  inner join cashreceiptitem ci on ci.receiptid = c.objid 
  inner join collectiontype ct on ct.objid = c.collectiontype_objid 
  left join remittance r on r.objid = c.remittanceid 
go 


if object_id('dbo.vw_cashbook_remittance', 'V') IS NOT NULL 
  drop view dbo.vw_cashbook_remittance; 
go
CREATE VIEW vw_cashbook_remittance AS 
select  
  rem.objid AS objid, 
  rem.dtposted AS txndate, 
  rem.controldate AS refdate, 
  rem.objid AS refid, 
  rem.controlno AS refno, 
  'remittance' AS reftype, 
  'REMITTANCE' AS particulars, 
  remf.fund_objid AS fundid, 
  rem.collector_objid AS collectorid, 
  0.0 AS dr, 
  remf.amount AS cr, 
  'remittance' AS formno,
  'remittance' AS formtype,
  NULL AS series,
  NULL AS controlid, 
  rem.dtposted AS sortdate 
from remittance rem 
  inner join remittance_fund remf on remf.remittanceid = rem.objid 
go 


if object_id('dbo.vw_cashreceipt_itemaccount_collectiongroup', 'V') IS NOT NULL 
  drop view dbo.vw_cashreceipt_itemaccount_collectiongroup; 
go 
CREATE VIEW vw_cashreceipt_itemaccount_collectiongroup AS 
select  
  ia.objid AS objid, 
  ia.state AS state, 
  ia.code AS code, 
  ia.title AS title, 
  ia.description AS description, 
  ia.type AS type, 
  ia.fund_objid AS fund_objid, 
  ia.fund_code AS fund_code, 
  ia.fund_title AS fund_title,
  (case when ca.defaultvalue = 0 then ia.defaultvalue else ca.defaultvalue end) AS defaultvalue,
  (case when ca.defaultvalue = 0 then ia.valuetype else ca.valuetype end) AS valuetype, 
  ca.sortorder AS sortorder, 
  ia.org_objid AS orgid, 
  ca.collectiongroupid AS collectiongroupid, 
  ia.generic AS generic 
from collectiongroup_account ca 
  inner join itemaccount ia on ia.objid = ca.account_objid 
go 

