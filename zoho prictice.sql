--CREATE SCHEMA zoho_practice;

--SET search_path TO zoho_practice;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    joining_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    emp_id INT,
    customer_name VARCHAR(50),
    amount INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO employees VALUES
(101,'Arun','IT',50000,'Chennai','2022-01-15'),
(102,'Priya','HR',45000,'Coimbatore','2021-05-20'),
(103,'Karthik','Sales',40000,'Madurai','2023-03-10'),
(104,'Divya','IT',60000,'Chennai','2020-11-01'),
(105,'Rahul','Finance',55000,'Salem','2021-07-18'),
(106,'Sneha','HR',42000,'Trichy','2022-09-12'),
(107,'Vijay','Sales',38000,'Chennai','2023-01-05'),
(108,'Anitha','IT',65000,'Coimbatore','2019-08-22'),
(109,'Ramesh','Finance',70000,'Madurai','2018-12-30'),
(110,'Meena','Sales',39000,'Salem','2024-02-14'),
(111,'Kiran','IT',52000,'Chennai','2021-06-11'),
(112,'Deepa','HR',46000,'Trichy','2022-04-19'),
(113,'Suresh','Finance',58000,'Coimbatore','2020-10-10'),
(114,'Nisha','IT',62000,'Madurai','2023-07-25'),
(115,'Ajay','Sales',41000,'Chennai','2021-09-09'),
(116,'Keerthi','HR',44000,'Salem','2022-02-02'),
(117,'Bala','Finance',75000,'Trichy','2019-03-30'),
(118,'Harini','IT',68000,'Coimbatore','2024-01-01'),
(119,'Prakash','Sales',43000,'Madurai','2020-06-15'),
(120,'Lavanya','HR',47000,'Chennai','2023-11-20');

INSERT INTO orders VALUES
(201,101,'ABC Ltd',25000,'2024-01-10','Delivered'),
(202,103,'XYZ Pvt',18000,'2024-01-12','Pending'),
(203,104,'Infosys',45000,'2024-01-15','Delivered'),
(204,107,'TCS',12000,'2024-01-18','Cancelled'),
(205,105,'Wipro',30000,'2024-01-20','Delivered'),
(206,108,'HCL',50000,'2024-02-01','Pending'),
(207,109,'Zoho',35000,'2024-02-05','Delivered'),
(208,111,'Google',27000,'2024-02-08','Delivered'),
(209,112,'Amazon',22000,'2024-02-10','Pending'),
(210,114,'Microsoft',41000,'2024-02-12','Delivered'),
(211,115,'Flipkart',15000,'2024-02-15','Cancelled'),
(212,116,'Paytm',21000,'2024-02-18','Delivered'),
(213,117,'Swiggy',33000,'2024-02-20','Pending'),
(214,118,'Zomato',47000,'2024-02-22','Delivered'),
(215,119,'Oracle',29000,'2024-02-25','Delivered'),
(216,120,'IBM',26000,'2024-03-01','Pending'),
(217,101,'Capgemini',32000,'2024-03-05','Delivered'),
(218,103,'Cognizant',28000,'2024-03-08','Cancelled'),
(219,104,'Accenture',39000,'2024-03-10','Delivered'),
(220,109,'Dell',36000,'2024-03-15','Pending');

INSERT INTO employees VALUES
(121,'Arun','IT',50000,NULL,'2024-04-10'),         -- Duplicate name, NULL city
(122,'Priya','HR',45000,'Chennai','2023-08-15'),   -- Duplicate name & salary
(123,'Manoj',NULL,38000,'Madurai','2024-01-20'),   -- NULL department
(124,'Kavi','Sales',NULL,'Trichy','2022-12-01'),   -- NULL salary
(125,'Rani','Finance',55000,'Salem','2021-07-18'); -- Duplicate salary & joining_date

INSERT INTO orders VALUES
(221,121,'ABC Ltd',25000,'2024-04-15','Delivered'), -- Duplicate customer & amount
(222,122,'Amazon',NULL,'2024-04-18','Pending'),     -- NULL amount
(223,123,'Zoho',30000,'2024-04-20',NULL),           -- NULL status
(224,121,'ABC Ltd',25000,'2024-04-21','Delivered'), -- Duplicate customer & amount
(225,125,'TCS',18000,'2024-04-25','Cancelled');

select * from employees;

select * from orders;

--Easy (1–10)

--1.Display all employee details.
select * from employees; 

--2.Display only emp_name and salary.
select emp_name,salary from employees;

--3.Find employees whose salary is greater than 50,000.
select * from employees 
where salary >50000 
order by salary ASC;

select emp_id,emp_name,salary from employees
where salary >50000 
order by salary ASC;

--4.Find employees who belong to the IT department.
select emp_id,emp_name,department from employees 
where department ='IT';

--5.Display employees from Chennai.
select emp_id,emp_name,department,city from employees
where city  ='Chennai';

select emp_name,department,city from employees where city  like 'C%i';--just try

--6.Find employees who joined after 2022-01-01.
select emp_name,department,city,joining_date from employees
where joining_date >'2022-01-01' 
order by joining_date ASC;

--7.Sort employees by salary in descending order.
select emp_id,emp_name,department,city,salary from employees 
order by salary DESC ;

--8.Find the highest salary.
select max(salary) as maxsalary from employees;

select emp_id,emp_name,department,city,salary from employees 
order by salary DESC LIMIT 1;

select department,max(salary) as highsalary from employees 
group by department; 
 
--9.Find the lowest salary.
select min(salary) as minsalary from employees ;

select emp_id,emp_name,department,city,salary from employees 
order by salary ASC LIMIT 1;

--10.Count the total number of employees.
select count(emp_name) as total_emp from employees;

--Medium (11–20)

--11.Find the average salary of each department.
select department ,AVG(salary)from employees
GROUP BY department ;

--12.Count the number of employees in each department.
select department ,COUNT(emp_id)from employees 
GROUP BY department ;

--13.Find departments having more than 4 employees.
select department ,COUNT(emp_id) as dept_totat_emp from employees
GROUP BY department
HAVING COUNT(emp_id) > 4;  

--14.Display employee names with their order amount using INNER JOIN.
select emp_name,amount from employees as e join orders as o
on e.emp_id=o.emp_id ;

--15.Find employees who have no orders.


--16.Find the total order amount handled by each employee.
select emp_id,order_id,order_date,customer_name,amount,
SUM(amount)over(PARTITION by emp_id ORDER BY amount) as rollingsum
from orders;

select emp_id,sum(amount) as total_order_amount from orders
group by emp_id
order by emp_id ASC;


select emp_id,order_id,
SUM(amount)over(PARTITION by emp_id ORDER BY amount) as rollingsum
from orders;

--17.Find the employee with the highest total order amount.
select emp_id,order_id,order_date,customer_name,
SUM(amount)over(PARTITION by emp_id ORDER BY amount) as rollingsum
from orders order by SUM(amount)over(PARTITION by emp_id ORDER BY amount) DESC limit 2 ;

select emp_id,order_id,order_date,customer_name,
SUM(amount)over(PARTITION by emp_id ORDER BY amount) as rollingsum
from orders order by rollingsum DESC limit 2 ;


--18.Display only orders with status Delivered.
select order_id,emp_id,amount,status from orders where status = 'Delivered';

--19.Find the total number of Delivered, Pending, and Cancelled orders.
select status ,count(status) as total_status from orders
GROUP BY status ;

--20.Find employees whose salary is greater than the average salary.
select emp_name,salary from employees 
where salary>(select AVG(salary) as avg_salary from employees);

select emp_name,salary from employees 
where salary>(select AVG(salary) as avg_salary from employees)
order by salary DESC limit 1;

--Hard (21–30)

--21.Find the second highest salary.
select max(salary) from employees
where salary <(select max(salary) from employees);

--22.Find the third highest salary.
select max(salary) from employees 
where salary <(select max(salary) from employees 
where salary <(select max(salary) from employees));

--23.Find the top 3 highest-paid employees.
select emp_id,emp_name,salary from employees
order by salary DESC limit 3;

--24.Rank employees based on salary using RANK().
select emp_id,emp_name,department,salary,
RANK()OVER(order by salary) as ranks from employees;

--25.Display the department-wise highest-paid employee.
select emp_id,emp_name,department,salary,
Row_number()over(PARTITION BY department ORDER BY salary DESC) as rowrank
from employees;

select emp_name,department,salary from employees
group by emp_name,department,salary
order by department,salary DESC;

--26.Find employees who have handled more than one order.
select emp_id,count(order_id) as total_order from orders
group by emp_id
having count(order_id) > 1

--27.Find the month with the highest total order amount.

--28.Display employees whose order amount is greater than 30,000.
select emp_id,order_id,amount from orders
where amount >30000 order by amount ASC;

--29.Find the employee who handled the maximum number of orders.
select emp_id,count(order_id) as total_order from orders
group by emp_id
order by total_order DESC
limit 1 ;
--30.Find employees whose salary is higher than every employee in the HR department.

