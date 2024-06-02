/*Tak 1: creating employee database*/
CREATE DATABASE employee;

USE employee;

/*Task 3: List of employees and details of their department*/
SELECT emp_id, first_name, last_name, gender, dept
FROM emp_record_table
ORDER BY dept;

-- Task 4:List of employees and their details of their department
-- emp rating <2
SELECT emp_id, first_name, last_name, gender, dept, emp_rating
FROM emp_record_table
WHERE emp_rating<2;

-- emp rating >4
SELECT emp_id, first_name, last_name, gender, dept, emp_rating
FROM emp_record_table
WHERE emp_rating>4;

-- emp rating between 2 and 4
SELECT emp_id, first_name, last_name, gender, dept, emp_rating
FROM emp_record_table
WHERE emp_rating BETWEEN 2 AND 4;

/* TASK 5: concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME*/
SELECT CONCAT(first_name," ", last_name) AS name
FROM emp_record_table
WHERE dept = 'FINANCE';

-- TASK 6: to list only those employees who have someone reporting to them
SELECT  m.emp_id, m.first_name MGR_NAME, COUNT(e.first_name) AS reportees
FROM emp_record_table e, emp_record_table m
WHERE e.manager_id = m.emp_id
GROUP BY m.emp_id;

SELECT @@sql_mode;

SET @@sql_mode = SYS.LIST_DROP(@@sql_mode, 'ONLY_FULL_GROUP_BY');

SELECT @@sql_mode;

SELECT  m.emp_id, m.first_name MGR_NAME, COUNT(e.first_name) AS reportees
FROM emp_record_table e, emp_record_table m
WHERE e.manager_id = m.emp_id 
GROUP BY m.emp_id;

-- TASK 7:list down all the employees from the healthcare andfinance departments using union 
SELECT emp_id, first_name, dept FROM emp_record_table WHERE dept = 'HEALTHCARE'
UNION
SELECT emp_id, first_name, dept FROM emp_record_table WHERE dept = 'FINANCE';

/*TASK 8: List   down   employee   details   such   as   EMP_ID,FIRST_NAME,   LAST_NAME,   ROLE,   DEPARTMENT,   and   EMP_RATING grouped by dept. 
Also include the respective employee rating alongwith the max emp rating for the department*/
SELECT emp_id, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING, 
MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_EMP_RATING 
FROM emp_record_table;

-- TASK 9:To Calculate the minimum and the maximum salary ofthe employees in each role
SELECT emp_id, FIRST_NAME, LAST_NAME, ROLE, DEPT, salary, 
MIN(salary) OVER (PARTITION BY role) AS MIN_salary, 
MAX(salary) OVER (PARTITION BY role) AS MAX_salary
FROM emp_record_table;

-- TASK 10: Assign ranks to each employee based on their experience
SELECT emp_id, FIRST_NAME, LAST_NAME, ROLE, DEPT, exp, 
RANK() OVER(ORDER BY exp DESC) emp_exp_rank,
DENSE_RANK() OVER(ORDER BY exp DESC) emp_exp_dense_rank
FROM emp_record_table;

-- TASK 11: Create a view that displays employees in various countries whose salary is more than six thousand
CREATE VIEW v_emp AS
SELECT * FROM emp_record_table WHERE salary > 6000;

SELECT * FROM v_emp;

-- TASK 12: Nested query to find employees with experience of morethan ten years
SELECT e.emp_id, e.first_name, e.exp 
FROM emp_record_table e
WHERE e.emp_id IN
      (SELECT s.emp_id    
 FROM emp_record_table s    
 WHERE s.exp > 10);
 
  -- TASK 13: Create a stored procedure to retrieve the details ofthe employees whose experience is more than three years
 DELIMITER //
 CREATE PROCEDURE sp_emp()
 BEGIN
	  SELECT *
      FROM emp_record_table
      WHERE exp > 3;
END;
//DELIMITER ;

CALL sp_emp()

/* TASK 14: Write a query using stored functions in the project table to check
whether the job profile assigned to each employee in the data science team matches the organization’s set standard*/
DELIMITER //
CREATE FUNCTION fn_prof_match(e_id VARCHAR(4)) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
     -- Declaration of variables
     DECLARE exist_exp INT DEFAULT NULL;
     DECLARE exist_role VARCHAR(24) DEFAULT NULL;
     DECLARE set_role VARCHAR(24) DEFAULT NULL;
     
     -- Selecting experience and role from data_science_team table for the given employee id.
     SELECT exp, role INTO exist_exp, exist_role
     FROM data_science_team
     WHERE emp_id = e_id;
     
     -- Evaluating the existing experience and assigning role as per organization's set standard
     IF exist_exp <=2 THEN
				 SET set_role = "JUNIOR DATA SCIENTIST";
	 ELSEIF exist_exp > 2 AND exist_exp <= 5 THEN
                 SET set_role = "ASSOCIATE DATA SCIENTIST";
	 ELSEIF exist_exp > 5 AND exist_exp <= 10  THEN
                 SET set_role = "SENIOR DATA SCIENTIST";
	 ELSEIF exist_exp > 10 AND exist_exp <= 12  THEN
                 SET set_role = "LEAD DATA SCIENTIST";
	 ELSEIF exist_exp > 12 AND exist_exp <= 16  THEN
                 SET set_role = "MANAGER";
	 END IF;
     
    -- Compare set role to existing role and return the result based on profile matching
    IF exist_role = set_role THEN
				RETURN "Congratulations! Profile matches set standard.";
		  ELSE
                RETURN "Sorry! Profile doesn't match set standard.";
		  END IF;
          
	END;//
    DELIMITER ;
    
    SHOW FUNCTION STATUS WHERE db = 'employee';
    
    SELECT fn_prof_match('E005');
    
	SELECT fn_prof_match('E007');
    
    /* TASK 15: Write a query to create an index to improve the cost and performance of the query to find the employee 
    whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan*/
    -- Before creating an Index:
    SELECT * FROM emp_record_table WHERE first_name = 'Eric';
    
	-- Creating index:
    CREATE INDEX id_emp_fn ON emp_record_table(first_name(7));
    
	-- After creating an Index:
    SELECT * FROM emp_record_table WHERE first_name = 'Eric';



    

    


















