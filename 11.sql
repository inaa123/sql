--view 
--VIEW�� �����Ͱ� �ֳ�? -> NO! 
-- hr
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80 
--select���� Į���� view�� ������ �� ����!

--view�� ���� ������ ��ȸ�ϱ�
select * from empvu80;

--view�Ⱦ��� ���������� �̷��� ������.. ������ ��ó�� view�� �����Ҽ� �Ӥ���!
select * from ( 
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);

--view��ü! (���̺�ü�� ������� view�� �����Ͱ����ִ°� �ƴ϶� �ڵ常 �ٲٸ��!)
--������ create ������ replace
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80

--����] 50�� �μ����� ���, �̸�, �μ���ȣ�� ���� DEPT50 View�� ������.
--      view������ EMPNO, EMPLOYEE, DEPTNO�̴�.
--      view�� ���ؼ� 50�� �μ� ������� �ٸ� �μ��� ��ġ���� �ʵ��� �Ѵ�.

create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck; -- �������� �̸� �����ϱ�

-- ����] DEPT50 VIEW�� ������ ��ȸ�϶�.
desc dept50

-- ����] DEPT50 view�� data�� ��ȸ�϶�.
select * from dept50;

------------------------------

drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from hr.departments;

create view team50 as
    select * 
    from teams
    where team_id = 50;

select * from team50;

select count(*) from teams;
insert into team50
values(300, 'Marketing');
select count(*) from teams;
--�ڵ�δ� team50�� �μ�Ʈ�Ѵٰ� ������, ����� ���̽��� ������ �μ�Ʈ�Ȱ�

-- ��50�� �ٽ� �����, �������� ����
create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option;
    
insert into team50 values(50, 'IT Support');
select count(*) from teams; -- ���̽��� ������ ���Ե�
insert into team50 values(301, 'IT Support'); --error view WITH CHECK OPTION where-clause violation
                                            -- 301�� 50�� ���� -> false -> ������

--���������ϱ�
create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --with�ڿ� ��������, (���̺� �Ӹ��ƴ϶�)�䵵 �б��������� ������ִ�.

insert into empvu10 values(501, 'abel', 'Sales'); --error  cannot perform a DML
--���� ���� �並 ����ٸ� �б��������� �����! (���� �����;��� �׷��� ���� �ʾƼ�)
--��� ������ ����
--INSERT�� DML�̶�� �θ���
--create�� replace�� DBL�̶� �Ҹ�
---------------

drop sequence team_teamid_seq;

create sequence team_teamid_seq; -- ���۰� 1��

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

create sequence x_xid_seq
    start with 10 -- ���۰�
    increment by 5 -- ����
    maxvalue 20 --�ִ밪
    nocache  -- cache : �޸𸮿� �ӽ������ϴ� ��, nocache -> �ӽ�����x �����.. ��¼��
    nocycle;

select x_xid_seq.nextval from dual; --20 �Ѿ�� error ->nocycle�� ȿ��.

--����] DEPT ���̺��� DEPTID Į���� field value�� ����� sequence�� ������.
--      sequence�� 400�̻� 1000���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

--����] �� sequence�� dept���̺��� education �μ��� insert�϶�.

insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

select * from dept;

------------------------
--�ε���

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name); --�ε����� ���ñ��� Į���� �˷��ָ� �ȴ�.

select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- ����] DEPT ���̺��� DEPARTMENT_NAME�� ���� index�� ������.
create index dept_deptname_idx
on dept(department_name);
-------------------------

--������ ���� ���� View
--DB��ü�� ���� ���� Synonym

drop synonym team;

create synonym team
for departments;

select * from team;

-- ����] employees ���̺� emps synonym�� ������.
create synonym emps
for employees;