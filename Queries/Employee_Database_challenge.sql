-- Deliverable 1

-- Query to create a Retirement Titles table for employees born between '1952-01-01' and '1955-12-31'
SELECT em.emp_no,
	em.first_name, 
	em.last_name, 
	ti.title, 
	ti.from_date, 
	ti.to_date	
INTO retirement_titles
FROM employees as em
JOIN titles as ti
ON em.emp_no = ti.emp_no
	WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY em.emp_no;

SELECT * FROM retirement_titles;


-- Query to create a Unique Titles table that contains the employee #, first and last name; and most recent title
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
		rt.first_name,
		rt.last_name,
		rt.title

INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles;


-- Query to create a Retiring Titles table that has the number of titles filled by employees retiring
SELECT COUNT(ut.title), ut.title

INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY count DESC;

SELECT * FROM retiring_titles;



-- Deliverable 2

-- Query to create a Mentorship Eligibility table that has the current employees born between '1965-01-01' AND '1965-12-31'
SELECT DISTINCT ON (em.emp_no) em.emp_no,
		em.first_name,
		em.last_name,
		em.birth_date,
		de.from_date,
		de.to_date,
		ti.title
		
INTO mentorship_eligibility
FROM employees as em
JOIN dept_emp as de
ON (em.emp_no = de.emp_no)
JOIN titles as ti
ON (em.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND (em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY em.emp_no;

SELECT * FROM mentorship_eligibility;
