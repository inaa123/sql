-- single function

desc dual
select * from dual; -- 레코드 하나를 리턴 받은 것! (레코드가 필드1로 구성된 것뿐임)
--single function 은..

select lower('SQL Course') --lower function은 파라미터로 받은 것을 소문자로 바꿔줌
from dual; -- 해당 칼럼 존재하지 않.,.....몰라

select upper('SQL Course')
from dual;

select initcap('SQL course') -- 첫글자를 대문자로 바꿈
from dual; 

-- SQL은 대소문자 구분안해도 되지만, 데이터는 대소문자 구분해야한다 연습
select last_name
from employees
where last_name = 'higgins'; -- 히긴스는 있지만 소문자 히긴스는 없는것.
select last_name
from employees
where last_name = 'Higgins'; -- 데이터는 대소문자 구분해야함!
-- 대소문자 구분시 싱글펑션쓰기!!
select last_name
from employees
where lower(last_name) = 'higgins'; -- last_name필드값을 소문자로바꾸기
-- lower펑션의 리턴값이 필드값. ??????????
-- last_name 필드가 가지고 있는 레코드 통으로 들어갔는데 lower function에 의해 나설렝? 
-- 레코드가 필드로 들어갔다............. 소문자 higgins가 들어간 레코드가 달랑 하나 리턴된거.....
--lower function은 이 쿼리를 작동하면서 몇번 실행했을까? 107번 ...
-- why? 파라미터로 하나만받을수있음. 107개를 한번에 받을 수 없어서.. 107번(레코드개수만큼)실행

--문자를 다루는 function
select concat('Hello', 'World')
from dual;

--SQL은 인덱스 1부터 시작함.
select substr('HelloWorld', 2, 5) --두번째파라미터 : 자르기시작할 인덱스, 세번째: 문자개수
from dual;
select substr('Hello', -1, 1) -- 뒤에서부터 뜯어낼때 -붙이기
from dual;

select length('Hello') -- 글자 수
from dual;

select inStr('Hello', 'l') -- 처음발견된 L의 인덱스 리턴하고 끝
from dual;
select inStr('Hello', 'w')
from dual; -- w는 없는값이어서 0 =>나중에 문자 있는지없는지 판단 가능 0보다 크면 값이 있고 0보다 작으면 없음

--salary 5자리로 통일
select lpad(salary, 5, '*') -- 왼쪽을 채움
from employees;
select rpad(salary, 5, '*') -- 오른쪽 채움
from employees;

-- 과제] 사원들의 이름, 월급그래프를 조회하라. 
-- 그래프는 $1000 당 * 하나를 표시한다.
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- 과제] 위 그래프를 월급 기준 내림차순 정렬하라.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')  -- 뜯어낸다. 머리부분 꼬리부분 신경씀
from dual;
select trim('l' from 'Hello') -- 몸통은 신경안씀
from dual;
select trim (' ' from ' Hello ')
from dual;
--과제 ] 위 query에서 ' '가 trim됐음을 눈으로 확인할 수 있게 조회하라.
select '|' || trim (' ' from ' Hello ') || '|'  
from dual;
-- 더 간단한 ,trim
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- 과제] 아래 문장에서 WHERE절을 like로 refactoring하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- 과제] 이름이 J나 A나 M으로 시작하는사원들의 이름, 이름의 글자수를 조회하라.
-- 이름은 첫글자는 대문자, 나머지는 소문자로 출력한다.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
-------------------------------------- 지금까지 문자를 다루는 function
--숫자를 다루는 function
select round(45.926, 2) -- 소숫점이하 2번째 자리에서 반올림한다.
from dual;
select trunc(45.926, 2) -- 내림?
from dual;
select mod(1600, 300) -- 나머지
from dual;

select round(45.923, 0), round(45.923) -- 정수로 만드는 법, 0 생략가능
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;

-- 과제] 사원들의 이름, 월급, 15.5% 인상된 월급(New salary, 정수), 인상액을 조회하라.
select last_name, salary, round(salary * 1.155) "New salary",
    round(salary * 1.155) - salary "Incerease" 
from employees;
-------------------------숫자끝

select sysdate -- 서버의 시각
from dual;

select sysdate +1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

-- 과제] 아래 문장을 고쳐서, 사원이름, 근속연수를 조회하라.
select last_name, trunc((sysdate - hire_date) / 365) -- 몇년근무했는지
from employees
where department_id = 90;
-- 몇 개월 했는지 
select months_between('2022/12/31', '2021/12/31')  
from dual;
--1개월 뒤의 날짜
select add_months('2022/07/14', 1)
from dual;

select next_day('2022/07/14', 5)
from dual;

select next_day('2022/07/14', 'thursday')
from dual;

select next_day('2022/07/14', 'thu')
from dual;

select last_day('2022/07/14')
from dual;

-- 과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라.
--  월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;