Project Description:

* Generated detailed reports on employee information, performance, and project assignments to analyze the employee database and extract specific data based on various criteria.

Tasks Performed:

* Created an employee database and inserted data from `data_science_team.csv`, `proj_table.csv`, and `emp_record_table.csv`.
* Developed an ER diagram for the employee database.
* Wrote a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table and compiled a list of employees along with their department details.
* Created queries to:
  * Retrieve EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING for ratings:
    * Less than two
    * Greater than four
    * Between two and four
  * Concatenate the FIRST_NAME and LAST_NAME of employees in the Finance department and labeled the resultant column as NAME.
  * List employees who have direct reports, including the President, and show the number of reporters.
  * List all employees from the healthcare and finance departments using the UNION operation.
  * Retrieve employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING, grouped by department, including the maximum rating in each department.
  * Calculate the minimum and maximum salary of employees in each role.
  * Assign ranks to employees based on their experience.
  * Create a view displaying employees in various countries whose salary exceeds six thousand.
  * Use nested queries to find employees with more than ten years of experience.
  * Create a stored procedure to retrieve details of employees with over three years of experience.
  * Use stored functions to verify that the job profiles of data science team members match the organization’s standards:
    * Assign 'JUNIOR DATA SCIENTIST' for experience ≤ 2 years
    * Assign 'ASSOCIATE DATA SCIENTIST' for experience of 2 to 5 years
    * Assign 'SENIOR DATA SCIENTIST' for experience of 5 to 10 years
    * Assign 'LEAD DATA SCIENTIST' for experience of 10 to 12 years
    * Assign 'MANAGER' for experience of 12 to 16 years
* Created an index to improve query performance for finding employees with the FIRST_NAME ‘Eric’ in the employee table after analyzing the execution plan.
* Wrote a query to calculate employee bonuses based on ratings and salaries (using the formula: 5% of salary * employee rating).
* Wrote a query to calculate the average salary distribution based on continent and country.
