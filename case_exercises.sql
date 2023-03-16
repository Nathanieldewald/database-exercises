USE employees;


/*
1.Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not.
*/

select distinct e.emp_no, e.first_name, e.last_name, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date, 
if(dept_emp.to_date is null or dept_emp.to_date > now(), 1, 0) as is_current_employee
from employees e
join (select emp_no, max(from_date) as max_from_date
	from dept_emp
    group by emp_no) as latest_dept_emp on e.emp_no = latest_dept_emp.emp_no
join dept_emp on latest_dept_emp.emp_no = dept_emp.emp_no
	and latest_dept_emp.max_from_date = dept_emp.from_date
order by e.emp_no
;

/*
2.Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
depending on the first letter of their last name.
*/

select first_name, last_name,
case when last_name regexp '^[a-h]' then 'a-h'
	when last_name regexp '^[i-q]' then 'i-q'
    else 'r-z'
    end as alpha
from employees
;

/*
3.How many employees (current or previous) were born in each decade?
*/

SELECT 
  concat(floor(year(birth_date) / 10) * 10, 's') as decade,
  count(*) as num_employees
from employees e
join dept_emp de on e.emp_no = de.emp_no
	and de.to_date > now()
group by decade
order by decade 
;


/*
4.What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/

    
select dept_emp.dept_no, round(avg(s.salary),2)    
from employees e
join (select emp_no, max(from_date) as max_from_date
	from dept_emp
    group by emp_no) as latest_dept_emp on e.emp_no = latest_dept_emp.emp_no
join dept_emp on latest_dept_emp.emp_no = dept_emp.emp_no
	and latest_dept_emp.max_from_date = dept_emp.from_date
join salaries s on e.emp_no = s.emp_no
where dept_emp.to_date > now()
group by dept_emp.dept_no
;
