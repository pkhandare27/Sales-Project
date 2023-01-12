use project_group4;

/* Q1 */
create table Employee (
EmpNo int primary key,
EmpName char(255),
Job char(255) default "CLERK",
Manager int,
HireDate date,
Salary int check (Salary>0),
Commission int,
DeptNo int,
foreign key(DeptNo) references Dept (Dept_No));
insert into employee (empno, empname, manager, hiredate, salary, commission, deptno) values (7369, "SMITH", 7902, "1890-12-17", 800, null, 20);
insert into employee values (7499, "ALLEN", "SALESMAN", 7698, "1981-02-20", 1600, 300, 30), (7521, "WARD", "SALESMAN", 7698, "1981-02-22", 1250, 500, 30), (7566, "JONES", "MANAGER", 7839, "1981-04-02", 2975, null, 20), (7654, "MARTIN", "SALESMAN", 7698, "1981-09-28", 1250, 1400, 30), (7698, "BLAKE", "MANAGER", 7839, "1981-05-01", 2850, null, 30), (7782, "CLARK", "MANAGER", 7839, "1981-06-09", 2450, null, 10), (7788, "SCOTT", "ANALYST", 7566, "1987-04-19", 3000, null, 20), (7839, "KING", "PRESIDENT", null, "1981-11-17", 5000, null, 10), (7844, "TURNER", "SALESMAN", 7698, "1981-09-08", 1500, 0, 30), (7876, "ADAMS", "CLERK", 7788, "1987-05-23", 1100, null, 20), (7900, "JAMES", "CLERK", 7698, "1981-12-03", 950, null, 30), (7902, "FORD", "ANALYST", 7566, "1981-12-03", 3000, null, 20), (7934, "MILLER", "CLERK", 7782, "1982-01-23", 1300, null, 10); 

/* Q2 */
create table Dept (
Dept_No int primary key,
DeptName char(255),
Location char(255));
insert into dept values (10,"OPERATIONS","BOSTON"), (20,"RESEARCH","DALLAS"), (30,"SALES","CHICAGO"), (40,"ACCOUNTING","NEW YORK");

/* Q3- List the Names and salary of the employee whose salary is greater than 1000 */
select empname, salary from employee where salary>1000;

/* Q4- List the details of the employees who have joined before end of September 81 */
select * from employee where hiredate<"1981-09-30";

/* Q5- List Employee Names having I as second character */
select empname from employee where empname like "_i%";

/* Q6- List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns */
select empname Employee_Name, salary as Salary, salary*0.4 as Allowances, salary*0.1 as PF, salary*(1+0.4-0.1)+ifnull(commission,0) as Net_Salary from employee;

/* Q7- List Employee Names with designations who does not report to anybody */
select empname, job from employee where manager is null;

/* Q8- List Empno, Ename and Salary in the ascending order of salary */
select empno, empname, salary from employee order by salary asc;

/*Q9- How many jobs are available in the Organization */
select count(distinct job) as Number_Of_Jobs_Available from employee;

/*Q10- Determine total payable salary of salesman category */
select sum(salary+ifnull(commission,0)) as Total_Payable_Salary_for_All_Salesmen from employee where job="salesman";

/*Q11- List average monthly salary for each job within each department */
select deptno, job, avg(salary) from employee group by deptno,job order by deptno,job;

/*Q12- Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working */
select e.empname, e.salary, d.deptname from employee e join dept d on (e.deptno=d.dept_no);

/*Q13- Create the Job Grades Table */
create table Job_Grades (
grade char(255),
lowest_salary int,
highest_salary int);
insert into job_grades values ("A",0,999),("B",1000,1999),("C",2000,2999),("D",3000,3999),("E",4000,5000);

/*Q14- Display the last name, salary and  Corresponding Grade */
select e.empname, e.salary, g.grade from employee e left join job_grades g on (e.salary between g.lowest_salary and g.highest_salary);

/*Q15- Display the Emp name and the Manager name under whom the Employee works*/
select e1.empname as Employee, e2.empname as Manager from employee e1 join employee e2 on (e2.empno=e1.manager);
select concat(e1.empname," reports to " ,e2.empname) as Employee_Manager_Details from employee e1 join employee e2 on (e2.empno=e1.manager);

/*Q16- Display Empname and Total sal where Total Sal (sal + Comm) */
select empname as Employee, salary+ifnull(commission,0) as Total_Salary from employee;

/*Q17- Display Empname and Sal whose empno is a odd number */
select empno, empname, salary from employee where empno%2!=0;

/*Q18- Display Empname , Rank of sal in Organisation , Rank of Sal in their department */
select deptno, empname, salary, dense_rank () over (order by salary desc) as Salary_Rank, dense_rank () over (partition by deptno order by salary desc) as Dept_Salary_Rank from employee;

/*Q19- Display Top 3 Empnames based on their Salary */
select empname, salary from employee order by salary desc limit 3;

/*Q20- Display Empname who has highest Salary in Each Department */
select empname, salary, deptno from employee where salary in (select max(salary) from employee group by deptno);