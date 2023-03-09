SHOW DATABASES;
USE employees;
/*
2.Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name.
In your comments, answer: What was the first and last name in the first row of the results? What was the first 
and last name of the last person in the table?
Irena Reutenauer
Vidya Simmen
*/

SHOW tables;
SHOW CREATE TABLE employees;
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;


/* 
3.Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name.
In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of 
the last person in the table?
Irena Acton
Vidya Zweizig
*/

(SELECT emp_no, first_name, last_name
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY first_name, last_name
LIMIT 1)

UNION ALL

(SELECT emp_no, first_name, last_name
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY first_name DESC, last_name DESC
LIMIT 1);

/*
4.Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the 
last person in the table?
Irena Action
Vidya Zweizig
*/

(SELECT emp_no, first_name, last_name
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY last_name, first_name
LIMIT 1)

UNION ALL

(SELECT emp_no, first_name, last_name
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
ORDER BY last_name DESC, first_name DESC
LIMIT 1);

/*
5.Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last 
employee number with their first and last name.
899
10021 Ramzi Erde
499994 Navin Argence
*/

(SELECT emp_no, first_name,last_name
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E'
ORDER BY emp_no 
LIMIT 1)

UNION ALL

(SELECT emp_no, first_name,last_name
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E'
ORDER BY emp_no DESC
LIMIT 1);


/*
6.Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, 
so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the 
newest employee, and the name of the oldest employee.
899
67892 Eldridge
233488 Erde
*/

(SELECT emp_no, last_name , hire_date
FROM employees
WHERE last_name LIKE '%E'
AND last_name LIKE 'E%'
ORDER BY hire_date DESC
LIMIT 1)

UNION ALL

(SELECT emp_no, last_name , hire_date
FROM employees
WHERE last_name LIKE '%E'
AND last_name LIKE 'E%'
ORDER BY hire_date 
LIMIT 1);

/*
7.Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. 
Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee 
who was hired first.
362
33936 Khun Bernini
412745 Douadi Pettis
*/

(SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-1-1' AND '1999-12-31'
ORDER BY birth_date, hire_date DESC
LIMIT 1)

UNION ALL

(SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-1-1' AND '1999-12-31'
ORDER BY birth_date DESC, hire_date
LIMIT 1);




