# In the publications database, create a query that outputs the name of the store, alongside the number of orders (count of distinct order_id), the count of titles and the sum of the quantity from the sales table

# Temporary Tables

create temporary table publications.store_sales_summary as 

select
	st.stor_name as StoreName,
	count(distinct sa.ord_num) as OrderCount,
	count(distinct sa.title_id) as TitleCount,
	sum(sa.qty) as QuantitySold
from
	stores as st
left join
	sales as sa using (stor_id)
group by 1;

select
	StoreName,
	truncate(TitleCount/OrderCount,2) as AvgItemsPerOrder,
	truncate(QuantitySold/TitleCount,2) as AvgQtyPerItem
from
	publications.store_sales_summary;

# Common Table Expressions
with store_sales_summary as (
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
)

select
	StoreName,
	truncate(TitleCount/OrderCount,2) as AvgItemsPerOrder,
	truncate(QuantitySold/TitleCount,2) as AvgQtyPerItem
from
	store_sales_summary;
	
# Subqueries

select
	StoreName,
	truncate(TitleCount/OrderCount,2) as AvgItemsPerOrder,
	truncate(QuantitySold/TitleCount,2) as AvgQtyPerItem
from
(select
	st.stor_name as StoreName,
	count(distinct sa.ord_num) as OrderCount,
	count(distinct sa.title_id) as TitleCount,
	sum(sa.qty) as QuantitySold
from
	stores as st
left join
	sales as sa using (stor_id)
group by 1) as store_sales_summary;

