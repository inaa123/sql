--view
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
------------------------------

drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;

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
--시퀀스 많이 쓸거임~~ 시퀀스를 primary key 필드값으로 쓰기 좋음!
--시퀀스 직접만들진 X, DB가 만들어~






                                            






    
