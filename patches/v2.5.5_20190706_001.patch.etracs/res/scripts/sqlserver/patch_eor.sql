
CREATE DATABASE eor 
go 

USE eor 
go 

CREATE TABLE eor (
  objid varchar(50) NOT NULL,
  receiptno varchar(50) NULL,
  receiptdate date NULL,
  txndate datetime NULL,
  state varchar(10) NULL,
  partnerid varchar(50) NULL,
  txntype varchar(20) NULL,
  traceid varchar(50) NULL,
  tracedate datetime NULL,
  refid varchar(50) NULL,
  paidby varchar(255) NULL,
  paidbyaddress varchar(255) NULL,
  payer_objid varchar(50) NULL,
  paymethod varchar(20) NULL,
  paymentrefid varchar(50) NULL,
  remittanceid varchar(50) NULL,
  remarks varchar(255) NULL,
  amount decimal(16,4) NULL,
  constraint pk_eor PRIMARY KEY (objid)
) 
go 

create UNIQUE index uix_eor_receiptno on eor (receiptno) 
go 
create index ix_receiptdate on eor (receiptdate) 
create index ix_txndate on eor (txndate) 
create index ix_partnerid on eor (partnerid) 
create index ix_traceid on eor (traceid) 
create index ix_refid on eor (refid) 
create index ix_paidby on eor (paidby) 
create index ix_payer_objid on eor (payer_objid) 
create index ix_paymentrefid on eor (paymentrefid) 
create index ix_remittanceid on eor (remittanceid)
go  


CREATE TABLE eor_item (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NULL,
  item_objid varchar(50) NULL,
  item_code varchar(100) NULL,
  item_title varchar(100) NULL,
  amount decimal(16,4) NULL,
  remarks varchar(255) NULL,
  item_fund_objid varchar(50) NULL,
  constraint pk_eor_item PRIMARY KEY (objid) 
)
go 
create index ix_parentid on eor_item (parentid) 
create index ix_item_objid on eor_item (item_objid) 
create index ix_item_fund_objid on eor_item (item_fund_objid) 
go
alter table eor_item add CONSTRAINT fk_eoritem_parentid 
  FOREIGN KEY (parentid) REFERENCES eor (objid) 
go 


CREATE TABLE eor_number (
  objid varchar(255) NOT NULL,
  currentno int NOT NULL DEFAULT '1',
  constraint pk_eor_number PRIMARY KEY (objid)
) 
go 


CREATE TABLE eor_paymentorder (
  objid varchar(50) NOT NULL,
  txndate datetime NULL,
  txntype varchar(50) NULL,
  txntypename varchar(100) NULL,
  payer_objid varchar(50) NULL,
  payer_name varchar(MAX) NULL,
  paidby varchar(MAX) NULL,
  paidbyaddress varchar(150) NULL,
  particulars varchar(500) NULL,
  amount decimal(16,2) NULL,
  expirydate date NULL,
  refid varchar(50) NULL,
  refno varchar(50) NULL,
  info varchar(MAX) NULL,
  origin varchar(100) NULL,
  controlno varchar(50) NULL,
  locationid varchar(25) NULL,
  items varchar(MAX) NULL,
  constraint pk_eor_paymentorder PRIMARY KEY (objid)
) 
go 


CREATE TABLE eor_remittance (
  objid varchar(50) NOT NULL,
  state varchar(50) NULL,
  controlno varchar(50) NULL,
  partnerid varchar(50) NULL,
  controldate date NULL,
  dtcreated datetime NULL,
  createdby_objid varchar(50) NULL,
  createdby_name varchar(255) NULL,
  amount decimal(16,4) NULL,
  dtposted datetime NULL,
  postedby_objid varchar(50) NULL,
  postedby_name varchar(255) NULL,
  constraint pk_eor_remittance PRIMARY KEY (objid)
) 
go 


CREATE TABLE eor_remittance_fund (
  objid varchar(100) NOT NULL,
  remittanceid varchar(50) NULL,
  fund_objid varchar(50) NULL,
  fund_code varchar(50) NULL,
  fund_title varchar(255) NULL,
  amount decimal(16,4) NULL,
  bankaccount_objid varchar(50) NULL,
  bankaccount_title varchar(255) NULL,
  bankaccount_bank_name varchar(255) NULL,
  validation_refno varchar(50) NULL,
  validation_refdate date NULL,
  constraint pk_eor_remittance_fund PRIMARY KEY (objid) 
)
go 
create index ix_remittanceid on eor_remittance_fund (remittanceid) 
go 
alter table eor_remittance_fund add CONSTRAINT fk_eor_remittance_fund_remittanceid 
  FOREIGN KEY (remittanceid) REFERENCES eor_remittance (objid)
go 


CREATE TABLE eor_share (
  objid varchar(50) NOT NULL,
  parentid varchar(50) NOT NULL,
  refitem_objid varchar(50) NULL,
  refitem_code varchar(25) NULL,
  refitem_title varchar(255) NULL,
  payableitem_objid varchar(50) NULL,
  payableitem_code varchar(25) NULL,
  payableitem_title varchar(255) NULL,
  amount decimal(16,4) NULL,
  share decimal(16,2) NULL,
  constraint pk_eor_share PRIMARY KEY (objid)
) 
go 


CREATE TABLE paymentpartner (
  objid varchar(50) NOT NULL,
  code varchar(50) NULL,
  name varchar(100) NULL,
  branch varchar(255) NULL,
  contact varchar(255) NULL,
  mobileno varchar(32) NULL,
  phoneno varchar(32) NULL,
  email varchar(255) NULL,
  indexno varchar(3) NULL,
  constraint pk_paymentpartner PRIMARY KEY (objid)
) 
go 


CREATE TABLE unpostedpayment (
  objid varchar(50) NOT NULL,
  txndate datetime NOT NULL,
  txntype varchar(50) NOT NULL,
  txntypename varchar(150) NOT NULL,
  paymentrefid varchar(50) NOT NULL,
  amount decimal(16,2) NOT NULL,
  orgcode varchar(20) NOT NULL,
  partnerid varchar(50) NOT NULL,
  traceid varchar(100) NOT NULL,
  tracedate datetime NOT NULL,
  refno varchar(50) NULL,
  origin varchar(50) NULL,
  paymentorder varchar(MAX) NULL,
  errmsg varchar(MAX) NOT NULL,
  errdetail varchar(MAX) NULL,
  constraint pk_unpostedpayment PRIMARY KEY (objid) 
) 
GO 
CREATE UNIQUE INDEX ix_paymentrefid ON unpostedpayment (paymentrefid) 
GO 
CREATE INDEX ix_txndate ON unpostedpayment (txndate) 
CREATE INDEX ix_txntype ON unpostedpayment (txntype) 
CREATE INDEX ix_partnerid ON unpostedpayment (partnerid) 
CREATE INDEX ix_traceid ON unpostedpayment (traceid) 
CREATE INDEX ix_tracedate ON unpostedpayment (tracedate) 
CREATE INDEX ix_refno ON unpostedpayment (refno) 
CREATE INDEX ix_origin ON unpostedpayment (origin) 
GO 


INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) 
VALUES ('DBP', 'DBP', 'DEVELOPMENT BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '002');

INSERT INTO paymentpartner (objid, code, name, branch, contact, mobileno, phoneno, email, indexno) 
VALUES ('LBP', 'LBP', 'LAND BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '001');
