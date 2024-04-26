--Documents\dev\database\workspace\chapter04\chapter04-03.sql

-- 03 뷰(view)
-- 마당서점에서 택배 배송을 하기 위해 택배에 필요한 정보만 추출
-- 매번 질의할 때마다 조인이나 부속질의를 하는 것은 상당히 번거롭다
-- 택배 정보만 저장되어 있으면 나중에 간편하게 정보를 조회할 수 있다
-- 뷰는 하나 이상의 테이블을 합하여 만든 가상의 테이블이다
-- select문을 통해 얻은 최종 결과를 가상의 테이블로 정의하여
-- 실제 테이블처럼 사용할 수 있도록 만든 데이터베이스 개체이다

-- 뷰의 생성
-- 뷰를 생성하는 문법
-- create view 뷰이름 [(열이름[,....n])]
-- as <select 문>

-- book 테이블에서 '축구'라는 문구가 포함된 자료만 보여 주는 뷰를 만들어 보자
select * from book where bookname like '%축구%';
-- select 문을 이용해 뷰 정의문을 작성
create view vw_book
as select * from book where bookname like '%축구%';
-- vw_book이라는 뷰가 생성되며 일반 테이블처럼 사용할 수 있다
-- 뷰는 실제 데이터가 저장되는 게 아니라 뷰의 정의가 dbms에 저장되는 것이다
-- book 테이블에 '축구'라는 문구가 포함한 도서가 새로 추가되면
-- 이 데이터 역시 뷰에도 나타난다
-- 만약 추가 되는 도서 이름에 '축구'라는 문구가 포함되어 있지 않으면
-- book테이블에는 존재하지만 뷰에서는 나타나지 않는다

-- '축구'라는 문구가 포함된 자료를 보이시오
select * from book where bookname like '%축구%';
-- 뷰를 이용
select * from vw_book;

-- 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오.
-- 뷰의 이름은 vw_customer로 설정하시오.
create view vw_customer
as select * from customer where address like '%대한민국%';
select * from vw_customer;

-- orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후,
-- '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.
select od.orderid, od.custid, cs.name,
    od.bookid, bk.bookname,od.saleprice,od.orderdate
from orders od, customer cs, book bk
where od.custid=cs.custid and od.bookid=bk.bookid;

create view vw_orders(orderid,custid,name,bookid,bookname,saleprice,orderdate)
as select od.orderid, od.custid, cs.name,
    od.bookid, bk.bookname,od.saleprice,od.orderdate
from orders od, customer cs, book bk
where od.custid=cs.custid and od.bookid=bk.bookid;

-- 김연아 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오
select orderid, bookname, saleprice from vw_orders
where name='김연아';

-- 뷰의 수정
-- 문법
-- create or replace view 뷰이름 [(열이름[,...n])]
-- as select 문

-- vw_customer는 주소가 '대한민국'인 고객을 보여 준다.
-- 이 뷰를 '영국'을 주소로 가진 고객으로 변경하시오.
-- phone속성은 필요 없으므로 포함하지 마시오.
create or replace view vw_customer(custid,name,address)
as select custid, name, address
    from customer
    where address like '%영국%';
select * from vw_customer;

--뷰의 삭제
-- drop view 뷰이름 [,...n];

-- vw_customer를 삭제하시오
drop view vw_customer;
select * from vw_customer;
















