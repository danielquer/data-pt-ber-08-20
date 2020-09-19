## LAB 2.1 INTRO TO SQL
# 1. From the order_items table, find the price of the highest priced order item and lowest price order item.
select max(price), min(price) from order_items;

# 2. From the order_items table, what is range of the shipping_limit_date of the orders?

select min(shipping_limit_date), max(shipping_limit_date) from order_items;

# 3. From the customers table, find the 3 states with the greatest number of customers.

select
	customer_state,
	count(customer_id)
from
	customers
group by 1
order by 2 desc
limit 3;
## 4. From the customers table, within the state with the greatest number of customers, find the 3 cities with the greatest number of customers.

with top_state as (
	select
		customer_state,
		count(customer_id)
	from
		customers
	group by 1
	order by 2 desc
	limit 1
)

select
	customer_city,
	count(customer_id)
from
	customers as cs
join
	top_state as ts on ts.customer_state = cs.customer_state
group by 1
order by 2 desc
limit 3;

# 5. From the closed_deals table, how many distinct business segments are there (not including null)?

select 
	count(distinct business_segment)
from
	closed_deals;

# 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).

with duplicate_business_segments as (
	select
		business_segment,
		count(*) as row_values
	from
		closed_deals
	group by 1
	having
		row_values > 1
)

select
	cd.business_segment,
	sum(declared_monthly_revenue)
from
	closed_deals as cd
join
	duplicate_business_segments as dps using (business_segment)
group by 1
order by 2 desc
limit 3;

# 7. From the order_reviews table, find the total number of distinct review score values.

select
	count(distinct review_score)
from
	order_reviews;

# 8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5.

alter table order_reviews
add score_description as str;
select
	*
from
	order_reviews
limit 1000;
# 9. From the order_reviews table, find the review score occurring most frequently and how many times it occurs.

select
	review_score,
	count(review_id)
from
	order_reviews
group by 1
order by 2 desc
limit 1;