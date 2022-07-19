--subquery 
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
-- query 안에 query , subquery는 개수 제한없다.

-- 과제] Kochhar 에게 보고하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where manager_id = (select employee_id --코차 상사에게 보고?
                    from employees
                    where last_name = 'Kochhar');

-- 과제] IT 부서에서 일하는 사원들의 부서번호, 이름, 직업을 조회하라.
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
--ernst와 직업이 같고 월급 더 많이 받는 애들 구하기
        
-- 과제] Abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라.
select last_name, hire_date
from employees
where department_id = (select department_id
                        from employees
                        where last_name = 'Abel') -- subqurey의 값이 하나기 때문에 가능
and last_name <> 'Abel'
order by last_name;

select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'King'); --error 동명이인King이 두명이기때문

--subquery 리턴값? 하나여야 함!

select last_name, job_id, salary
from employees
where salary = (select min(salary)
                from employees); -- 펑션의 리턴값 하나.
                
select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                        from employees
                        where department_id = 50);

-- 과제] 회사 평균 월급 이상을 버는 사원들의 사번, 이름, 월급을 조회하라.
--      월급 내림차순 정렬
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
where salary in (select min(salary) -- =연산자를 in으로 바꾸기
                    from employees
                    group by department_id);
                    
-- 과제] 이름에 u가 포함된 사원이 있는 부서에서 일하는 사원들의 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');

-- 과제] 1700번 지역에 위치한 부서에서 일하는 사원들의 이름, 직업, 부서번호를 조회하라.
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);


-- =any, any는 다른연산자와 결합해서 쓰임
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

-- all, 모두 다 성립해야 true, 4200(최소값)미만이면 true 
select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                        from employees
                        where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

-- 과제] 60번 부서의 일부(any) 사원보다 급여가 많은 사원들의 이름을 조회하라.
select last_name
from employees
where salary > any (select salary
                    from employees
                    where department_id = 60);

-- 과제] 회사평균 월급보다, 그리고 모든 프로그래머보다 월급을 더 받는 
--        사원들의 이름, 직업, 월급을 조회하라.
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
                
-- null, subquery에서 널이면 어떻게 될까?
select last_name
from employees
where employee_id in (select manager_id
                        from employees); -- 서부쿼리 널이어도 다른값이 있으면 그냥 출력됨~

select last_name
from employees
where employee_id not in (select manager_id
                         from employees); -- 아무도 안나옴.

--과제] 위 문장을 all 연산자로 refactoring하라. -- 다 다르다...
select last_name
from employees
where employee_id  <>all (select manager_id -- 다 다르다..
                        from employees);
--IN은 나열된 값 중 하나라도 일치하는 것, NOT IN은 하나도 일치하지 않는 것?
----------


---------------------
-- exist연산자
select count(*)
from departments;

select count(*)
from departments d
where exists (select *  --사원이 있는 부서
                from employees e
                where e.department_id = d.department_id);

select count(*)
from departments d
where not exists (select * -- 사원이 없는 부서
                    from employees e
                    where e.department_id = d.department_id);
                    
-- 과제] 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회하라.
select employee_id, last_name, job_id
from employees e
where exists (select *
                from job_history j
                where e.employee_id = j.employee_id)
order by employee_id;

select *
from job_history
order by employee_id;