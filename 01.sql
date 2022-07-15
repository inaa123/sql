select * from departments;

select demartment_id, location_id
from departments;

--칼럼의 순서바꿀 수 있음
select location_id, department_id
from departments;

desc departments

--과제] employees 구조를 확인하라.
desc employees

--salary + 300 내가 만들 수 있음
select last_name, salary, salary + 300
from employees;
--과제] 사원들의 월급, 연봉을 조회하라.

select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 *( salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees; 

select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees; --버그 영업직말고 다른데는 빈셀 -> 한값이라도 null이면 null이나옴.(테이블설계 잘못함)  

--내 테이블 칼럼명에 별명 붙이기 (가독성위해)
select last_name as name, commission_pct comm --as는 생략가능
from employees;
--대소문자 구분하는법 " " 안에 작성 (띄어쓰기도 포함됨~) 잘안씀귀찮음
select last_name "Name", salary * 12 "Annual Salary"
from employees;

--과제] 사원들의 사번, 이름, 직업, 입사일(SRATRDATE)을 조회하라.
select employee_ID, last_name, job_Id, hire_date startdate
from employees;
--과제] 사원들의 사번(Emp #), 이름(Name), 직업(Job), 입사일(Hire Date)을 조회하라.
select employee_ID "Emp #", last_name "Name", job_Id "Job", hire_date "Hire Date"
from employees;

--붙이기 연산자. 하나의 칼럼으로 합치기
select last_name || job_id
from employees;
--select절에 상수 쓸수있음, 문자상수는 작은따옴표 ' '
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;
select last_name || null --하나의 수식 , 붙이기연산자는 널값을 취급x, 
from employees;
select last_name || commission_pct --여기서 1.4같은거는 숫자아닌문자임
from employees;
select last_name || salary --문자와 숫자 붙이기
from employees;
select last_name || hire_date --문자와 날짜 붙이기
from employees;
select last_name || (salary * 12) --수식의 리턴값을 문자로 붙이기
from employees;


--과제] 사원들의 '이름, 직업'을 조회하라. 별명은
select last_name || ', ' || job_id "(Emp and Title)"
from employees;