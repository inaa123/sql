select * from departments;

select demartment_id, location_id
from departments;

--Į���� �����ٲ� �� ����
select location_id, department_id
from departments;

desc departments

--����] employees ������ Ȯ���϶�.
desc employees

--salary + 300 ���� ���� �� ����
select last_name, salary, salary + 300
from employees;
--����] ������� ����, ������ ��ȸ�϶�.

select salary, salary * 12
from employees;

select last_name, salary, 12 * salary + 100
from employees;

select last_name, salary, 12 *( salary + 100)
from employees;

select last_name, job_id, commission_pct
from employees; 

select last_name, job_id, 12 * salary + (12 * salary * commission_pct)
from employees; --���� ���������� �ٸ����� �� -> �Ѱ��̶� null�̸� null�̳���.(���̺��� �߸���)  

--�� ���̺� Į���� ���� ���̱� (����������)
select last_name as name, commission_pct comm --as�� ��������
from employees;
--��ҹ��� �����ϴ¹� " " �ȿ� �ۼ� (���⵵ ���Ե�~) �߾Ⱦ�������
select last_name "Name", salary * 12 "Annual Salary"
from employees;

--����] ������� ���, �̸�, ����, �Ի���(SRATRDATE)�� ��ȸ�϶�.
select employee_ID, last_name, job_Id, hire_date startdate
from employees;
--����] ������� ���(Emp #), �̸�(Name), ����(Job), �Ի���(Hire Date)�� ��ȸ�϶�.
select employee_ID "Emp #", last_name "Name", job_Id "Job", hire_date "Hire Date"
from employees;

--���̱� ������. �ϳ��� Į������ ��ġ��
select last_name || job_id
from employees;
--select���� ��� ��������, ���ڻ���� ��������ǥ ' '
select last_name || ' is ' || job_id
from employees;
select last_name || ' is ' || job_id employee
from employees;
select last_name || null --�ϳ��� ���� , ���̱⿬���ڴ� �ΰ��� ���x, 
from employees;
select last_name || commission_pct --���⼭ 1.4�����Ŵ� ���ھƴѹ�����
from employees;
select last_name || salary --���ڿ� ���� ���̱�
from employees;
select last_name || hire_date --���ڿ� ��¥ ���̱�
from employees;
select last_name || (salary * 12) --������ ���ϰ��� ���ڷ� ���̱�
from employees;


--����] ������� '�̸�, ����'�� ��ȸ�϶�. ������
select last_name || ', ' || job_id "(Emp and Title)"
from employees;