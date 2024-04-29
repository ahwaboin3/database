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

-- select문을 이용한 조회 작업
-- 학생의 학번 sid, 수강하는 과목은 class, 수강 과목의 수강료는 price
-- 계절학기를 듣는 학생의 학번과 수강하는 과목은?
select sid, class from summer;
-- 수강료가 가장 비싼 과목은?
select distinct class from summer
where price=(select max(price) from summer);

-- 삭제 이상
-- 200번 학생의 계절학기 수강신청을 취소하시오.
delete summer where sid=200;
select * from summer;

-- C 강좌 수강료 조회
select price "C 수강료" from summer where class="C";

-- 200번 학생이 수강신청을 취소하여 관련 투플을 삭제 하였다
-- 200번 학생의 수강신청을 잘 취소 되었다
-- C강좌의 수강료를 조회할 수 없게 되었다
-- 학생의 수강신층을 취소하면서 수강료도 함께 삭제하였기 때문이다
-- 삭제 이상이 발생하였다

--다음 실습을 위해 200번 학생 자료 다시 입력
insert into summer values (200, 'C',10000);

-- 삽입이상
-- 계절학기에 새로운 자바 강좌를 개설하시오.
-- 자바 강좌 삽입
insert into summer values( null, 'java',25000);
-- 전체 데이터 조회
select * from summer;
-- 수강한 학생의 총수를 구하시오
select count(*) from summer;
-- 수강한 학생의 총수가 4명인데 5명이라는 결과가 나왔다
-- 테이블의 데이터가 많을 때 전체 데이터를 세세하게 파악하여
-- sql문을 만들어야 하는 단점이 있다
select count(sid) from summer;
-- 삽입이상






