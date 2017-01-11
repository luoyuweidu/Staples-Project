create table bsusr_custana.CPC_decile_loss2 as
(select 
i.Class_Id,i.Class_Desc,sum(svl.total_amt) as total_sale
from sales_visit_line svl inner join item i on (svl.item_id=i.item_id)
where
i.Division_Id=6 and
svl.fiscal_yearmo between 201405 and 201504 and 
svl.VISIT_LINE_TYPE_CODE='TRNLIN' and
svl.identifiable_ind='Y' and
svl.BUSINESS_CONSUMER_CODE='B' and
svl.primary_site_id in (select primary_site_id from BSUSR_CUSTANA.LiXi_top_customer)
group by i.Class_Id,i.Class_Desc
) with data 
Primary index (Class_Id);

create table bsusr_custana.CPC_decile_loss3 as
(select 
i.Class_Id,i.Class_Desc,sum(svl.total_amt) as total_sale
from sales_visit_line svl inner join item i on (svl.item_id=i.item_id)
where
i.Division_Id=6 and
svl.fiscal_yearmo between 201505 and 201604 and 
svl.VISIT_LINE_TYPE_CODE='TRNLIN' and
svl.identifiable_ind='Y' and
svl.BUSINESS_CONSUMER_CODE='B' and
svl.primary_site_id in (select primary_site_id from BSUSR_CUSTANA.LiXi_top_customer)
group by i.Class_Id,i.Class_Desc
) with data 
Primary index (Class_Id);

drop table bsusr_custana.CPC_decile_loss3

/*find top 10,000 for 2014-2015*/
select TOP 10000 svl.primary_site_id, sum(total_amt)
from sales_visit_line svl inner join item i on (svl.item_id=i.item_id)
where
i.Division_Id=6 and
svl.fiscal_yearmo between 201405 and 201504 and 
svl.VISIT_LINE_TYPE_CODE='TRNLIN' and
svl.identifiable_ind='Y' and
svl.BUSINESS_CONSUMER_CODE='B'
group by svl.primary_site_id
ORDER BY sum(total_amt) DESC;

select 
i.Class_Id,i.Class_Desc,sum(svl.total_amt) as total_sale
from sales_visit_line svl inner join item i on (svl.item_id=i.item_id)
where
i.Division_Id=6 and
svl.fiscal_yearmo between 201405 and 201504 and 
svl.VISIT_LINE_TYPE_CODE='TRNLIN' and
svl.identifiable_ind='Y' and
svl.BUSINESS_CONSUMER_CODE='B' and
svl.primary_site_id in (select primary_site_id from BSUSR_CUSTANA.LiXi_top_customer_2014)
group by i.Class_Id,i.Class_Desc

create table bsusr_custana.CPC_decile_loss4 as
(select 
i.Class_Id,i.Class_Desc,sum(svl.total_amt) as total_sale
from sales_visit_line svl inner join item i on (svl.item_id=i.item_id)
where
i.Division_Id=6 and
svl.fiscal_yearmo between 201505 and 201604 and 
svl.VISIT_LINE_TYPE_CODE='TRNLIN' and
svl.identifiable_ind='Y' and
svl.BUSINESS_CONSUMER_CODE='B' and
svl.primary_site_id in (select primary_site_id from BSUSR_CUSTANA.LiXi_top_customer_2014)
group by i.Class_Id,i.Class_Desc
) with data 
Primary index (Class_Id);

SELECT * FROM bsusr_custana.CPC_decile_loss4