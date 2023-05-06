## Employee Database--SQL


 ![Database](https://camo.githubusercontent.com/e734b24320dd6c21767fd3fcc0af7bf3f03659b2983572ef46ba19ff0166b1c8/68747470733a2f2f70726f636573732e66732e746561636861626c6563646e2e636f6d2f41444e75704d6e577952376b435752766d37364c617a2f726573697a653d77696474683a3730352f68747470733a2f2f7777772e66696c657069636b65722e696f2f6170692f66696c652f524c346b46627531534d694349654c4174575833) 
## Backgroud
The major task of this project is to research on employees at Pewlett Hackard company, who were hired from the 1980s and 1990s. All that remains of the database of employees from that period are six CSV files.

In this project, the tables were created to hold the data from the CSV files, the CSV files were imported into a SQL database, and the further data exploration and analysis were performed respectively as the followings: 

## 1. Data Modeling
* Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables.

 ![ERD_employee_QuickDBD](https://github.com/wei3chen2/sql-challenge/blob/main/ERD_employee_QuickDBD.png) 

## 2. Data Engineering 

* Use the provided information to create a table schema for each of the six CSV files.


 ![Table_schema_employee][def](https://github.com/wei3chen2/sql-challenge/blob/main/Table_schema_employee.sql)

## 3. Data Analysis

* List the employee number, last name, first name, sex, and salary of each employee.

SELECT "Employees".emp_no AS "Employee_Number", "Employees".last_name,  
       "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Employees"
JOIN "Salaries" ON "Employees".emp_no = "Salaries".emp_no;

* List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE hire_date > '1986-1-1'::date AND hire_date < '1987-1-1'::date;

* List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT "Dept_manager".dept_no, "Departments".dept_name, "Dept_manager".emp_no, "Employees".last_name, "Employees".first_name
FROM "Dept_manager"
JOIN "Departments" 
ON  "Departments".dept_no = "Dept_manager".dept_no 
JOIN "Employees" 
ON  "Employees".emp_no = "Dept_manager".emp_no;

* List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
JOIN "Dept_emp"
ON "Employees".emp_no = "Dept_emp".emp_no
JOIN "Departments" 
ON "Dept_emp".dept_no = "Departments".dept_no;

* List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

* List each employee in the Sales department, including their employee number, last name, and first name.
SELECT * FROM "Departments";
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
JOIN "Dept_emp" ON "Employees".emp_no = "Dept_emp".emp_no
JOIN "Departments" ON "Dept_emp".dept_no = "Departments".dept_no
WHERE "Departments".dept_name = 'Sales';

* List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT * FROM "Departments";
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
JOIN "Dept_emp" ON "Employees".emp_no = "Dept_emp".emp_no
JOIN "Departments" ON "Dept_emp".dept_no = "Departments".dept_no
WHERE "Departments".dept_no = 'd005' or "Departments".dept_no = 'd007';

* List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name) AS "Frequency_Counts"
FROM "Employees"
GROUP BY last_name
ORDER BY "Frequency_Counts" DESC;



[def]: https://github.com/wei3chen2/sql-challenge/blob/main/Table_schema_employee.sql