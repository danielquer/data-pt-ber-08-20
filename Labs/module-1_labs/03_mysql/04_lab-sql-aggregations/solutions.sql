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
