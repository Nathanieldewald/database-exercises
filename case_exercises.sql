USE employees;


/*
1.Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not.
*/

select distinct e.emp_no, e.first_name, e.last_name, dept_emp.dept_no, dept_emp.from_date, dept_emp.to_date, 
if(dept_emp.to_date > now(), 1, 0) as is_current_employee
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
    end as alpha_group
from employees
;

/*
3.How many employees (current or previous) were born in each decade?
*/

select concat(floor(year(birth_date) / 10) * 10, 's') as decade, count(*) as num_employees
from employees as e
join dept_emp as de on e.emp_no =de.emp_no
where de.to_date < now()
group by decade
	
;

select 
	case
		when e.birth_date like '195%' then '50s'
		when e.birth_date like '196%' then '60s'
    end as decade, count(e.emp_no)
from employees as e
join dept_emp as de on e.emp_no =de.emp_no
where de.to_date > now()
group by decade;




/*
4.What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/

select 
  round(avg(s.salary),2) as avg_salary,
  case 
	when d.dept_name in ('research', 'development') then 'R&D'
    when d.dept_name in ('sales', 'marketing') then 'Sales_&_Marketing'
    when d.dept_name in ('finance', 'human resources') then 'Finance_&_HR'
    when d.dept_name in ('production', 'quality management') then 'Prod_&_QM'
    else d.dept_name
  end dept_group
from 
  employees e
  join dept_emp de on e.emp_no = de.emp_no
  join departments d on de.dept_no = d.dept_no
  join salaries s on e.emp_no = s.emp_no and s.to_date > now()
group by dept_group;
