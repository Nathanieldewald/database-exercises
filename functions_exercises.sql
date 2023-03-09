SHOW DATABASES;
USE employees;
SHOW CREATE TABLE employees;

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


