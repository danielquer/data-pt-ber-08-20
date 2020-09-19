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