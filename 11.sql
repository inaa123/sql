--view 
--VIEW에 데이터가 있나? -> NO! 
-- hr
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;

desc empvu80 
--select절의 칼럼이 view의 구조가 될 뿐임!

--view를 통해 데이터 조회하기
select * from empvu80;

--view안쓰면 서브쿼리로 이렇게 쓸뻔함.. 하지만 위처럼 view로 절약할숭 ㅣㅅ음!
select * from ( 
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);

--view교체! (테이블교체는 어렵지만 view는 데이터갖고있는게 아니라 코드만 바꾸면됨!)
--없으면 create 있으면 replace
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80

--과제] 50번 부서들의 사번, 이름, 부서번호로 만든 DEPT50 View를 만들어라.
--      view구조는 EMPNO, EMPLOYEE, DEPTNO이다.
--      view를 통해서 50번 부서 사원들이 다른 부서로 배치되지 않도록 한다.

create or replace view dept50(empno, employee, deptno) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck; -- 제약조건 이름 설정하기

-- 과제] DEPT50 VIEW의 구조를 조회하라.
desc dept50

-- 과제] DEPT50 view의 data를 조회하라.
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
--코드로는 team50에 인설트한다고 했지만, 사실은 베이스인 팀스에 인설트된것

-- 팀50을 다시 만들기, 제약조건 있이
create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option;
    
insert into team50 values(50, 'IT Support');
select count(*) from teams; -- 베이스인 팀스에 삽입됨
insert into team50 values(301, 'IT Support'); --error view WITH CHECK OPTION where-clause violation
                                            -- 301은 50과 같다 -> false -> 버려짐

--직접나열하기
create or replace view empvu10(employee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --with뒤에 제약조건, (테이블 뿐만아니라)뷰도 읽기전용으로 만들수있다.

insert into empvu10 values(501, 'abel', 'Sales'); --error  cannot perform a DML
--만약 지금 뷰를 만든다면 읽기전용으로 만들기! (아직 데이터양이 그렇게 많지 않아서)
--뷰는 쿼리의 별명
--INSERT는 DML이라고 부르고
--create와 replace는 DBL이라 불림
---------------

drop sequence team_teamid_seq;

create sequence team_teamid_seq; -- 시작값 1임

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');

select * from teams
where team_id = 3;

create sequence x_xid_seq
    start with 10 -- 시작값
    increment by 5 -- 증가
    maxvalue 20 --최대값
    nocache  -- cache : 메모리에 임시저장하는 것, nocache -> 임시저장x 실행시.. 어쩌구
    nocycle;

select x_xid_seq.nextval from dual; --20 넘어가면 error ->nocycle의 효과.

--과제] DEPT 테이블의 DEPTID 칼럼의 field value로 사용할 sequence를 만들어라.
--      sequence는 400이상 1000이하로 생성한다. 10씩 증가한다.
drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;

--과제] 위 sequence로 dept테이블에서 education 부서를 insert하라.

insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

select * from dept;

------------------------
--인덱스

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name); --인덱스에 뭐시기한 칼럼만 알려주면 된다.

select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

-- 과제] DEPT 테이블의 DEPARTMENT_NAME에 대해 index를 만들어라.
create index dept_deptname_idx
on dept(department_name);
-------------------------

--쿼리에 붙인 별명 View
--DB객체에 붙인 별명 Synonym

drop synonym team;

create synonym team
for departments;

select * from team;

-- 과제] employees 테이블에 emps synonym을 만들어라.
create synonym emps
for employees;