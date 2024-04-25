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

-- in, not in 
-- in은 주 질의의 속성값이 부속질의에서 제공한 결과 집합에 있는지
-- 확인하는 역활을 한다
-- in 연산자에서 사용 가능한 부속질의는 결과로
-- 다중 행, 다중 열을 반환할 수 있다
-- where 절에 사용되는 속성값을 부속질의의 결과 집합과
-- 비교해 하나라도 있으면 참이 된다
-- not in 연산자는 값이 존재하지 않으면 참이 된다

-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오
select sum(saleprice) from orders
where custid in (
select custid from customer where address like '%대한민국%');

-- all, some(any)
-- all, some(any) 연산자는 비교 연산자와 함께 사용된다
-- all은 모든, some은 어떠한(최소한 하나라도)이라는 의미를 가진다
-- any는 some과 동일한 기능을 한다
-- 구문 구조
-- 열이름 {비교 연산자}{all|some|any}(부속질의)

-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의
-- 주문 번호와 금액을 보이시오.
select orderid, saleprice from orders
where saleprice>all (select saleprice from orders where custid=3);

-- exists, not exists
-- 존재 연산자, 데이터의 존재 여부를 확인한다
-- 주 질의에서 부속질의로 제공된 속성의 값을 가지고
-- 부속질의의 조건을 만족하여 값이 존재하면 참이 되고
-- 주 질의는 해당 행의 데이터를 출력한다
-- not exist의 경우 이와 반대로 동작한다
-- 구문 구조
-- where [not] exists (부족질의)
-- exists 연산자는 왼쪽에 열을 명시하지 않는다
-- 반드시 부속질의에 주 질의의 열이름이 제공되어야 한다

-- exists 연산자를 사용하여 '대한민국'에 거주하는 
-- 고객에게 판매한 도서의 총판매액을 구하시오
select sum(saleprice) from orders o
where exists (select * from customer c where address like '%대한민국%'
    and c.custid=o.custid);
    
-- 스칼라 부속질의 - select 부속 질의
-- 스칼라 부속질의는 select절에서 사용되는 부속질의로
-- 부속질의의 결과값을 단일 행, 단일 열의 값으로 반환한다
-- 스칼라 - 하나의 숫자로만 표시되는 양

-- 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력)
select 
(select name from customer c where c.custid=o.custid), 
sum(saleprice) 
from orders o
group by custid;

-- 스칼라 부속질의는 select문과 함께 update문에서도 사용할 수 있다
-- orders 테이블에 새로운 속성인 도서 이름을 추가
alter table orders add bookname varchar2(40);
select * from orders;

-- 모든 도서에 대하여 도서이름을 수정해야 한다
update orders set bookname='피겨 교본' where bookid=1;
-- 이러한 과정은 모든 도서에 대하여 일일이 처리해야 하므로 비효율적이다
-- 스칼라 부속질ㄹ의를 사용하면 도서이름을 일괄 수정할 수 있다

-- orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
update orders set bookname=(
    select bookname
    from book
    where book.bookid=orders.bookid);
select * from orders;

-- 인라인 뷰 - from 부속질의
-- 뷰는 기존 테이블로부터 일시적으로 만들어진 가상의 테이블을 말한다

-- 고객번호가 2 이하인 고객의 판매액을 보이시오(고객 이름과 고객별 판매액 출력)
select c.name,sum(o.saleprice)
from (select custid, name
    from customer where custid<=2) c,
    orders o
where c.custid=o.custid
group by c.name;
-- customer 테이블에서 필요한 데이터만 뽑아 조인시킬 수 있으므로
-- 처리 성능을 높일 수 있다








