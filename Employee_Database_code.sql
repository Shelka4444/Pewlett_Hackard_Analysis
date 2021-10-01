-- Create new table with retirement info and titles
SELECT e.emp_no, e.first_name, e.last_name,
	ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-01-01'
ORDER BY emp_no ASC

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

-- Count number of retirees per title
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_title
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC

--Mentorship Program Table
SELECT DISTINCT ON (e.emp_no)
	e.emp_no,e.first_name, e.last_name, e.birth_date,
	de.from_date, de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employee as de
ON (e.emp_no = de.emp_no)
LEFT JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') 
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC

--Additional Queries
--Mentorship Title Count
SELECT COUNT(me.title), me.title
INTO mentorship_title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;

-- Retirment info and titles for 1952
SELECT DISTINCT ON (e.emp_no)
	e.emp_no, e.first_name, e.last_name,
	ti.title, ti.from_date, ti.to_date
INTO retirement_titles_1952
FROM employees AS e
LEFT JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1952-12-31'
ORDER BY emp_no ASC

-- Count number of retirees per title
SELECT COUNT(rt52.emp_no), rt52.title
INTO retiring_title_count_1952
FROM retirement_titles_1952 as rt52
GROUP BY rt52.title
ORDER BY COUNT(rt52.title) DESC