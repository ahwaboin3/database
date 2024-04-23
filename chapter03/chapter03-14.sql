--Documents\dev\database\workspace\chapter03\chapter03-14.sql

--연습 문제 풀이
--[극장 데이터 베이스]
-- 3-12파일에 있는 극장, 상영관, 예약, 고객 테이블 생성
-- 데이터 삽입
-- 극장 데이터
insert into theater values(1,'롯데','잠실');
insert into theater values(2,'메가','강남');
insert into theater values(3,'대한','잠실');
select * from theater;
-- 상영관 데이터
insert into cinema values(1,1,'어려운 영화',15000,48);
insert into cinema values(3,1,'멋진 영화',7500,120);
insert into cinema values(3,2,'재밌는 영화',8000,110);
select * from cinema;
-- 예약 데이터
insert into reservation values(3,2,3,15,'2020-09-01');
insert into reservation values(3,1,4,16,'2020-09-01');
insert into reservation values(1,1,9,48,'2020-09-01');
delete reservation;
select * from reservation;
--고객 데이터
insert into movie_customer values(3,'홍길동','강남');
insert into movie_customer values(4,'김철수','잠실');
insert into movie_customer values(9,'박영희','강남');

--(1) 단순질의
-- 1. 모든 극장의 이름과 위치를 보이시오.
select ttname,ttlocation from theater;
-- 2. 잠실에 있는 극장을 보이시오
select * from theater where ttlocation like '잠실';
-- 3. 잠실에 사는 고객의 이름을 오름차순으로 보이시오.
select cusname from movie_customer
where cusaddr like '잠실' order by cusname;
-- 4. 가격이 8000원 이하인 영화의 극장번호, 상영관번호, 영화제목을 보이시오.
select ttid,cid,moviename from cinema
where movieprice<=8000;
-- 5. 극장 위치와 고객의 주소가 같은 고객들을 보이시오.
select mc.cusname, t.ttlocation from movie_customer mc, theater t
where mc.cusaddr like t.ttlocation;
-- (2) 집계질의
-- 1. 극장의 수는 몇 개인가
select count(*) from theater;
-- 2. 상영되는 영화의 평균 가격은 얼마인가?
select avg(movieprice) from cinema;
-- 3. 2020년 9월 1일에 영화를 관람한 고객의 수는 얼마인가?
select count(*) from movie_customer mc, reservation r
where mc.cusid=r.cusid and r.rdate='2020-09-01';
select * from reservation;

-- (3) 부속질의와 조인
-- 1. 대한 극장에서 상영된 영화제목을 보이시오.
select moviename from cinema
where ttid like 
( select ttid from theater where ttname like '대한');

--2. 대한 극장에서 영화를 본 고객의 이름을 보이시오.
select mc.cusname 
from theater t, reservation r, movie_customer mc
where t.ttid=r.ttid and r.cusid=mc.cusid
and t.ttname like '대한';
--3. 대한 극장의 전체 수입을 보이시오.
select sum(c.movieprice)
from theater t, cinema c, reservation r
where t.ttid=c.ttid and c.ttid=r.ttid
and t.ttname like '대한';
--(4)그룹질의
--1. 극장별 상영관 수를 보이시오.







