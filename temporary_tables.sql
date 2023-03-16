/*
1.Using the example from the lesson, create a temporary table called 
employees_with_departments that contains first_name, last_name, and dept_name for 
employees currently with that department. Be absolutely sure to create this table on 
your own database. If you see "Access denied for user ...", it means that 
the query was attempting to write a new table to a database that you can only read.

	a.Add a column named full_name to this table. It should be a VARCHAR whose length 
    is the sum of the lengths of the first name and last name columns.
	
    b.Update the table so that the full_name column contains the correct data.
	
    c.Remove the first_name and last_name columns from the table.
	
    d.What is another way you could have ended up with this same table?
    subqueried it out before making temp table 
*/    

use employees;

(select distinct emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de using (emp_no)
join departments d on de.dept_no =d.dept_no
join (select max(from_date) as max_from_date from dept_emp group by emp_no) as current_from_date
	on de.from_date = current_from_date.max_from_date
where de.to_date > now())
;

create temporary table pagel_2185.employees_with_departments
(select distinct emp_no, e.first_name, e.last_name, d.dept_name
from employees e
join dept_emp de using (emp_no)
join departments d on de.dept_no =d.dept_no
join (select max(from_date) as max_from_date from dept_emp group by emp_no) as current_from_date
	on de.from_date = current_from_date.max_from_date
where de.to_date > now())
;
alter table pagel_2185.employees_with_departments
	add full_name varchar(100);

update pagel_2185.employees_with_departments
set full_name = concat(first_name,' ', last_name);

alter table pagel_2185.employees_with_departments drop column first_name;
alter table pagel_2185.employees_with_departments drop column last_name;
select *
from pagel_2185.employees_with_departments
;

(select concat(first_name,' ', last_name) as full_name 
from employees);
/*
2.Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is stored as an 
integer representing the number of cents of the payment. For example, 1.99 should become 199.
*/
use sakila;
create temporary table pagel_2185.cents_payment
(select *, floor(amount * 100) cents
from payment);

select *
from pagel_185.cents_payment;
/*
3.Find out how the current average pay in each department compares to the overall 
current pay for everyone at the company. For this comparison, you will calculate the 
z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?
*/

-- Overall current salary stats
select avg(salary), std(salary) from employees.salaries where to_date > now();

-- 72,012 overall average salary
-- 17,310 overall standard deviation

-- Saving my values for later... that's what variables do (with a name)
-- Think about temp tables like variables

create temporary table pagel_2185.overall_aggregates as (
    select avg(salary) as avg_salary, std(salary) as std_salary
    from employees.salaries  where to_date > now()
);

-- double check that the values look good.
select * from pagel_2185.overall_aggregates;


-- Let's check out our current average salaries for each department
-- If you see "for each" in the English for a query to build..
-- Then, you're probably going to use a group by..
select dept_name, avg(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > curdate()
and employees.salaries.to_date > curdate()
group by dept_name;

drop table if exists pagel_2185.current_info;

# create the temp table using the query above
create temporary table pagel_2185.current_info as (
    select dept_name, avg(salary) as department_current_average
    from employees.salaries
    join employees.dept_emp using(emp_no)
    join employees.departments using(dept_no)
    where employees.dept_emp.to_date > curdate()
    and employees.salaries.to_date > curdate()
    group by dept_name
);

select * from pagel_2185.current_info;

-- add on all the columns we'll end up needing:
alter table pagel_2185.current_info add overall_avg float(10,2);
alter table pagel_2185.current_info add overall_std float(10,2);
alter table pagel_2185.current_info add zscore float(10,2);

-- peek at the table again
select * from pagel_2185.current_info;

-- set the avg and std
update pagel_2185.current_info set overall_avg = (select avg_salary from pagel_2185.overall_aggregates);
update pagel_2185.current_info set overall_std = (select std_salary from pagel_2185.overall_aggregates);



-- update the zscore column to hold the calculated zscores
update pagel_2185.current_info 
set zscore = (department_current_average - overall_avg) / overall_std;



select * from pagel_2185.current_info
order by zscore desc;


SELECT AVG(salary), STDDEV(salary)
FROM employees.salaries;	