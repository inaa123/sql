--datatype conversion
--�ڵ���ȯ-------
select hire_date
from employees
where hire_date = '2003/06/17'; --���ڰ� ��¥�� ��ȯ

select salary
from employees
where salary = '7000'; -- ���ڰ� ���ڷ� ��ȯ

--��¥�� ���ڷ� �ٲ�
select hire_date || ''  
from employees;

--���ڰ� ���ڷ�
select salary || ''
from employees;
-----�ڵ���ȯ �� -----------

--function�̿��� ��ȯ-------
--��¥�� ���ڷ�-FM(Form and Model
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

-- ����] �� ���̺��� �����Ϻ��� �������� �����϶�.
select last_name, hire_date, 
    to_char(hire_date, 'day')
from employees
order by to_char(hire_date - 1, 'd');

select to_char(sysdate, 'hh24:mi:ss am')
from dual;

--��?�� �Ϲݹ��ڸ� ������� ��
select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'fmDD Month RR')  -- fill mode �տ� fm�ٿ��� ����
from employees;

--����] ������� �̸�, �Ի��� �λ������� ��ȸ�϶�.
--      �λ������� �Ի��� ��1 3���� �� ù��° �������̴�.

select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 'monday'), 'YYYY.MM.DD') review_date
from employees;

----------------------

--���ڸ� ���ڷ� �ٲٱ�

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
from dual; -- (���� �ٸ�)�����̽� �����ϰ� ������, fill mode

select to_char(1234, 'L9999')
from dual; -- �� ����

--����] <�̸�> earns <$,����> monthly but wants <$,����x3>.�� ��ȸ�϶�.

select last_name || ' earns ' ||
    to_char(salary, '$99,999') || ' monthly but wants ' ||
    to_char(salary * 3, '$99,999') || '.'
from employees;
------------------------

--���ڸ� ��¥�� 
select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'Mon dd yy'); --��Ե� �Ľ�?����, BUT�����ȵ����� ����

select last_name, hire_date
from employees
where hire_date = to_date('Sep 21, 2005', 'fxMon dd yy'); --Format eXtract, ���˰� ��Ȯ�� ��ġ�ؾ���
----------------------------------------------

---���ڸ� ���ڷ�
select to_number('1237')
from dual;

select to_number('1,237.12')
from dual; -- error ','�� parsing ����(�ؼ��� ����)

select to_number('1,237.12', '9,999.99')
from dual;
------------------------------------------------------

-- null -> NVL�Լ� ���� �߿�! 

select nvl(null, 0)
from dual; -- (�����Ұ�, �����Ұ�)

select job_id, nvl(commission_pct, 0)
from employees;

-- ����] ������� �̸�, ����, ������ ��ȸ�϶�.
--select last_name, job_id, (salary + (salary * nvl(commission_pct, 0))) * 12 "annual salary" 
select last_name, job_id, salary * (1 + nvl(commission_pct,0)) * 12 ann_sal
from employees
order by ann_sal desc;

--���� ] ������� �̸�, Ŀ�̼����� ��ȸ�϶�.
--          Ŀ�̼��� ������, No commission �� ǥ���Ѵ�.
select last_name, nvl(to_char(commission_pct), 'No commission')
from employees;

--null�̸� ����°�Ķ���� ���� �ް�, �ƴϸ� �ι�° �Ķ���� ���� �޴´�.
select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL')
from employees;
select job_id, nvl2(commission_pct, 'SAL+COMM', 0)
from employees; -- �ι�°�� ����° Ÿ���� ����, 0�� ����0��

--nullif�� ù��° �Ķ���Ͱ��� �ι�° �Ķ���Ͱ��� ������ null�� ����, �ƴϸ� ù��°�Ķ���Ͱ� ����
select first_name, last_name, 
    nullif(length(first_name), length(last_name)) 
from employees;

select to_char(null), to_number(null), to_date(null)
from dual; --���ϰ� �� ��

-- coalesce ó������ null�� �ƴ� �� ����, 
select last_name,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
----------------------------------------------------

--���ڵ��Լ� - ����ġ�� ����ؿ�
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
from employees; --�⺻�� �ۼ� x -> null

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; -- error, invalid number ����Ŭ�� ������ȣ�˷��� , ������ȣ�˻��ϱ�

select decode(hire_date, 'a', 1)
from employees; -- hire_date ���ڷ� �ٲٷ��� ��

select decode(hire_date, 1, 1)
from employees; -- hire_date�� ���ڷ� �ٲٷ���. ����!

-- ����] ������� ����, ������ ����� ��ȸ�϶�.
--          �⺻ ����� null�̴�.
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
from employees; -- case ���� end���� �ϳ�!, when �񱳰� then ���ϰ�

select case job_id when '1' then 1  -- �񱳰��� ���� ���ϰ��� ����
                    when '2' then 2
                    else 0 --�⺻���� Ÿ���� ���ƾ��� ���ڷ�
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
from employees; -- error else�� Ÿ���� ����,

select case salary when 1 then 1
                    when 2 then '2'
                    else '0' 
        end grade
from employees; -- error

select last_name, salary,
    case when salary < 5000 then 'low' --���ذ� ����, when�������� ���ǹ� ��
        when salary < 10000 then 'medium'
        when salary <20000 then 'high'
        else 'good'
    end grade
from employees; --case end�� if�� ���� �� �ִ�.

-- ����] �̸�, �Ի���, ������ �����Ϻ��� ���ϼ����� ��ȸ�϶�.
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

-- ����] 2005�� ������ �Ի��� ����鿡�� 100���� ��ǰ��,
--       2005�� �Ŀ� �Ի��� ����鿡�� 10���� ��ǰ���� �����Ѵ�.
--      ������� �̸�, �Ի���, ��ǰ�Ǳݾ��� ��ȸ�϶�.

select last_name, hire_date,
    case when hire_date <= '2005/12/31' then '100����'
        else '10����'
        end gift
from employees;
-- ���� �տ� �� ����, �Ĵ� ������x
