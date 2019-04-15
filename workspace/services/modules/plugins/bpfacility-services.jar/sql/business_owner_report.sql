[getUnpaidApplications]


SELECT applicationid as objid,
		businessid,
		sum(amount-amtpaid) as balance
from business_receivable
where businessid=$P{objid}
group by businessid,applicationid
having 
	sum(amount-amtpaid) > 0
	
