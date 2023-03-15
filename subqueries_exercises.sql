show databases;
use employees;

/* 
1.Find all the current employees with the same hire date as employee 101010 using a subquery.
*/
select *
from employees
join dept_emp de using (emp_no)
where hire_date =
(
select hire_date
from employees
where emp_no =  '101010'
)
and de.to_date > now()
;

/*
2.Find all the titles ever held by all current employees with the first name Aamod.
*/

select distinct title
from titles
where emp_no in 
(
select emp_no
from employees
where first_name = 'Aamod'
)
and to_date > now()
;

/*
3.How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
*/

select count(distinct e.emp_no)
from employees e
left join (select emp_no, max(to_date) as to_date
from dept_emp
group by emp_no) de on e.emp_no = de.emp_no
where de.to_date < now();

SELECT COUNT(DISTINCT e.emp_no) as num_people_no_longer_working
FROM employees e
INNER JOIN (
    SELECT emp_no, MAX(to_date) as to_date
    FROM salaries
    GROUP BY emp_no
) s ON e.emp_no = s.emp_no
WHERE s.to_date < NOW();

/*
4.Find all the current department managers that are female. List their names in a comment in your code.
*/

select first_name, last_name
from employees
where emp_no in
(select emp_no
from dept_manager
where to_date > now())
and gender = 'f'
;

/*
5.Find all the employees who currently have a higher salary than the companies overall, historical average salary.
*/

select *, (select round(avg(salary),2)from salaries) as historical_avg
from salaries
where salary >
(select round(avg(salary),2)
from salaries)
and to_date > now();

/*
6.How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
*/

select count(emp_no)
from salaries
where salary between
((select max(salary)
from salaries where to_date > now()) - (select stddev(salary)
from salaries where to_date > now()))
and
(select max(salary)
from salaries where to_date > now())
and to_date > now()
;

select (((select count(emp_no)
from salaries
where salary between
((select max(salary)
from salaries where to_date > now()) - (select stddev(salary)
from salaries where to_date > now()))
and
(select max(salary)
from salaries where to_date > now())
and to_date > now()) /(select count(emp_no)))* 100) as percent
from salaries
where to_date > now()
;

/*
Find all the department names that currently have female managers.
*/

select 
from 
where dept_no in
(select dept_no, emp_no
from dept_manager
where to_date > now())
and emp_no in
(select first_name, last_name
from employees
where emp_no in
(select emp_no
from dept_manager
where to_date > now())
and gender = 'f') as 


;
/*
Find the first and last name of the employee with the highest salary.
*/
select dept_no, emp_no
from dept_manager
where to_date > now();
/*
Find the department name that the employee with the highest salary works in.
*/
(select emp_no
from employees
where emp_no in
(select emp_no
from dept_manager
where to_date > now())
and gender = 'f');
/*
Who is the highest paid employee within each department.
*/

select *
from salaries s
join dept_emp de on s.emp_no = de.emp_no
where s.to_date > now()

;

select dept_no
from dept_emp
select emp_no, max(salary)
from salaries
group by emp_no;