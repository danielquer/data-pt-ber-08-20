# Create Tables

create table publications.store_sales_summary as (
select
	st.stor_name as StoreName,
	count(distinct sa.ord_num) as OrderCount,
	count(distinct sa.title_id) as TitleCount,
	sum(sa.qty) as QuantitySold
from
	stores as st
left join
	sales as sa using (stor_id)
group by 1
);

select
	*,
	truncate(TitleCount/OrderCount,2) as AvgItemsPerOrder,
	truncate(QuantitySold/TitleCount,2) as AvgQtyPerItem
from
	publications.store_sales_summary;


# Drop rows by condition

delete from publications.store_sales_summary 
where QuantitySold < 100;

# Delete all rows

delete from publications.store_sales_summary;

select * from publications.store_sales_summary;

# Delete the whole table

drop table publications.store_sales_summary;

# Delete a column from table

alter table publications.store_sales_summary
drop column QuantitySold;

select * from publications.store_sales_summary;

# Insert rows into table
insert into publications.store_sales_summary
select
	st.stor_name as StoreName,
	count(distinct sa.ord_num) as OrderCount,
	count(distinct sa.title_id) as TitleCount,
	sum(sa.qty) as QuantitySold
from
	stores as st
left join
	sales as sa using (stor_id)
group by 1
;

# Updating data in the table
update publications.store_sales_summary
set QuantitySold = QuantitySold * 2;

select * from publications.store_sales_summary;
