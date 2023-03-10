SHOW DATABASES;
USE employees;
SHOW CREATE TABLE employees;
SHOW CREATE TABLE salaries;
/*
2.Write a query to to find all employees whose last name starts and ends with 'E'. 
Use concat() to combine their first and last name together as a single column named full_name.
*/

SELECT concat(first_name,' ', last_name ) as full_name
FROM employees
WHERE last_name LIKE '%E'
AND last_name LIKE 'E%';

/*
3.Convert the names produced in your last query to all uppercase.
*/

SELECT concat(UPPER(first_name),' ', UPPER(last_name)) as full_name
FROM employees
WHERE last_name LIKE '%E'
AND last_name LIKE 'E%';

/*
4.Use a function to determine how many results were returned from your previous query.
*/

SELECT count(*) as num_emp
FROM employees
WHERE last_name LIKE '%E'
AND last_name LIKE 'E%';

/*
Find all employees hired in the 90s and born on Christmas. 
Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
*/

select *, datediff(curdate(), hire_date) as days
from employees
where hire_date like ('199%')
and birth_date like ('%-12-25');

/*
Find the smallest and largest current salary from the salaries table.
*/

(select * 
from salaries
where to_date > now()
order by salary
limit 1)
union all
(select *
from salaries
where to_date > now()
order by salary desc
limit 1);

/*
Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
*/

select lower(concat(substr(first_name,1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date, 3,2))) as username,
first_name, last_name, birth_date
from employees
limit 10;
