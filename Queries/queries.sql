-- Creating tables for PH-EmployeeDB

CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE managers (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);

SELECT * FROM departments;

SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'



SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'



SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31'



SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'



SELECT first_name, last_name

FROM employees

WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'



-- Retirement eligibility

SELECT first_name, last_name

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



-- Number of employees retiring

SELECT COUNT(first_name)

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT first_name, last_name

INTO retirement_info

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT * FROM retirement_info



DROP TABLE retirement_info;



-- Create new table for retiring employees

SELECT emp_no, first_name, last_name

INTO retirement_info

FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')

AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



-- Check the table

SELECT * FROM retirement_info;

-- Joining departments and managers tables

SELECT departments.dept_name,

	managers.emp_no,
	
	managers.from_date,
	
	managers.to_date
	
FROM departments

INNER JOIN managers

ON departments.dept_no = managers.dept_no;



-- Joining retirement_info and dept_emp tables

SELECT retirement_info.emp_no,

	retirement_info.first_name,
	
retirement_info.last_name,

	dept_emp.to_date
	
FROM retirement_info

LEFT JOIN dept_emp

ON retirement_info.emp_no = dept_emp.emp_no;



-- Making previous query shorter with aliases

SELECT ri.emp_no,

	ri.first_name,
	
ri.last_name,

	de.to_date
	
FROM retirement_info as ri

LEFT JOIN dept_emp as de

ON ri.emp_no = de.emp_no;



-- Joining departments and managers tables with aliases instead

SELECT d.dept_name,

	ma.emp_no,
	
	ma.from_date,
	
	ma.to_date
	
FROM departments as d

INNER JOIN managers as ma

ON d.dept_no = ma.dept_no;



-- Query to join retirement_info and dept_emp into current_emp filtered to only current employees

SELECT ri.emp_no,

	ri.first_name,
	
	ri.last_name,
	
de.to_date

INTO current_emp

FROM retirement_info as ri

LEFT JOIN dept_emp as de

ON ri.emp_no = de.emp_no

WHERE de.to_date = ('9999-01-01');



-- Employee count by department number

SELECT COUNT(ce.emp_no), de.dept_no

INTO employee_count

FROM current_emp as ce

LEFT JOIN dept_emp as de

ON ce.emp_no = de.emp_no

GROUP BY de.dept_no

ORDER BY de.dept_no;



