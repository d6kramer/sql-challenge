CREATE TABLE departments (
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);

CREATE TABLE titles (
	title_id VARCHAR(5) PRIMARY KEY NOT NULL,
	title VARCHAR(30)
);

CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)	
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);


CREATE VIEW data_analysis_01 AS
	SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
	FROM employees e
	JOIN salaries s using (emp_no);

CREATE VIEW data_analysis_02 AS
	SELECT first_name, last_name, hire_date
	FROM employees
	WHERE hire_date >= '01/01/1986'
	AND hire_date <= '12/31/1986';

CREATE VIEW data_analysis_03 AS
	SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
	FROM departments d
	JOIN dept_manager dm USING (dept_no)
	JOIN employees e USING (emp_no);
	
CREATE VIEW data_analysis_04 AS
	SELECT d.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
	FROM departments d
	JOIN dept_emp de USING (dept_no)
	JOIN employees e USING (emp_no);
	
CREATE VIEW data_analysis_05 AS
	SELECT first_name, last_name, sex
	FROM employees
	WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';

CREATE VIEW data_analysis_06 AS
	SELECT emp_no, last_name, first_name
	FROM employees
	WHERE emp_no IN 
	(
		SELECT emp_no
		FROM dept_emp
		WHERE dept_no IN 
		(
			SELECT dept_no
			FROM departments
			WHERE dept_name = 'Sales' 
		)
	);
	
CREATE VIEW data_analysis_07 AS
	SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
	FROM DEPARTMENTS d
	JOIN dept_emp de USING (dept_no)
	JOIN employees e USING (emp_no)
	WHERE dept_name = 'Sales'
	OR dept_name = 'Development';

CREATE VIEW data_analysis_08 AS
	SELECT last_name, COUNT(last_name) AS "Number of Employees"
	FROM employees
	GROUP BY last_name
	ORDER BY "Number of Employees" DESC;