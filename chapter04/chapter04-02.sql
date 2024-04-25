--Documents\dev\database\workspace\chapter04\chapter04-02.sql

-- 02 부속질의
-- 일반적으로 데이터가 대향일 경우 데이터를 모두 합쳐서 연산하는 조인보다
-- 필요한 데이터만 찾아서 공급해 주는 부속질의가 성능이 더 좋다

-- 예) 마당 서점 도서를 주문한 고객의 이름을 검색하시오
-- 고객 이름과 주문 내역을 같이 보려면 
-- orders테이블과 customer테이블을 연관시켜야 한다
-- 조인을 사용할 경우
-- customer 테이블과 orders 테이블의 고객번호로 조인한 후 필요한 데이터를 추출한다
-- 부속질의를 사용할 경우
-- customer 테이블에서 박지성 고객의 고객번호를 찾고
-- 찾은 고객번호를 바탕으로 orders 테이블에서 확인한다

-- 부속질의는 sql문 안에 다른 sql문이 중첩된 질의를 말한다
-- 주 질의(main query, 외부질의)와 부속질의(subquery,내부질의)로 구성 된다
-- select 부속질의, from 부속질의, where 부속질의
-- 중첩질의 / where절 / nested subqeury, predicate subquery
-- / where 절에 술어와 같이 사용되면 결과를 한정시키기 위해 사용된다
-- 스칼라 부속질의 / select절 / scalar subquery
-- / select 절에서 사용되며 단일 값을 반환하기 때문에 스칼라 부속질의라고 한다
-- 인라인 뷰 / from 절 / inline view, table subqeury
-- from절에서 결과를 뷰(view)형태로 반환하기 때문에 인라인 뷰라고 한다

-- 중첩질의 - where 부속질의
-- 중첩질의 연산자의 종류
-- 비교 / =,>,<.>=,<=,<>
-- 집합 / in, not in
-- 한정 / all, some(any)
-- 존재 / exists, not exists

-- 비교 연산자
-- 부속질의 결과가 반드시 단일 행, 단일 열을 반환해야 한다
-- 처리과정은 주 질의의 대상 열 속성의 값과 부속질의의 결과값을
-- 비교 연산자에 작용하여 참이면 주 질의의 해당 행을 출력한다

-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
select orderid, saleprice from orders
where saleprice<=(select avg(saleprice) from orders);

-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서
-- 주문번호, 고객번호, 금액을 보이시오.
select orderid, custid, saleprice from orders
where saleprice>(select avg(saleprice) from orders);









