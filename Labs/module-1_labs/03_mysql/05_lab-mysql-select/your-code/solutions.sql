# Challenge 0: 

# a) Create a table which for each author contains their author id, first name, last name, and the total number of titles they have written according to the titleauthor table. Give each variable an alias, such that the table output is easy to read and interpret.

select
	au_id as author_id,
	au_fname as first_name,
	au_lname as last_name,
	count(ti.title_id)
from
	titleauthor as ti
inner join
	authors as au using (au_id)
group by 1,2,3;

# b) Create a table which for each job description contains the first hire date (i.e. the first employee with this job id was hired). Again, name the columns properly to have a nice return table. Sort the results from the job description with the first hire to the one with the last hire.


select
	j.job_id,
	j.job_desc as job_description,
	date(min(e.hire_date)) as first_hire_date
from
	jobs as j
inner join
	employee as e using (job_id)
group by 1,2
order by 3 desc;

# Challenge 1 - Who Have Published What At Where?
# what titles each author has published at which publishers?

select
	au.au_id as author_id,
	au.au_lname as last_name,
	au.au_fname as first_name,
	ti.title,
	pu.pub_name as publisher_name	
from
	titleauthor as ta
inner join
	authors as au on ta.au_id = au.au_id
inner join
	titles as ti on ta.title_id = ti.title_id
inner join
	publishers as pu on pu.pub_id = ti.pub_id
order by 1 asc;


# Challenge 2 - Who Have Published How Many At Where?

select
	au.au_id as author_id,
	au.au_lname as last_name,
	au.au_fname as first_name,
	pu.pub_name as publisher_name,
	count(ta.title_id) as title_count
from
	authors as au
inner join
	titleauthor as ta on ta.au_id = au.au_id
inner join
	titles as ti on ta.title_id = ti.title_id
inner join
	publishers as pu on pu.pub_id = ti.pub_id
group by 1,2,3,4
;

# Challenge 3 - Best Selling Authors

select
	au.au_id as author_id,
	au.au_lname as last_name,
	au.au_fname as first_name,
	sum(sa.qty) as titles_sold
from
	authors as au
inner join
	titleauthor as ta on ta.au_id = au.au_id
inner join
	titles as ti on ta.title_id = ti.title_id
inner join
	sales as sa on sa.title_id = ta.title_id
group by 1,2,3
order by 4 desc
limit 3;

# Challenge 4 - Best Selling Authors Ranking

select
	au.au_id as author_id,
	au.au_lname as last_name,
	au.au_fname as first_name,
	coalesce(sum(sa.qty),0) as titles_sold
from
	authors as au
left join
	titleauthor as ta on ta.au_id = au.au_id
left join
	sales as sa on sa.title_id = ta.title_id
group by 1,2,3
order by 4 desc
;

# Bonus Challenge - Most Profiting Authors

select
	au.au_id as author_id,
	au.au_lname as last_name,
	au.au_fname as first_name,
	truncate(sum(
				(ta.royaltyper / 100) * 
					(	(ti.royalty / 100) * 
						sa.qty * 
						ti.price + 
						ti.advance
					)
				)
			,2) as profit	
from
	authors as au
left join
	titleauthor as ta on ta.au_id = au.au_id
left join
	titles as ti on ta.title_id = ti.title_id
left join
	sales as sa on sa.title_id = ta.title_id
group by 1,2,3
order by 4 desc
limit 3
;