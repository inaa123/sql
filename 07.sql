--subquery 
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
-- query �ȿ� query , subquery�� ���� ���Ѿ���.

-- ����] Kochhar ���� �����ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id --���� ��翡�� ����?
                    from employees
                    where last_name = 'Kochhar');

-- ����] IT �μ����� ���ϴ� ������� �μ���ȣ, �̸�, ������ ��ȸ�϶�.
select department_id, last_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name = 'IT');

select last_name, job_id, salary
from employees
where job_id =(select job_id
                from employees
                where last_name = 'Ernst')
and salary > (select salary
                from employees
                where last_name = 'Ernst');
--ernst�� ������ ���� ���� �� ���� �޴� �ֵ� ���ϱ�
        
-- ����] Abel�� ���� �μ����� ���ϴ� ������� �̸�, �Ի����� ��ȸ�϶�.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel') -- subqurey�� ���� �ϳ��� ������ ����
and last_name <> 'Abel'
order by last_name;

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'King'); --error ��������King�� �θ��̱⶧��

--subquery ���ϰ�? �ϳ����� ��!

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees); -- ����� ���ϰ� �ϳ�.
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- ����] ȸ�� ��� ���� �̻��� ���� ������� ���, �̸�, ������ ��ȸ�϶�.
--      ���� �������� ����
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                    from employees)
order by salary desc;
-----------------------------------

select employee_id, last_name
from employees
where salary = (select min(salary)
                from employees
                group by department_id); -- error

select employee_id, last_name
from employees
where salary in (select min(salary) -- =�����ڸ� in���� �ٲٱ�
                    from employees
                    group by department_id);
                    
-- ����] �̸��� u�� ���Ե� ����� �ִ� �μ����� ���ϴ� ������� ���, �̸��� ��ȸ�϶�.
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- ����] 1700�� ������ ��ġ�� �μ����� ���ϴ� ������� �̸�, ����, �μ���ȣ�� ��ȸ�϶�.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);


-- =any, any�� �ٸ������ڿ� �����ؼ� ����
select employee_id, last_name
from employees
where salary =any (select min(salary)
                    from employees
                    group by department_id);

select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                        from employees
                        where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

-- all, ��� �� �����ؾ� true, 4200(�ּҰ�)�̸��̸� true 
select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                        from employees
                        where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

-- ����] 60�� �μ��� �Ϻ�(any) ������� �޿��� ���� ������� �̸��� ��ȸ�϶�.
select last_name
from employees
where salary > any (select salary
                    from employees
                    where department_id = 60);

-- ����] ȸ����� ���޺���, �׸��� ��� ���α׷��Ӻ��� ������ �� �޴� 
--        ������� �̸�, ����, ������ ��ȸ�϶�.
select last_name, job_id, salary
from employees
where salary > (select avg(salary)
                from employees)
and salary > all (select salary
                    from employees
                    where job_id = 'IT_PROG');
-----------------

-- no row
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);

select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');
                
-- null, subquery���� ���̸� ��� �ɱ�?
select last_name
from employees
where employee_id in (select manager_id
                        from employees); -- �������� ���̾ �ٸ����� ������ �׳� ��µ�~

select last_name
from employees
where employee_id not in (select manager_id
                         from employees); -- �ƹ��� �ȳ���.

--����] �� ������ all �����ڷ� refactoring�϶�. -- �� �ٸ���...
select last_name
from employees
where employee_id  <>all (select manager_id -- �� �ٸ���..
                        from employees);
--IN�� ������ �� �� �ϳ��� ��ġ�ϴ� ��, NOT IN�� �ϳ��� ��ġ���� �ʴ� ��?
----------


---------------------
-- exist������
select count(*)
from departments;

select count(*)
from departments d
where exists (select *  --����� �ִ� �μ�
                from employees e
                where e.department_id = d.department_id);

select count(*)
from departments d
where not exists (select * -- ����� ���� �μ�
                    from employees e
                    where e.department_id = d.department_id);
                    
-- ����] ������ �ٲ� ���� �ִ� ������� ���, �̸�, ������ ��ȸ�϶�.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;

select *
from job_history
order by employee_id;