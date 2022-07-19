-- set (집합)
select employee_id, job_id -- 숫자, 문자
from employees;

select employee_id, job_id -- 숫자, 문자 -> 위와 테이블 구조가 같다.
from job_history;
--구조가 같은 위 두 테이블을 합한다. 합집합 union

select employee_id, job_id 
from employees
union -- 115개, 중복제거됨  --과거의 직업과 현재의 직업이 같은사람
select employee_id, job_id 
from job_history;

select employee_id, job_id 
from employees
union all -- 117개 나옴
select employee_id, job_id 
from job_history;

-- 과제] 과거 직업을 현재 갖고 있는 사원들의 사번, 이름, 직업을 조회하라.
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

select employee_id, job_id 
from employees
intersect -- 교집합
select employee_id, job_id 
from job_history;

select employee_id, job_id 
from employees
minus --차집합
select employee_id, job_id 
from job_history;
-------------------------

select location_id, department_name
from departments
union
select location_id, state_province
from locations;
--퍼시스턴스 관점에선 아무문제 없음(다 문자), 서비스 관점에선 문제 있음(부서명과 주 명이 섞여있다.)

-- 과제] 위 문장을 service 관점에서 고쳐라.
select location_id, department_name, null satate --null이란 상수 포함시키기
from departments
union 
select location_id, null, state_province
from locations;

-- 과제] 위 문장을 persistence 관점에서 고쳐라. (데이터타입이 일치해야한다.)
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 -- null을 써도 정답!
from job_history
order by salary;