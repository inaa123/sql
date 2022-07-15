-- single function

desc dual
select * from dual; -- ���ڵ� �ϳ��� ���� ���� ��! (���ڵ尡 �ʵ�1�� ������ �ͻ���)
--single function ��..

select lower('SQL Course') --lower function�� �Ķ���ͷ� ���� ���� �ҹ��ڷ� �ٲ���
from dual; -- �ش� Į�� �������� ��.,.....����

select upper('SQL Course')
from dual;

select initcap('SQL course') -- ù���ڸ� �빮�ڷ� �ٲ�
from dual; 

-- SQL�� ��ҹ��� ���о��ص� ������, �����ʹ� ��ҹ��� �����ؾ��Ѵ� ����
select last_name
from employees
where last_name = 'higgins'; -- ���佺�� ������ �ҹ��� ���佺�� ���°�.
select last_name
from employees
where last_name = 'Higgins'; -- �����ʹ� ��ҹ��� �����ؾ���!
-- ��ҹ��� ���н� �̱���Ǿ���!!
select last_name
from employees
where lower(last_name) = 'higgins'; -- last_name�ʵ尪�� �ҹ��ڷιٲٱ�
-- lower����� ���ϰ��� �ʵ尪. ??????????
-- last_name �ʵ尡 ������ �ִ� ���ڵ� ������ ���µ� lower function�� ���� ������? 
-- ���ڵ尡 �ʵ�� ����............. �ҹ��� higgins�� �� ���ڵ尡 �޶� �ϳ� ���ϵȰ�.....
--lower function�� �� ������ �۵��ϸ鼭 ��� ����������? 107�� ...
-- why? �Ķ���ͷ� �ϳ�������������. 107���� �ѹ��� ���� �� ���.. 107��(���ڵ尳����ŭ)����

--���ڸ� �ٷ�� function
select concat('Hello', 'World')
from dual;

--SQL�� �ε��� 1���� ������.
select substr('HelloWorld', 2, 5) --�ι�°�Ķ���� : �ڸ�������� �ε���, ����°: ���ڰ���
from dual;
select substr('Hello', -1, 1) -- �ڿ������� ���� -���̱�
from dual;

select length('Hello') -- ���� ��
from dual;

select inStr('Hello', 'l') -- ó���߰ߵ� L�� �ε��� �����ϰ� ��
from dual;
select inStr('Hello', 'w')
from dual; -- w�� ���°��̾ 0 =>���߿� ���� �ִ��������� �Ǵ� ���� 0���� ũ�� ���� �ְ� 0���� ������ ����

--salary 5�ڸ��� ����
select lpad(salary, 5, '*') -- ������ ä��
from employees;
select rpad(salary, 5, '*') -- ������ ä��
from employees;

-- ����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�. 
-- �׷����� $1000 �� * �ϳ��� ǥ���Ѵ�.
select last_name, rpad(' ', salary / 1000 + 1, '*')
from employees;

-- ����] �� �׷����� ���� ���� �������� �����϶�.
select last_name, rpad(' ', salary / 1000 + 1, '*') sal
from employees
order by sal desc;

select replace('JACK and JUE', 'J', 'BL')
from dual;

select trim('H' from 'Hello')  -- ����. �Ӹ��κ� �����κ� �Ű澸
from dual;
select trim('l' from 'Hello') -- ������ �Ű�Ⱦ�
from dual;
select trim (' ' from ' Hello ')
from dual;
--���� ] �� query���� ' '�� trim������ ������ Ȯ���� �� �ְ� ��ȸ�϶�.
select '|' || trim (' ' from ' Hello ') || '|'  
from dual;
-- �� ������ ,trim
select trim(' Hello World ')
from dual;

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';

-- ����] �Ʒ� ���忡�� WHERE���� like�� refactoring�϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

-- ����] �̸��� J�� A�� M���� �����ϴ»������ �̸�, �̸��� ���ڼ��� ��ȸ�϶�.
-- �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����Ѵ�.
select initcap(last_name), length(last_name)
from employees
where last_name like 'J%' or
    last_name like 'A%' or
    last_name like 'M%';
-------------------------------------- ���ݱ��� ���ڸ� �ٷ�� function
--���ڸ� �ٷ�� function
select round(45.926, 2) -- �Ҽ������� 2��° �ڸ����� �ݿø��Ѵ�.
from dual;
select trunc(45.926, 2) -- ����?
from dual;
select mod(1600, 300) -- ������
from dual;

select round(45.923, 0), round(45.923) -- ������ ����� ��, 0 ��������
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;

select last_name, salary, salary - mod(salary, 10000)
from employees;

-- ����] ������� �̸�, ����, 15.5% �λ�� ����(New salary, ����), �λ���� ��ȸ�϶�.
select last_name, salary, round(salary * 1.155) "New salary",
    round(salary * 1.155) - salary "Incerease" 
from employees;
-------------------------���ڳ�

select sysdate -- ������ �ð�
from dual;

select sysdate +1
from dual;
select sysdate - 1
from dual;

select sysdate - sysdate
from dual;

-- ����] �Ʒ� ������ ���ļ�, ����̸�, �ټӿ����� ��ȸ�϶�.
select last_name, trunc((sysdate - hire_date) / 365) -- ���ٹ��ߴ���
from employees
where department_id = 90;
-- �� ���� �ߴ��� 
select months_between('2022/12/31', '2021/12/31')  
from dual;
--1���� ���� ��¥
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

-- ����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�.
--  ������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;