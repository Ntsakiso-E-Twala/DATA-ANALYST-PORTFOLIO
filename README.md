# NTSAKISO E.TWALA DATA-ANALYST-PORTFOLIO 

## SQL PROJECTS
[Uploading C
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
reating data sets using subqueries.sql…]()

## PYTHON DATA ANALYSIS
## POWER BI DASHBOARDS/REPORTS
## TABLEAU DASHBOADS
## DATA MODELING TASKS
 
