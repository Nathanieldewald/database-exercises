show databases;
use employees;
select database();
show tables;

/*
2.In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.
7
*/

select distinct title
from titles;

/*
3.Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
*/

select last_name
from employees
where (last_name like "%e"
and last_name like 'e%')
group by last_name;

/*
Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
*/

select distinct first_name, last_name
from employees
where (last_name like "%e"
and last_name like 'e%')
and (first_name like 'e%'
and first_name like '%e');

/*
5.Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
Chleq, lindqvist, Qiwen
6.Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
*/

select last_name, count(last_name)
from employees 
where last_name like '%q%'
and last_name not like '%qu%'
group by last_name;

/*
7.Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
*/

select first_name, gender, count(*)
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by first_name, gender
order by first_name;

/*
8.Using your query that generates a username for all of the employees, generate a count employees for each unique username.
300024
*/
select count(lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date, 3,2))))
from employees;

/*
9.From your previous query, are there any duplicate usernames?
yes 
What is the higest number of times a username shows up? 
6
*/

select distinct lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date, 3,2))) as username, count(*) as duplicate
from employees
group by username
order by duplicate desc;

/*
Bonus: How many duplicate usernames are there from your previous query?
13251
*/

select distinct lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date, 3,2))) as username, count(*) as duplicate

from employees
group by username
having duplicate > 1
order by duplicate desc;