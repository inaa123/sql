--from절에 테이블 두개 이상..........
select department_id, department_name, location_id
from departments;

select location_id, city
from locations; 

-- equi join의 하나로 natural join이 있음 ; 각부서가 어느 도시에 있는지 알고 싶을 때 JOIN한다.
select department_id, department_name, location_id, city
from departments natural join locations; -- 테이블 두개 필요. select절 -두개 칼럼에서 뽑은거니까

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

-- 과제] 위에서 누락된 1인의 이름, 부서번호를 조회하라.
select last_name, department_id
from employees
where department_id is null;

select employee_id, last_name, department_id, location_id
from employees natural join departments;

--칼럼 출처
select locations.city, departments.department_name
from locations join departments
using (location_id)
where location_id = 1400;

-- 테이블 별명 (지금까지 칼럼별명 select절 orderby절)
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400; 

--where절 별명가능? 가능은하지만 여기선 에러... (나중에 다시한대)
select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; --error using칼럼에 접두사붙였기 때문

--select절에서도 접두사 err.....
select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where location_id = 1400; --error
--using칼럼에는 접두사 붙이지 못한다.

select e.last_name, d.department_name
from employees e join departments d
using (department_id) -- department_id를 using칼럼으로 씀
where manager_id = 100; --manager_id 공통칼럼임, 그러나 using은 아님 그래도 err..
                        --error 이유 : manager_id가 어느 칼럼건지 애매하다..
select e.last_name, d.department_name
from employees e join departments d
using (department_id) 
where d.manager_id = 100; -- 위랑다르게 접두사 붙이니 실행.
--equi조인
---------------------------

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- equi 조인

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id; -- 필요한만큼 join - on 쓰면 된다.

-- 과제] 위 문장을 using으로 refactoring하라. 
select employee_id, city, department_name
from employees e join departments d
using (department_id)
join locations l
using(location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149; -- on만의특징 : 조건문n개있음, and로연결함.

-- 과제] Toronto에 위치한 부서에서 일하는 사원들의
--      이름, 직업, 부서번호, 부서명, city을 조회하라.
select e.last_name, e.job_id, e.department_id, 
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary --프로그래머만큼 돈 버는 사람들찾기
and j.job_id = 'IT_PROG';
--------------------------------------------------

--self join . 하나의테이블로조인해보기  (레코드 조인하는거임)
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;
--self join시 접두사 필수임

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; -- error

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; -- error

-- 과제] 같은 부서에서 일하는 사원들의 이름, 부서번호, 동료이름
select e.department_id, e.last_name employee, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

-- 과제] Davies보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date, d.hire_date
from employees e join employees d
on e.hire_date between d.min_hire_date and d.max_hire_date
and d.last_name = 'Davies';