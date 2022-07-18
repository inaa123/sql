--group function 그룹함수들은 다 null값을 무시함!
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

--날짜에도 가능, 최근일이 max
select min(hire_date), max(hire_date)
from employees;

-- 과제] 최고월급과 최소월급의 차액을 조회하라.
select max(salary) - min(salary)
from employees;


-- *은 모든칼럼을 뜻함, count만 * 모두 가능?
select count(*) 
from employees; --사원수 몇명이야?

-- 과제] 70번 부서원이 몇명인지 조회하라.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- 과제] 조직의 평균 커미션율을 조회하라.

select avg(nvl((commission_pct),0))
from employees;
-----------------------------------------

select avg(salary)
from employees; 

select avg(distinct salary) 
from employees; --중복제거

select avg(all salary)
from employees; -- all생략가능

--과제 ] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

select count(distinct manager_id)
from employees; -- 조직에 매니저 몇명인지 파악 가능
-------------------------------------

--그룹의 개수를 n개로
--select절의 칼럼은 그룹의 레이블이다.
select department_id, count(employee_id) --두번째 필드는 카운터 리턴값을 ..
from employees
group by department_id -- 부서번호가 같은 녀석들 끼리 그룹을 짓는다.
order by department_id;


select employee_id
from employees
where department_id = 30;

select employee_id, job_id, count(employee_id)
from employees
group by department_id -- group by 절에 있는 거만 select절에 쓸 수 있다.
order by department_id; -- error select절에 일반칼럼과 그룹칼럼 쓸때 일반칼럼은 레이블이 목적?이지만 그룹칼럼은 레이블의 목적을 할 수 없음.

-- 과제] 직업별 사원수를 조회하라. --직업별이 레이블
select job_id, count(employee_id)
from employees
group by job_id;
--------------------

select department_id, max(salary) 
from employees
group by dapartment_id
having department_id > 50; --그룹골라낼땐 having씀

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal 
from employees
group by dapartment_id
having max_sal > 10000; --error having에선 별명못씀

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error where 조건문에 그룹펑션있으면 having쓴다.  having은 그룹을 골라낸다.

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%' --레코드 골라내기
group by job_id --골라낸 레코드로 그룹짓기
having sum(salary) > 13000 --그룹 골라내기
order by payroll;

-- 과제] 매니저ID, 매니저별 관리 직원들 중 최소월급을 조회하라.
--      최소월급이 $6,000 초과여야 한다.
select manager_id, min(salary)
from employees
where manager_id is not null  --managerid널값 빼야함
group by manager_id
having  min(salary) > 6000
order by 2 desc;

-----------------------------------
select max(avg(salary)) --중첩사용)
from employees
group by department_id; 
--n개의 그룹에서 avg(salary)가 n번 실행되어 avg() n개의 레코드가 max의 파라미터가 되어max()가 한번실행

select sum(max(avg(salary)))
from employees
group by department_id; -- error, to deeeply , 너무깊게들어감. (중첩많음)
--group함수는 두개까지 중첩 가능!

--single과 group 중첩
select department_id, round(avg(salary))
from employees
group by department_id;
--avg함수에 n개의 레코드가 들어감(n개의 레코드 리턴), round()는 n개를 다 실행(n번실행)

select department_id, round(avg(salary))
from employees; -- error, group by절이 없음, 싱글과 그룹을 같이쓸땐 그룹바이 써야함!

-- 과제] 2001년, 2002년, 2003년도별 입사자 수를 찾는다.
--2001년이면 1 아니면 0, 합하면 2001년 수 나옴. decode로 

select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- 직업별, 부서별 월급합을 조회하라.
--          부서는 20, 50, 80이다.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
    
        

