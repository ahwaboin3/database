--Documents\dev\database\workspace\chapter06\c06-01.sql
-- summer ���̺��� �����ϰ� �����͸� ����
drop table summer;

create table summer(
    sid number,
    class varchar2(20),
    price number
);
insert into summer values(100,'fortran',20000);
insert into summer values(150,'pascal',15000);
insert into summer values(200,'c',10000);
insert into summer values(250,'fortran',20000);

select * from summer;

-- select���� �̿��� ��ȸ �۾�
-- �л��� �й� sid, �����ϴ� ������ class, ���� ������ ������� price
-- �����б⸦ ��� �л��� �й��� �����ϴ� ������?
select sid, class from summer;
-- �����ᰡ ���� ��� ������?
select distinct class from summer
where price=(select max(price) from summer);

-- ���� �̻�
-- 200�� �л��� �����б� ������û�� ����Ͻÿ�.
delete summer where sid=200;
select * from summer;

-- C ���� ������ ��ȸ
select price "C ������" from summer where class="C";

-- 200�� �л��� ������û�� ����Ͽ� ���� ������ ���� �Ͽ���
-- 200�� �л��� ������û�� �� ��� �Ǿ���
-- C������ �����Ḧ ��ȸ�� �� ���� �Ǿ���
-- �л��� ���������� ����ϸ鼭 �����ᵵ �Բ� �����Ͽ��� �����̴�
-- ���� �̻��� �߻��Ͽ���

--���� �ǽ��� ���� 200�� �л� �ڷ� �ٽ� �Է�
insert into summer values (200, 'C',10000);

-- �����̻�
-- �����б⿡ ���ο� �ڹ� ���¸� �����Ͻÿ�.
-- �ڹ� ���� ����
insert into summer values( null, 'java',25000);
-- ��ü ������ ��ȸ
select * from summer;
-- ������ �л��� �Ѽ��� ���Ͻÿ�
select count(*) from summer;
-- ������ �л��� �Ѽ��� 4���ε� 5���̶�� ����� ���Դ�
-- ���̺��� �����Ͱ� ���� �� ��ü �����͸� �����ϰ� �ľ��Ͽ�
-- sql���� ������ �ϴ� ������ �ִ�
select count(sid) from summer;
-- �����̻�






