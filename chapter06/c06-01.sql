--Documents\dev\database\workspace\chapter06\c06-01.sql
-- summer 테이블을 생성하고 데이터를 삽입
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
