SHOW DATABASES;
USE albums_db;
SELECT DATABASE();
SHOW CREATE DATABASE albums_db;
SHOW TABLES;
SHOW DATABASES;
USE employees;
SELECT DATABASE();
SHOW CREATE DATABASE employees;
SHOW TABLES;
/* 
 Which table(s) do you think contain a numeric type column?
 dept_manager, dept_emp, employees, salaries, titles
 Which table(s) do you think contain a string type column?
 dept_manager, departments, dept_emp, employees, titles
 Which table(s) do you think contain a date type column? 
 dept_manager, dept_emp, employees, salaries, titles
 What is the relationship between the employees and the departments tables? 
 The dept_emp table joins them two tables together
*/
SHOW CREATE TABLE dept_manager;
/* CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1 
*/
SHOW CREATE TABLE departments;
SHOW CREATE TABLE dept_emp;
SHOW CREATE TABLE dept_manager;
SHOW CREATE TABLE employees;
SHOW CREATE TABLE salaries;
SHOW CREATE TABLE titles;


