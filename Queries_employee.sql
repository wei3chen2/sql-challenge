-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/YM9vlo
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.

CREATE TABLE ""Employees"" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(20)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(5)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_"Employees"" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR(20)   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Departments" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_Dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_Dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
     )
);

ALTER TABLE ""Employees"" ADD CONSTRAINT "fk_"Employees"_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- 1. List the employee number, last name, first name, sex, and salary of each employee
SELECT "Employees".emp_no AS "Employee_Number", "Employees".last_name,  
       "Employees".first_name, "Employees".sex, "Salaries".salary
FROM "Employees"
JOIN "Salaries" ON "Employees".emp_no = "Salaries".emp_no;

-- 2. List the first name, last name, and hire date for the "Employees" who were hired in 1986 
SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE hire_date > '1986-1-1'::date AND hire_date < '1987-1-1'::date;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name
SELECT "Dept_manager".dept_no, "Departments".dept_name, "Dept_manager".emp_no, "Employees".last_name, "Employees".first_name
FROM "Dept_manager"
JOIN "Departments" 
ON  "Departments".dept_no = "Dept_manager".dept_no 
JOIN "Employees" 
ON  "Employees".emp_no = "Dept_manager".emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
JOIN "Dept_emp"
ON "Employees".emp_no = "Dept_emp".emp_no
JOIN "Departments" 
ON "Dept_emp".dept_no = "Departments".dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

-- 6. List each employee in the Sales department , including their employee number, last name, and first name
SELECT * FROM "Departments";
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
JOIN "Dept_emp" ON "Employees".emp_no = "Dept_emp".emp_no
JOIN "Departments" ON "Dept_emp".dept_no = "Departments".dept_no
WHERE "Departments".dept_name = 'Sales';

-- 7. List each employee in the Sales(d007) and Development (d005) departments, including their employee number, last name, first name, and department name.
SELECT * FROM "Departments";
SELECT "Employees".emp_no, "Employees".last_name, "Employees".first_name, "Departments".dept_name
FROM "Employees"
JOIN "Dept_emp" ON "Employees".emp_no = "Dept_emp".emp_no
JOIN "Departments" ON "Dept_emp".dept_no = "Departments".dept_no
WHERE "Departments".dept_no = 'd005' or "Departments".dept_no = 'd007';


-- 8. In descending order, list the frequency counts of all the employee last names, (i.e., how many "Employees" share each last name)
SELECT last_name, COUNT(last_name) AS "Frequency_Counts"
FROM "Employees"
GROUP BY last_name
ORDER BY "Frequency_Counts" DESC;