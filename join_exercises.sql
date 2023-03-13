use employees;
select database();
show tables;
show create table authors;
show create table authorz;

create table join_users (
id int not null auto_increment,
first_name varchar(100) not null,
last_name varchar(100) not null,
primary key (id),
unique (first_name, last_name)
);

select *
from employees;

select *
from departments;

select * 
from dept_emp;

select *
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
where gender = 'f';


show databases;
use join_example_db;
select database();
show tables;

select *
from roles;

select *
from users;

select *
from users
join roles on users.role_id = roles.id;

select *
from users
left join roles on users.role_id = roles.id;

select *
from users
right join roles on users.role_id = roles.id;


use employees;
show tables;

select *
from titles;

select *
from employees;

select *
from dept_manager;

select *
from departments;

select *
from dept_emp;

select d.dept_name, dm.dept_no
from departments as d
join dept_manager as dm on d.dept_no = dm.dept_no; 

/*
2.Using the example in the Associative Table Joins section as a guide, 
write a query that shows each department along with the name of the current manager for that department.
*/

select d.dept_name, concat(e.first_name,' ', e.last_name) name
from departments as d
join dept_manager as dm on d.dept_no = dm.dept_no
join employees as e on e.emp_no = dm.emp_no 
where dm.to_date > now();

/*
3.Find the name of all departments currently managed by women.
*/
 
select d.dept_name, concat( e.first_name, ' ', e.last_name) name, e.gender
from departments as d
join dept_manager as dm on d.dept_no = dm.dept_no
join employees as e on e.emp_no = dm.emp_no 
where dm.to_date > now()
and gender = 'f';

/*
4.Find the current titles of employees currently working in the Customer Service department.
*/

select t.title, count(*) depart_name
from titles as t
join dept_emp as de on de.emp_no = t.emp_no
join departments as d on d.dept_no = de.dept_no
where d.dept_name = 'customer service'
and  t.to_date > now()
group by t.title 
order by t.title;
select *
from dept_emp;

select *
from titles;

/*
5.Find the current salary of all current managers.
*/
select *
from titles;

select d.dept_name, concat(e.first_name,' ', e.last_name) name, s.salary
from departments as d
join dept_manager as dm on d.dept_no = dm.dept_no
join employees as e on e.emp_no = dm.emp_no 
join salaries s on s.emp_no = e.emp_no
where s.to_date > now()
and dm.to_date > now()
;

/*
6.Find the number of current employees in each department.
*/

select d.dept_no, d.dept_name, count(d.dept_name)
from departments d
join dept_emp de on de.dept_no = d.dept_no
where  de.to_date > now()
group by d.dept_name
order by d.dept_no;


/*
7.Which department has the highest average salary? Hint: Use current not historic information.
*/

select d.dept_name,round(avg(s.salary),2)
from salaries s
join dept_emp de on de.emp_no = s.emp_no
join departments d on d.dept_no = de.dept_no
group by d.dept_name;

/*
8.Who is the highest paid employee in the Marketing department?
*/

select e.first_name, e.last_name, s.salary
from salaries s
join employees e on e.emp_no = s.emp_no
join dept_emp de on de.emp_no = s.emp_no
join departments d on d.dept_no = de.dept_no
where d.dept_name = 'marketing'
and s.to_date > now()
order by s.salary desc
limit 1
;

select *
from salaries;

select *
from dept_manager;

/*
9.Which current department manager has the highest salary?
*/

select d.dept_name, concat(e.first_name,' ', e.last_name) name, s.salary
from dept_manager dm
join employees e on dm.emp_no = e.emp_no
join salaries s on dm.emp_no = s.emp_no
join departments d on dm.dept_no = d.dept_no
where dm.to_date > now()
and s.to_date > now()
order by s.salary desc
;


/*
10.Determine the average salary for each department. Use all salary information and round your results.
*/

select distinct d.dept_name, round(avg(s.salary),2) average_salary -- d.dept_name, s.salary
from departments d
join dept_emp de on de.dept_no = d.dept_no
join employees e on e.emp_no = de.emp_no
join salaries s on s.emp_no = e.emp_no

;

/*
Bonus Find the names of all current employees, their department name, and their current manager's name.
*/

select 
(select concat(e.first_name,' ', e.last_name) name
from dept_manager dm
left join employees e on dm.emp_no = e.emp_no
left join salaries s on dm.emp_no = s.emp_no
left join departments d on dm.dept_no = d.dept_no
where dm.to_date > now()
and s.to_date > now()) as 'manager_name

