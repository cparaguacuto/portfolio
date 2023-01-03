use human_resources;
/*1. List all employees who work in the Engineering department within the Austin 
office. Report their employee ID, first name, last name, department, and office city.*/
#
select
	employees.emp_id,
    employees.first_name,
    employees.last_name,
	departments.dept_name,
    offices.city
from employees
left join offices on employees.office_id = offices.office_id
left join departments on employees.dept_id = departments.dept_id
where offices.city = 'Austin'
	and departments.dept_name = 'Engineering';

    
/*2. List all employees who have a role title of “Vice President”.  Report their 
employee ID, first name, last name, and role title.*/

select
	emp_id, 
	first_name,
	last_name,
    role_title
from employees
inner join roles on employees.role_id = roles.role_id
	where role_title = 'Vice President';
    
/*3. List all female employees with the job title of “Director” in the Engineering 
department. Report their first name, last name, role title, department name, and 
office city.*/

select
	employees.first_name,
	employees.last_name,
    roles.role_title,
    dept_name,
    offices.city
from employees
left join departments on employees.dept_id = departments.dept_id
left join roles on employees.role_id = roles.role_id
left join offices on employees.office_id = offices.office_id
where dept_name = 'Engineering'
		and role_title = 'Director';
        
/*4. List all employees who work in either the Beijing or Miami offices and also 
work in the Accounting department. Report their first name, last name, office city, 
and department name.*/

select 
	employees.first_name,
    employees.last_name,
    offices.city,
    departments.dept_name
from employees
inner join offices on employees.office_id = offices.office_id
inner join departments on employees.dept_id = departments.dept_id
where city in ('Beijing', 'Miami')
	and departments.dept_name = 'Accounting';
    
		
/*5. Report all employees at the company who have the letter “c” as the third letter 
of their last name. Report their first name and last name.*/

select
	employees.first_name,
    employees.last_name
from employees
where last_name like '__c%';

/*6. Report all role titles that have a bonus of at least 10%. Report role title, salary 
range minimum, salary range maximum, and bonus percentage. (Note that you do 
not need to reformat any of these values.)*/

select 
	role_title,
    salary_range_min,
    salary_range_max,
    bonus_perc
from roles
where bonus_perc >= 0.10;

/*7. List all employees who work in the Finance department in the Phoenix office, 
along with their monthly base salary. Report their first name, last name, 
department name, office city, annual base salary, and monthly base salary 
(“monthly_base_sal”).*/
#name of roles.salary column
select
	employees.first_name,
    employees.last_name,
    departments.dept_name,
    offices.city,
    roles.salary_range_min/12
from employees
inner join departments on employees.dept_id = departments.dept_id
inner join roles on employees.role_id = roles.role_id
inner join offices on employees.office_id = offices.office_id
where dept_name = 'Finance'
	and city = 'Phoenix';

/*8. Report the number of employees who work within each department. Provide 
the name of each department as well as the number of employees for each given 
department (“employee_count”). Departments should be ordered by highest 
number of employees to lowest number of employees.*/

select 
	departments.dept_name,
    count(distinct employees.emp_id) as employee_count
from employees
left join departments on employees.dept_id = departments.dept_id
group by departments.dept_id
order by employee_count DESC;
    
    
/*9. List each department and their average base salaries. Order your results by 
highest to lowest average base salary. Report average base salary with a dollar sign 
($) and round to the nearest dollar.  */

select
	departments.dept_name,
    concat('$',round(avg(employees.annual_base_sal))) as average_base
from departments
inner join employees on departments.dept_id = employees.dept_id
group by departments.dept_name
order by average_base desc;

/*10. List each employee who makes a base salary of $100,000 or more per year. 
Report their first name, last name, and annual base salary.*/

select 
	first_name,
    last_name,
    annual_base_sal
from employees 
where annual_base_sal >= 100000;

    
/*11. List each role’s average annual base salary. Restrict your results to those roles 
that have an average base salary of $90,000 or higher. Report role title, average 
annual base salary (“avg_annual_base_sal”)*/


select
	roles.role_title,
    avg(annual_base_sal) as avg_annual_base_sal
from employees
left join roles on employees.role_id = roles.role_id
group by roles.role_title
having avg_annual_base_sal >= 90000;

    
/*12. Create a list of each employee (emp_id, first_name, last_name) as well as a 
column called “bonus” that indicates whether that employee receives an 
annual bonus (with values of “Y” for yes and “N” for no). */

select
	emp_id, 
    first_name,
    last_name,
    case when bonus_perc is not null then 'Y'
		else 'N'
end as bonus
from employees
left join roles on employees.role_id = roles.role_id;


/*13. Create a copy of your “employees” table and call it “employees_2”. In this table, 
include all columns and records from “employees”, but add a column called “age”. 
Populate this column with each employee’s age (in years).*/
  
create table employees_2 as select
	*,
    datediff(current_date, dob)/365.25 as age
from employees;


	
/*14. Create a table called “employee_salary”. In this table, include each employee’s 
employee ID, first name, last name, annual base salary, and bonus percentage.,. Also 
include the following additional columns: 
 “bonus_amt” (employee’s bonus amount in dollars)
  “total_annual_comp” (employee’s total annual compensation including base 
salary and bonus)*/

create table employee_salary as select
	employees.emp_id,
    employees.first_name,
    employees.last_name,
    employees.annual_base_sal,
    roles.bonus_perc,
    bonus_perc*annual_base_sal as bonus_amt,
   (bonus_perc*annual_base_sal)+annual_base_sal as total_annual_comp
from employees
left join roles on employees.role_id = roles.role_id;


/*15. List all roles that have a salary range minimum that is less than $50,000. 
Report role_title, salary_range_min, and salary_range_max. Order your results by 
salary_range_min (lowest to highest).*/

select
	roles.role_title,
    roles.salary_range_min,
    roles.salary_range_max
from roles
where salary_range_min < 50000
order by salary_range_min;

/*16. List all roles that have a salary range maximum that is at least $50,000 greater 
than the salary range minimum. Report role_title, salary_range_min, and 
salary_range_max. Order your results by salary_range_max (highest to lowest).*/

select
	role_title,
    salary_range_min,
    salary_range_max
from roles
where salary_range_max-salary_range_min >= 50000
order by salary_range_max DESC;

/*17. List the salary ranges for each role title. List the role title, salary range minimum, 
salary range maximum, and salary range. Order your results by largest salary range 
to smallest salary range. Round all dollar amounts to the nearest dollar.*/

select
	role_title,
    salary_range_min,
    salary_range_max,
    round(salary_range_max-salary_range_min) as salary_range
from roles
order by salary_range DESC;

 
/*18. Create a list of each employee who works in the Austin office (include first 
name and last name columns), along with their full office mailing address in 
the following format: First Name Last Name, Address 1, Address 2, City, State, 
Country Postal Code. (Example: John Smith, 14 Oak Drive, Suite 202, Rochester, New 
York, USA 10026)
(Note that some fields have commas between them, and some do not.)*/

select
	concat(first_name,' ',last_name,' ',', ',address_1,' ',',', address_2 ,' ',',', city,' ',',', state_province,' ',',',country,'', postal_code)
from employees
left join offices on employees.office_id = offices.office_id
where city = 'Austin';


/*19. Pull a list of all employees with their respective role title and department in the 
following format: 
[FIRST INITIAL]. [ LAST NAME], [ROLE_TITLE], [DEPARTMENT]
E.g.: J. SMITH, VICE PRESIDENT, SALES
(Note all caps)*/

select
	upper(concat(substr(first_name, 1, 1),'.',' ', last_name,' ', role_title,' ', dept_name))
from employees
left join roles on employees.role_id = roles.role_id
left join departments on employees.dept_id = departments.dept_id;

/*20. Create a table called “current_employees” that includes all data from the 
“employees” table but is restricted to employees who currently work at the 
company. (Hint: It is possible that all employees in the database currently work at the 
company.) */
#ask her
create table current_employees as select
	*
from employees
where exit_date is not null;

select * from current_employees;

/*21. BONUS (+5 POINTS): Report each office’s city along with the percentage of its 
employees who are female, male, and unspecified (perc_female, perc_male, 
perc_unspec). Exclude NULL values from your denominator. (HINT: you are allowed 
to write multiple queries/create multiple tables to achieve the required results.)*/



/*22. Next year, the company will be providing 3.5% raises to each employee’s base 
salary. Calculate each employee’s new base salary in a column called 
“base_salary_2023”. In your results, report each employee’s first name, last name, 
current base salary (as “base_salary_2022”) and “base_salary_2023”.*/

select
	first_name,
    last_name,
    annual_base_sal,
    annual_base_sal*(1+0.035) as base_salary_2024
from employees;
    
/*23. List all employees who have a first name that starts with the letter “J” and a 
last name that starts with the letter “R”. Include their emp_id, first_name, and 
last_name in your results.*/

select 
	emp_id,
    first_name,
    last_name
from employees
where first_name like 'J%' 
	and last_name like 'R%';

/*24. Calculate the number of years that each employee has worked at the company 
(“employment_years”) as of the day that you conduct the query. Report the 
employee’s emp_id, first_name, last_name and employment_years.*/

select
	employees.emp_id,
    employees.first_name,
    employees.last_name,
	datediff(current_date, employees.hire_date)/365.25 as employment_years
from employees;


/*25. Report the number of employees within each combination of office and 
department. Report the office_city, dept_name, and employee_count. */

select 
	offices.city,
    departments.dept_name,
    count(distinct emp_id) as employee_count
from employees 
left join offices on employees.office_id = offices.office_id
left join departments on employees.dept_id = departments.dept_id
group by departments.dept_name, offices.city;
    
/*26. Report all employees who were hired between 1/1/19 and 6/30/19. Report 
emp_id, first_name, last_name, and hire_date.*/

select 
	employees.emp_id,
    employees.first_name,
    employees.last_name,
    employees.hire_date
from employees
where date(employees.hire_date) between '2019-01-01' and '2019-06-30';

/*27. Report all employees who were hired in the month of January of any year. 
Report emp_id, first_name, last_name, and hire_date.*/

select
	first_name,
    last_name,
    hire_date
from employees
where month(hire_date) = 01;

/*28. You have been asked to determine if the average annual base salary is greater 
for Computer Systems Managers or System Administrators. Calculate the 
average base salary for each role. Report the role_title and “avg_base_sal”.*/

select
	roles.role_title,
    avg(employees.annual_base_sal) as avg_base_sal
from employees
inner join roles on employees.role_id = roles.role_id
where role_title in ('Computer Systems Manager', 'System Administrator')
group by roles.role_title;

/*29. Create a copy of the “offices” table and call it “offices_2”. In this table, include all 
columns and records from “offices”, but add an additional column called 
“continent”.  Populate this column with the continent that the given office is in.*/

create table offices_2 as select
	*,
    case when offices.country = 'USA' then 'North America'
		when offices.country = 'China' then 'Asia'
        when offices.country = 'Brazil' then 'South America'
end as continent
from offices;

select * from offices_2;