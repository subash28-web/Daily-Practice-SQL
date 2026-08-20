--creating table
CREATE TABLE emp_detail(
emp_id INT,
emp_name VARCHAR(60),
emp_dept VARCHAR(60),
emp_salary DECIMAL(10,2)
);

--insert the valuse
INSERT INTO emp_detail(emp_id ,emp_name ,emp_dept ,emp_salary)
VALUES(001,'ananth','HR',30000),(002,'bose','IT',50000),(003,'chandra','IT',70000),
(004,'dudu','HR',45000),(005,'elango','sales',60000);

--display the table
select * from emp_detail ;

--Display all employees whose salary is greater than 50,000
select * from emp_detail where emp_salary >50000 ;

--Find the highest salary.
select max(emp_salary) from emp_detail;

select * from emp_detail 
order by emp_salary DESC limit 1 ;

--Find the second highest salary.
select max(emp_salary) from emp_detail
where emp_salary < (select max(emp_salary) from emp_detail);

--Display the number of employees in each department.
select emp_dept,COUNT(*) as emp_count  from emp_detail
GROUP BY emp_dept ;

--Find the average salary of the IT department.
select AVG(emp_salary) as IT_avg_salary from emp_detail 
where emp_dept = 'IT'

--Display employees whose names start with ‘A’.
select emp_name from emp_detail
where emp_name LIKE 'a%'

--Write a query using ROW_NUMBER() and Write a query using RANK().
SELECT emp_id,emp_name,emp_dept,emp_salary,
ROW_NUMBER() OVER (ORDER BY emp_salary) as rowrank,
RANK()OVER(ORDER BY emp_salary) as rank1,
DENSE_RANK()OVER(ORDER BY emp_salary) as dense_rank
from emp_detail ;

--Write a query using a CTE to display employees with salary greater than the department average.
select emp_dept ,AVG(emp_salary) from emp_detail 
group by emp_dept 
having emp_salary < (select AVG(emp_salary) from emp_detail);


select emp_dept, emp_name,
AVG(emp_salary)over(PARTITION by emp_dept ) from emp_detail 
where  emp_salary > (select AVG(emp_salary) from emp_detail);


