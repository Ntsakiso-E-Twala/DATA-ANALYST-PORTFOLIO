
-- Extracting data about the date of hire for department managers during a specific period

USE employees;
SELECT * FROM dept_manager 
WHERE emp_no IN (SELECT emp_no 
				  FROM employees
                  WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
                  

-- Extracting data where the empoloyee has a certain job title
SELECT * FROM employees e 
WHERE EXISTS (SELECT * FROM titles t
               WHERE t.emp_no = e.emp_no
               AND title = 'Assistant Engineer');
    
-- Creating a data set of employees, number of departments they work in and thier managers from existing data 
INSERT INTO emp_manager
SELECT u.*
FROM
    (SELECT a.* FROM
        (SELECT 
            e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT emp_no
			 FROM dept_manager
                WHERE emp_no = 110022) AS manager_I FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
        WHERE e.emp_no <= 10020
        GROUP BY e.emp_no
         ORDER BY e.emp_no) AS a UNION SELECT 
        b.*
    FROM (SELECT 
        e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code,
            (SELECT  emp_no
                FROM dept_manager
                WHERE emp_no = 110039) AS manager_I FROM employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT  emp_no
                FROM dept_manager
                WHERE emp_no = 110039) AS manager_ID
                 FROM employees e
         JOIN dept_emp de ON e.emp_no = de.emp_no
       WHERE e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM (SELECT  e.emp_no AS employee_ID, MIN(de.dept_no) AS department_code,
            (SELECT emp_no FROM dept_manager
                WHERE emp_no = 110022) AS manager_ID
				FROM employees e
               JOIN dept_emp de ON e.emp_no = de.emp_no 
			WHERE e.emp_no = 110039
             GROUP BY e.emp_no) AS d) as u;