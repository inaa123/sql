--group function �׷��Լ����� �� null���� ������!
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

--��¥���� ����, �ֱ����� max
select min(hire_date), max(hire_date)
from employees;

-- ����] �ְ����ް� �ּҿ����� ������ ��ȸ�϶�.
select max(salary) - min(salary)
from employees;


-- *�� ���Į���� ����, count�� * ��� ����?
select count(*) 
from employees; --����� ����̾�?

-- ����] 70�� �μ����� ������� ��ȸ�϶�.
select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select count(manager_id)
from employees;

select avg(commission_pct)
from employees;

-- ����] ������ ��� Ŀ�̼����� ��ȸ�϶�.

select avg(nvl((commission_pct),0))
from employees;
-----------------------------------------

select avg(salary)
from employees; 

select avg(distinct salary) 
from employees; --�ߺ�����

select avg(all salary)
from employees; -- all��������

--���� ] ������ ��ġ�� �μ� ������ ��ȸ�϶�.
select count(distinct department_id)
from employees;

select count(distinct manager_id)
from employees; -- ������ �Ŵ��� ������� �ľ� ����
-------------------------------------

--�׷��� ������ n����
--select���� Į���� �׷��� ���̺��̴�.
select department_id, count(employee_id) --�ι�° �ʵ�� ī���� ���ϰ��� ..
from employees
group by department_id -- �μ���ȣ�� ���� �༮�� ���� �׷��� ���´�.
order by department_id;


select employee_id
from employees
where department_id = 30;

select employee_id, job_id, count(employee_id)
from employees
group by department_id -- group by ���� �ִ� �Ÿ� select���� �� �� �ִ�.
order by department_id; -- error select���� �Ϲ�Į���� �׷�Į�� ���� �Ϲ�Į���� ���̺��� ����?������ �׷�Į���� ���̺��� ������ �� �� ����.

-- ����] ������ ������� ��ȸ�϶�. --�������� ���̺�
select job_id, count(employee_id)
from employees
group by job_id;
--------------------

select department_id, max(salary) 
from employees
group by dapartment_id
having department_id > 50; --�׷��󳾶� having��

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal 
from employees
group by dapartment_id
having max_sal > 10000; --error having���� ��������

select department_id, max(salary)
from employees
where department_id > 50
group by department_id;

select department_id, max(salary)
from employees
where max(salary) > 10000
group by department_id; -- error where ���ǹ��� �׷���������� having����.  having�� �׷��� ��󳽴�.

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%' --���ڵ� ��󳻱�
group by job_id --��� ���ڵ�� �׷�����
having sum(salary) > 13000 --�׷� ��󳻱�
order by payroll;

-- ����] �Ŵ���ID, �Ŵ����� ���� ������ �� �ּҿ����� ��ȸ�϶�.
--      �ּҿ����� $6,000 �ʰ����� �Ѵ�.
select manager_id, min(salary)
from employees
where manager_id is not null  --managerid�ΰ� ������
group by manager_id
having  min(salary) > 6000
order by 2 desc;

-----------------------------------
select max(avg(salary)) --��ø���)
from employees
group by department_id; 
--n���� �׷쿡�� avg(salary)�� n�� ����Ǿ� avg() n���� ���ڵ尡 max�� �Ķ���Ͱ� �Ǿ�max()�� �ѹ�����

select sum(max(avg(salary)))
from employees
group by department_id; -- error, to deeeply , �ʹ����Ե�. (��ø����)
--group�Լ��� �ΰ����� ��ø ����!

--single�� group ��ø
select department_id, round(avg(salary))
from employees
group by department_id;
--avg�Լ��� n���� ���ڵ尡 ��(n���� ���ڵ� ����), round()�� n���� �� ����(n������)

select department_id, round(avg(salary))
from employees; -- error, group by���� ����, �̱۰� �׷��� ���̾��� �׷���� �����!

-- ����] 2001��, 2002��, 2003�⵵�� �Ի��� ���� ã�´�.
--2001���̸� 1 �ƴϸ� 0, ���ϸ� 2001�� �� ����. decode�� 

select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

-- ������, �μ��� �������� ��ȸ�϶�.
--          �μ��� 20, 50, 80�̴�.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;
    
        
