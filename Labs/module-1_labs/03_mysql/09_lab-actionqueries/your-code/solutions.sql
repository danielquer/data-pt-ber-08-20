#1. Please create a new table in the publications database called total_royalties which for each author contains their author ID, last name, first name, number of total titles and the sum of royalties they have received.

create table total_royalties as 
select
	au.au_id as ID,
	au.au_lname as LastName,
	au.au_fname as FirstName,
	count(ta.title_id) as TitleCount,
	sum(ta.royaltyper) as RoyaltySum
from
	`authors` as au
left join
	titleauthor as ta on ta.au_id = au.au_id
group by 1,2,3
;
#2. Delete every author which has received total royalties of less than 100.

delete from total_royalties
where RoyaltySum < 100;

#3. Create a new column of type float called AvgRoyalty (this is an ALTER TABLE statement).

alter table total_royalties
add AvgRoyalty float;

#4. Update the new column AvgRoyalty to equal the average royalty per title for each author.

update total_royalties
set AvgRoyalty = RoyaltySum / TitleCount;

#5. Empty all of the values in the table.

delete from total_royalties;

#6. Repopulate the table to contain the same values as it did after step (4), in one single query (you have to use a subquery here)!

insert into total_royalties
with pre_table as (
select
	au.au_id as ID,
	au.au_lname as LastName,
	au.au_fname as FirstName,
	count(ta.title_id) as TitleCount,
	sum(ta.royaltyper) as RoyaltySum
from
	`authors` as au
left join
	titleauthor as ta on ta.au_id = au.au_id
group by 1,2,3
)

select
	*,
	RoyaltySum / TitleCount as AvgRoyalty	
from
	pre_table;

select
	*
from
	total_royalties;

#7. Delete the table total_royalties.

drop table total_royalties;