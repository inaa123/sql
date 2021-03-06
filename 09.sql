-- DML(Data Manipulation Language) (8장까진 쿼리, 지금부턴 dml, 데이터를 조작하는 언어)

--테이블없애기 
drop table emp; 
drop table dept; --

--테이블 만들기 
create table emp (
employee_id number(6),
first_name varchar2(20), 
last_name varchar2(25), --()바이트..
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4)); -- 테이블 구조 넣기

create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4));

--레코드 집어넣기
insert into dept(department_id, department_name, manager_id, location_id) --필드네임, 필드순서는 내 마음대로~ 
values (300, 'Public Relation', 100, 1700); -- 필드 값 (다작성안해도 됨) row하나 완성->dept안에 집어넣기

insert into dept(department_id, department_name)
values (310, 'Purchasing');

-- 과제] row 2건이 insert 성공됐는지, 확인해라.
select *
from dept;

commit; -- transaction 업무 시작에서 끝까지의 과정!(퍼시스턴스관점에선 DML문장이 실행될때가 시작 COMMIT이 끝)
-- 작성해도 메모리에 있음, 디스크에 저장되도록 하려면 commit해야함!

insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values (300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate, --insert에도 function사용가능
        'AC_ACCOUNT', 6900, null,
        205, 110);

insert into emp
values (310, 'Jark', 'Klein',
        'Klein@gmail.com', '010-753-4635', to_date('2022/06/15', 'YYYY/MM/DD'),
        'IT_PROG', 8000, null,
        120, 190);
        
insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-362-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100, 30);
commit;

drop table sa_reps;

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2));

--insert에 서브쿼리 사용할 수 있음! -> n개의 row가 한 번에 삽입!
insert into sa_reps(id, name, salary, commission_pct) 
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';
commit;

-- pl/sql
declare
    base number(6) := 400;
begin 
    for i in 1..10 loop --변수 i에 1부터 10까지 반복
        insert into sa_reps(id, name, salary, commission_pct)
        values(base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/
--마지막에 슬래쉬까지!!!!!!!!

select * from sa_reps;

-- 과제] procedure 로 insert한 row들을 조회하라.
select *
from sa_reps
where id > 400;
----------------------------insert끝

--update 레코드를 수정. 일부 필드의 값을 바꾸는 것!
select employee_id, salary, job_id
from emp
where employee_id = 300;

update emp
set salary = 9000, job_id = null 
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback; -- transaction 취소 (commit 이후부터 rollback됨!)

select job_id, salary
from emp
where employee_id = 300;

update emp
set (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

commit;
----------------------

delete dept
where department_id = 300;

select *
from dept;

rollback;

select *
from dept;

delete emp
where department_id = (
        select department_id
        from departments
        where department_name = 'Contracting');

select *
from emp;

commit;
