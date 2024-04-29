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
-- 자바 강좌가 새로 개설되었다
-- 수강료는 25000원이고 아직 신청한 학생은 없다
-- 자바 강좌를 추가하기 위해 insert문을 사용하는데
-- 신청한 학생이 없어 학번에는 null 값이 입력 되었다
-- null 값은 집계 함수 사용 시 원하지 않는 결과를 만들어 냈다

-- fortran 강좌의 수강료를 20000원에서 15000원으로 수정하시오
update summer set price=15000 where class='fortran' and sid=100;

-- fortran 수강료를 조회
select price from summer where class='fortran';
-- 두건이 조회되어 데이터 불일치 문제 발생

-- 수정이상
-- fortran 강좌의 수강료가 20000원에서 15000원으로 변경되어
-- update문을 이용하여 수정하였다.
-- update문은 조건에 맞는 값을 일괄 수정하지만,
-- 조건을 잘못 주면 데이터 불일치 문제가 발생한다

-- 수정된 계절하기 수강 테이블
-- 테이블의 구조를 수정하여 이상현상이 발생하지 않도록 만든다
-- summer 테이블은 summer_price와 summer_enroll테이블로 분리한다
-- summer_price 테이블은 과목에 대한 수걍료 정보를 저장
-- summer_enroll 테이블은 학생들의 수강신청 정보를 저장

DROP TABLE SummerPrice; /* 기존 테이블이 있으면 삭제 */
DROP TABLE SummerEnroll; /* 기존 테이블이 있으면 삭제 */
/* SummerPrice 테이블 생성 */
CREATE TABLE SummerPrice
( class VARCHAR(20),
  price INTEGER
);
INSERT INTO SummerPrice VALUES ('FORTRAN', 20000);
INSERT INTO SummerPrice VALUES ('PASCAL', 15000);
INSERT INTO SummerPrice VALUES ('C', 10000);

select * from summerprice;





