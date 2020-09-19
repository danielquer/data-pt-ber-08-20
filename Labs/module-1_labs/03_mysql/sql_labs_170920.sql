select
	*
from
	olist.closed_deals
limit 1000;

select distinct
	business_segment
from
	olist.closed_deals
order by 1 asc;

select
	origin,
	count(cd.mql_id)
from
	olist.closed_deals as cd
join
	olist.marketing_qualified_leads as mql on mql.mql_id = cd.mql_id
where
	cd.`business_segment` = 'toys'
group by 1 
;

select
	*
from
	olist.closed_deals as cd
order by lead_type
limit 1000;


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

# LAB 2.2 . INTRO TO SQL

# 1. From the marketing_qualified_leads table, find the earliest and latest first_contact_date.

select
	min(date(first_contact_date)),
	max(date(first_contact_date))
from
	marketing_qualified_leads;
# 2. From the marketing_qualified_leads table, find the top 3 most frequent origin types for all first_contact_date entries in 2018.

select
	origin,
	count(mql_id)
from
	marketing_qualified_leads
where
	year(first_contact_date) = 2018
group by 1
order by 2 desc
limit 3;

# 3. From the marketing_qualified_leads table, find the first_contact_date with the highest number of mql_id entries and state the number of entries on that date.

select
	date(first_contact_date),
	count(mql_id)
from
	marketing_qualified_leads
group by 1
order by 2 desc
limit 1;

# 4. From the products table, find the name and count of the top 2 product category names.

select
	product_category_name,
	count(product_id)
from
	products
group by 1
order by 2 desc
limit 2;

# 5. From the products table, find the product_category_name with the highest recorded product weight in grams.

select
	product_category_name,
	max(product_weight_g)
from
	products
group by 1
order by 2 desc
limit 1;

# 6. From the products table, find the product_category_name with the greatest sum of dimensions including length, height and width in centimeters.

select
	product_category_name,
	max(product_length_cm + product_height_cm + product_width_cm)
from
	products
group by 1
order by 2 desc
limit 1;

# 7. From the order_payments table, find the payment_type with the greatest number of order_id entries and the count of that payment type.

select
	payment_type,
	count(`order_id`)
from
	order_payments
group by 1
order by 2 desc
limit 1;

# 8. From the order_payments table, find the highest payment value for an individual order_id.
select
	max(payment_value)
from
	order_payments;
	
# 9. From the sellers table, find the 3 seller states with the greatest number of distinct seller cities.

select
	seller_state,
	count(distinct seller_city)
from
	sellers
group by 1
order by 2 desc
limit 3;

### LAB 3.1 - SELECT SQL

# 1. From the client table, what are the ids of the first 5 clients from disrict_id 1?
select
	client_id
from
	bank.client
where
	district_id = 1
order by 1 asc
limit 5;

# 2. From the client table, what is the id of the last client from district_id 72?

select
	client_id
from
	bank.client
where
	district_id = 72
order by 1 desc
limit 1;

# 3. From the loan table, what are the 3 lowest amounts?

select
	amount
from
	bank.loan
order by 1 asc
limit 3;

# 4. From the loan table, what are the possible values for status, ordered alphabetically in ascending order?

select distinct
	status
from
	bank.loan
order by 1 asc;

# 5. From the loans table, what is the loan_id of the highest payment received?

select
	loan_id,
	payments
from
	bank.loan
order by 2 desc 
limit 1;

# 6. From the loans table, what is the loan amount of the lowest 5 account_ids. Show the account_id and the corresponding amount

select
	account_id,
	amount
from
	bank.loan
order by 1 asc
limit 5;

# 7. From the loans table, which are the account_ids with the lowest loan amount have a loan duration of 60?

select
	account_id
from
	bank.loan
where
	duration = 60
order by amount asc
limit 5;

# 8. From the order table, what are the unique values of k_symbol?

select
	distinct k_symbol 
from
	bank.order;
	
# 9. From the order table, which are the order_ids from the client with the account_id 34?

select
	order_id
from
	bank.order
where
	account_id = 34;
	
# 10. From the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?

select distinct 
	account_id
from
	bank.order
where
	order_id between 29540 and 29560;

# 11. From the order table, what are the individual amounts that were sent to (account_to) id 30067122?

select
	amount
from
	bank.order
where
	account_to = 30067122;
	
# 12. From the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id = 793 in chronological order, from newest to oldest.

select
	trans_id,
	date,
	type,
	amount 
from
	bank.`trans`
where
	account_id = 793
order by date desc
limit 10;

## LAB 4 - AGGREGATIONS

# 1. From the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by district_id in ascending order.

select
	district_id,
	count(client_id)
from
	bank.client 
where
	district_id < 10
group by 1
order by 1 asc;

# 2. From the card table, how many cards exist for each type? Rank the result starting with the most frequent type.

select
	type,
	count(card_id)
from
	bank.card
group by 1
order by 2 desc;

# 3. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

select
	account_id,
	sum(amount)
from
	bank.loan
group by 1
order by 2 desc
limit 10;

# 4. From the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order

select
	date(date),
	count(loan_id)
from
	bank.loan
where
	date < 930907
group by 1 
order by 1 desc;

# 5. From the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

select
	date,
	duration,
	count(loan_id)
from
	bank.loan
where
	date(date) between '1997-12-01' and '1998-01-01'
group by 1,2
order by 1 asc, 2 asc;

# 6. From the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

select
	account_id,
	type,
	sum(amount)
from
	bank.trans
where
	account_id = 396
group by 1,2
order by 2 asc;

# 7. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

select
	account_id,
	case
		when type = 'PRIJEM' then 'Incoming'
		when type = 'VYDAJ' then 'Outgoing' 
		end as transaction_type,
	truncate(sum(amount),0)
from
	bank.trans
where
	account_id = 396
group by 1,2
order by 2 asc;

# 8. From the previous result, modify you query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference

select
	account_id,
	truncate(sum(case 
					when type = 'PRIJEM' then amount 
					END),0) as incoming,
	truncate(sum(case 
					when type = 'VYDAJ' then amount 
					END),0) as outgoing,
	truncate(sum(case 	
					when type = 'PRIJEM' then amount 
					END) 
			- sum(case 
					when type = 'VYDAJ' then amount 
					END),0) as diff

from
	bank.trans
where
	account_id = 396
group by 1;

# 9. Continuing with the previous example, rank the top 10 account_ids based on their difference

select
	account_id,
	truncate(sum(case when type = 'PRIJEM' then amount else 0 END),0) - truncate(sum(case when type = 'VYDAJ' then amount else 0 END),0) as diff

from
	bank.trans
group by 1
order by 2 desc
limit 10;
