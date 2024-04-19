--Documents\dev\database\workspace\chapter03\chapter03-07.sql
--부속질의
--sql문 내에 또 다른 sql문을 작성 한다
--예)가격이 가장 비싼 도서의 이름은 얼마인가?
--가장 비싼 가격 구하기
select max(price)
from book;
--가장 비싼 가격으로 도서의 이름 구하기
select bookname
from book
where price=35000;

--가장 비싼 도서의 이름을 보이시오 (부속질의 사용
select bookname -----------------2
from book
where price=
(select max(price) from book); --1
-- 괄호로 묶어서 sql문을 중첩시키는 것을 부속질의(subquery)라고 한다
-- 부속질의는 질의가 중첩되어 있다는 의미에서 중첩질의(nested  query)라고도 한다
-- 부속질의의 실행 순서는 where절의 부속질의를 먼저 처리하고 전체질의를 처리한다

-- 부속질의는 sql문이다
-- sql문의 결과는 테이블
-- 테이블의 결과는 네 가지 중 하나가 된다
-- 단일행-단일열(1x1), 다중행-단일행(nx1),단일행-다중행(1xn),다중행-다중열(nxn)

-- 부속질의의 결과가 다중행-단일열로 여러 개의 값을 반환하면
-- 앞에서 배운 in키워드를 사용한다

--예) 도서를 구매한 적이 있는 고객의 이름을 검색하시오
--도서를 구매한한 적이 있는 고객 조회
select custid
from orders;

select name
from customer
where custid in (1,2,3,4);

--도서를 구매한 적이 있는 고객의 이름을 검색하시오.
select name
from customer
where custid in (select custid
                    from orders);
                    
-- 세 개 이상의 중첩된 부속질의도 가능하다

-- 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select name
from customer
where custid in (select custid
                    from orders
                    where bookid in(select bookid
                                    from book
                                    where publisher='대한미디어'));
-- 실행 순서는 하위 부족질의를 먼저 실행하고 그 결과를 이용하여
-- 상위 부속질의를 실행한다

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
select b1.bookname
from book b1
where b1.price>(select avg(b2.price)
                from book b2
                where b2.publisher=b1.publisher);
-- 테이블에도 별칭을 줄수 있다







