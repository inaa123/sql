--SYSTEM은 스키마와 상관없이....데이터 조회?가능...?


-- DDL (Data Definition Language)
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname
from tab;

-- 과제] drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회하라.
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;
------------------------------

--DCL(Data Control Language)
-- system user 로 변경한다.

create user you identified by you;
grant connect, resource to you;

-- you user
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key, -- primary key는 두개의 속성을 가짐, 즉 not null + unique가짐
emp_name varchar2(10) constraint emps_empname_nn not null, -- not null : emp_name값에 null값있으면X
email varchar2(20),
salary number(6) constraint emps_sal_ck check(salary > 1000),
department_id number(3),
constraint emps_email_uk unique(email),
constraint emps_deptid_fk foreign key(department_id)
    references depts(department_id));

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;

delete depts; -- error, (YOU.EMPS_DEPTID_FK) violated
            --거짓인 이유.  deps를 삭제하면 emps 의 foreign key가 맞지 않아 거짓인 데이터가 됨 
            -- 그래서 depts의 삭제를 막는다.

insert into depts values(100, 'Marketing'); --error, (YOU.DEPTS_DEPTID_PK) violated
                                            --100의값이 이미 존재.
insert into depts values(null, 'Marketing'); -- error,  cannot insert NULL , 널값못넣음
insert into emps values(501, null, 'good@gmail.com', 6000, 100); --error, cannot insert NULL into
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); --error,  (YOU.EMPS_EMAIL_UK) violated
insert into emps values(501, 'label', 'good@gmail.com', 6000, 200); -- error, YOU.EMPS_DEPTID_FK) violated - parent key not found
                                                                    --parent key -> depts의 id -> 200번이 X
drop table emps cascade constraints; -- 테이블과 연결된..... 다 삭제.. 깨끗하게 삭제..
select constraint_name, constraint_type, table_name
from user_constraints;

--system user
grant all on hr.departments to you;

drop table employees cascade constraints;

-- 프라이머리 제약조건 constraint : 제약 
-- 테이블에서 프라이머리제약조건은 하나만 존재, 나머진 n개 존재가능
--다시 you로 바꾸고 create생성!
create table employees(  
employee_id number(6) constraint emp_empid_pk primary key, 
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null 
                    constraint emp_email_pk unique, 
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fk references employees(employee_id),
department_id number(4) constraint emp_dept_fk references hr.departments(department_id));
------------------------

-- delete..?
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null);
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit;
-------------------

-- disable fk, (foreign 잠재우기..?)
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fk foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); -- error, parent key not found

alter table b disable constraint b_aid_fk; --foreign key뿐만아니라 제약조건 잠재우기
insert into b values(32, 9); --거짓데이터지만, 삽입가능, 개발은 가능해짐                                                              

alter table b enable constraint b_aid_fk; -- error, parent keys not found , foreign key 잠자고있어..
alter table b enable novalidate constraint b_aid_fk;

insert into b values(33, 8); -- error, parent key not found
---------------------------------

drop table sub_departments;

create table sub_departments as 
    select department_id dept_id, department_name dept_name
    from hr.departments;

desc sub_departments;

select * from sub_departments;
-------------------------
--table구조 수정방법

drop table users cascade constraints; --DBL..

create table users(
user_id number(3));
desc users

alter table users add(user_name varchar2(10)); -- 칼럼 추가
desc users

alter table users modify(user_name number(7)); --칼럼 수정
desc users

alter table users drop column user_name; --칼럼삭제
desc users
------------------------

--테이블 읽기전용으로 바꾸기
insert into users values(1); --쓰기 되는지 확인

alter table users read only; --읽기 전용으로 바꿈
insert into users values(2); --error,

alter table users read write; -- 읽기쓰기로 바꾸기
insert into users values(2);

commit;


