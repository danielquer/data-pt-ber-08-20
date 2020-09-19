/* In this challenge, please create a table which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received,

In a second step, we from this table would then like to calculate the average royalty per title each author has received. The final table should contain for each author their author ID, last name, first name and average royalty calculated as sum of royalties divided by title count.

Solve this challenge in two ways: first, by using a subquery. Then, by creating a temporary table. */

# Subquery

select
	au_id as AuthorID,
	au_lname as LastName,
	au_fname as FirstName,
	RoyaltySum/TitleCount as AvgRoyaltyPerTitle
from
	(select
	au.au_id,
	au.au_lname,
	au.au_fname,
	count(distinct ti.title_id) as TitleCount,
	truncate(sum(
				(ta.royaltyper / 100) * 
					(	(ti.royalty / 100) * 
						sa.qty * 
						ti.price 
					)
				)
			,2) as RoyaltySum
from
	authors as au
left join
	titleauthor as ta on au.au_id = ta.au_id
left join
	titles as ti on ta.title_id = ti.title_id
left join
	sales as sa on ti.title_id = sa.title_id
group by 1,2,3) as atr;

# Common Table Expression

with authors_titles_royalties as (
select
	au.au_id,
	au.au_lname,
	au.au_fname,
	count(distinct ti.title_id) as TitleCount,
	truncate(sum(
				(ta.royaltyper / 100) * 
					(	(ti.royalty / 100) * 
						sa.qty * 
						ti.price 
					)
				)
			,2) as RoyaltySum
from
	authors as au
left join
	titleauthor as ta on au.au_id = ta.au_id
left join
	titles as ti on ta.title_id = ti.title_id
left join
	sales as sa on ti.title_id = sa.title_id
group by 1,2,3
)

select
	au_id as AuthorID,
	au_lname as LastName,
	au_fname as FirstName,
	RoyaltySum/TitleCount as AvgRoyaltyPerTitle
from
	authors_titles_royalties as atr;
	
# Temporary table

create temporary table publications.authors_titles_royalties as
select
	au.au_id,
	au.au_lname,
	au.au_fname,
	count(distinct ti.title_id) as TitleCount,
	truncate(sum(
				(ta.royaltyper / 100) * 
					(	(ti.royalty / 100) * 
						sa.qty * 
						ti.price 
					)
				)
			,2) as RoyaltySum
from
	authors as au
left join
	titleauthor as ta on au.au_id = ta.au_id
left join
	titles as ti on ta.title_id = ti.title_id
left join
	sales as sa on ti.title_id = sa.title_id
group by 1,2,3;

select
	au_id as AuthorID,
	au_lname as LastName,
	au_fname as FirstName,
	RoyaltySum/TitleCount as AvgRoyaltyPerTitle
from
	publications.authors_titles_royalties as atr