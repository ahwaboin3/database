--Documents\dev\database\workspace\chapter03\chapter03-05.sql

--연습문제
--도서번호가 1인 도서의 이름
select bookname
from book
where bookid=1;

--가격이 20000원 이상인 도서의 이름
select bookname
from book
where price>=20000;

--박지성의 총 구매액 
--고객 번호 1
select * from customer;
select sum(saleprice)
from orders
where custid=1;

--박지성이 구매한 도서의 수
select count(*)
from orders
where custid=1;

--박지성이 구매한 도서의 출판사 수
select bookid
from orders
where custid=1;
--박지성이 구매한 도서의 아이디 1,2,3
select count(distinct publisher)
from book
where bookid in (1,2,3);

--박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select bookname,price
from book
where bookid in (1,2,3);

select sum(price)
from book
where bookid in (1,2,3);
--42000

select sum(saleprice)
from orders
where custid=1;
--39000

-- 마당서점 도서의 총 개수
select count(*)
from book;

-- 마당서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher)
from book;

-- 모든 고객의 이름, 주소
select name, address
from customer;

--2020년 7월 4일~7월 7일 사이에 주문받은 도서의 주문번호
select *
from orders
where orderdate between '20200704' and '20200707';

--2020년 7월 4일~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select *
from orders
where orderdate not between '20200704' and '20200707';

--성이 '김'씨인 고객의 이름과 주소
select name, address
from customer
where name like '김%';

--성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
select name,address
from customer
where name like '김%아';








