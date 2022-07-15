--datatype conversion
--자동변환-------
select hire_date
from employees
where hire_date = '2003/06/17'; --문자가 날짜로 변환

select salary
from employees
where salary = '7000'; -- 문자가 숫자로 변환

--날짜가 문자로 바뀜
select hire_date || ''  
from employees;

--숫자가 문자로
select salary || ''
from employees;
-----자동변환 끝 -----------

--function이용한 변환-------
--날짜를 문자로-FM(Form and Model
select to_char(hire_date)
from employees;

select to_char(sysdate, 'yyyy-mm-dd') 
from dual;


select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'Year Month Ddsp Day(Dy)')
from dual;

select to_char(sysdate, 'd')
from dual;

select last_name, hire_date, 
    to_char(hire_date, 'day'), 
    to_char(hire_date, 'd')
from employees;

-- 과제] 위 테이블을 월요일부터 오름차순 정렬하라.
select last_name, hire_date, 
    to_char(hire_date, 'day')
from employees
order by to_char(hire_date - 1, 'd');

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

--폼?에 일반문자를 섞고싶을 때
select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month RR')  -- fill mode 앞에 fm붙여서 압축
from employees;

--과제] 사원들의 이름, 입사일 인사평가일을 조회하라.
--      인사평가일은 입사한 지1 3개월 후 첫번째 월요일이다.

select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;

----------------------

--숫자를 문자로 바꾸기

select to_char(salary)
from employees;

select to_char(salary, '$99,999.99'), to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

select '|' || to_char(12.12, 'fm9999.999') || '|',
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual; -- (위랑 다름)스페이스 깨긋하게 없애줌, fill mode

select to_char(1234, 'L9999')
from dual; -- 원 단위

--과제] <이름> earns <$,월급> monthly but wants <$,월급x3>.로 조회하라.

select last_name || ' earns ' ||
    to_char(salary, '$99,999') || ' monthly but wants ' ||
    to_char(salary * 3, '$99,999') || '.'
from employees;
------------------------

--문자를 날짜로 
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd yy'); --어떻게든 파싱?해줌, BUT거짓된데이터 위험

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd yy'); --Format eXtract, 포맷과 정확히 일치해야함
----------------------------------------------

---문자를 숫자로
select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- error ','를 parsing 못함(해석을 못함)

select to_number('1,237.12', '9,999.99')
from dual;
------------------------------------------------------

-- null -> NVL함수 가장 중요! 

select nvl(null, 0)
from dual; -- (조사할값, 리턴할값)

select job_id, nvl(commission_pct, 0)
from employees;

-- 과제] 사원들의 이름, 직업, 연봉을 조회하라.
--select last_name, job_id, (salary + (salary * nvl(commission_pct, 0))) * 12 "annual salary" 
select last_name, job_id, salary * (1 + nvl(commission_pct,0)) * 12 ann_sal
from employees
order by ann_sal desc;

--과제 ] 사원들의 이름, 커미션율을 조회하라.
--          커미션이 없으면, No commission 을 표시한다.
select last_name, nvl(to_char(commission_pct), 'No commission')
from employees;

--null이면 세번째파라미터 값을 받고, 아니면 두번째 파라미터 값을 받는다.
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL')
from employees;
select job_id, nvl2(commission_pct, 'SAL+COMM', 0)
from employees; -- 두번째와 세번째 타입이 같음, 0은 문자0임

--nullif는 첫번째 파라미터값과 두번째 파라미터값이 같으면 null을 리턴, 아니면 첫번째파라미터값 리턴
select first_name, last_name, 
    nullif(length(first_name), length(last_name)) 
from employees;

select to_char(null), to_number(null), to_date(null)
from dual; --리턴값 다 널

-- coalesce 처음으로 null이 아닌 값 리턴, 
select last_name,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
----------------------------------------------------

--디코드함수 - 스위치랑 비슷해용
select last_name, salary, 
    decode(trunc(salary / 2000),
        0, 0.00,
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1)
from employees; --기본값 작성 x -> null

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; -- error, invalid number 오라클은 에러번호알려줌 , 에러번호검색하기

select decode(hire_date, 'a', 1)
from employees; -- hire_date 문자로 바꾸려구 함

select decode(hire_date, 1, 1)
from employees; -- hire_date를 숫자로 바꾸려함. 실패!

-- 과제] 사원들의 직업, 직업별 등급을 조회하라.
--          기본 등급은 null이다.
--          IT_PROG     A
--          AD_PRES     B
--          ST_MAN      C
--          ST_CLERK    D
select job_id, decode(job_id,
                    'IT_PROG',  'A',
                    'AD_PRES',  'B',
                    'ST_MAN',   'C',
                    'ST_CLERK', 'D') grade
from employees;

--select case
select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees; -- case 부터 end까지 하나!, when 비교값 then 리턴값

select case job_id when '1' then 1  -- 비교값은 문자 리턴값은 숫자
                    when '2' then 2
                    else 0 --기본값도 타입이 같아야함 숫자로
        end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0' 
        end grade
from employees;

select case salary when '1' then '1'
                    when 2 then 2
                    else '0' 
        end grade
from employees; -- error 

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0 
        end grade
from employees; -- error else의 타입이 숫자,

select case salary when 1 then 1
                    when 2 then '2'
                    else '0' 
        end grade
from employees; -- error

select last_name, salary,
    case when salary < 5000 then 'low' --기준값 없고, when값없지만 조건문 씀
        when salary < 10000 then 'medium'
        when salary <20000 then 'high'
        else 'good'
    end grade
from employees; --case end로 if문 만들 수 있다.

-- 과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.
select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
        when 'monday' then 1
        when 'tuesday' then 2
        when 'wednesday' then 3
        when 'thursday' then 4
        when 'friday' then 5
        when 'saturday' then 6
        when 'sunday' then 7
    end;

-- 과제] 2005년 이전에 입사한 사원들에겐 100만원 상품권,
--       2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.

select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100만원'
        else '10만원'
        end gift
from employees;
-- 이전 앞에 값 포함, 후는 값포함x
