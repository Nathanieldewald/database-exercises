show databases;
use employees;
select database();
show tables;

/*
2.In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.
7
*/

select count(distinct title)
from titles;

/*
3.Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
*/

select last_name
from employees
where last_name like "e%e"
group by last_name;

/*
Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
*/

select distinct first_name, last_name
from employees
where last_name like 'e%e'
and first_name like 'e%e';

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
having duplicate > 1
order by duplicate desc;

/*
Bonus: How many duplicate usernames are there from your previous query?
13251
*/

select count(*)
from (select distinct lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date, 3,2))) as username, count(*) as duplicate
from employees
group by username
having duplicate > 1
order by duplicate desc) as fun;



select distinct lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date, 3,2))) as username, count(*) as 
from employees
group by username
having duplicate > 1
order by duplicate desc;

/* Bonus */

/*
Determine the historic average salary for each employee. 
When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
*/

select emp_no, round(avg(salary),2)
from salaries
group by emp_no;

/*
Using the dept_emp table, count how many current employees work in each department. 
The query result should show 9 rows, one for each department and the employee count.
*/

select dept_no, count(emp_no) as emp_count
from dept_emp
group by dept_no;

/*
Determine how many different salaries each employee has had. This includes both historic and current.
*/

select emp_no, count(salary)
from salaries
group by emp_no;

/*
Find the maximum salary for each employee.
*/

select emp_no, max(salary)
from salaries
group by emp_no;

/*
Find the minimum salary for each employee
*/

select emp_no, min(salary)
from salaries
group by emp_no;

/*
Find the standard deviation of salaries for each employee.
*/

select emp_no, STD(salary)
from salaries
group by emp_no;

/*
Now find the max salary for each employee where that max salary is greater than $150,000.
*/

select emp_no, max(salary)
from salaries
where salary > 150000
group by emp_no;

/*
Find the average salary for each employee where that average salary is between $80k and $90k.
*/

select emp_no, max(salary)
from salaries
where salary between 80000 and 90000
group by emp_no;

select
