--Documents\dev\database\workspace\chapter03\chapter03-04.sql
--집계 함수와 group by 검색
--집계는 통계와 비슷한 의미로 데이터베이스에서는 통계보다 집계라는 용어를 사용한다
--도서 판매 총액, 일별 판매량등 집계된 정보
--집계하기 위해서는 group by 문을 사용하고 구체적인 집계 내용은 집계 함수를 사용한다

--집계 함수
-- sum / sum([all|distinct] 속성이름) / 합계
-- avg / avg([all|distinct] 속성이름)/ 평균
-- count / count([all|distinct] 속성이름 |*)/갯수
-- max / max([all|distinct] 속성이름)/ 최대값
-- min / min([all|distinct] 속성이름)/ 최소값

-- 고객이 주문한 도서의 총판매액을 구하시오.
select * from orders;
select sum(saleprice)
from orders;

-- sql문에서 sum(saleprice)는 저장된 데이터를 가공하여 얻은 새로운 결과 열이기 때문에
--결과 테이블에 별도의 이름 없이 'sum(saleprice)'라고 출력된다
-- 의미 있는 열 이름을 출력하고 싶으면 속성이름의 별칭을 지칭하는
-- as키워드를 사용하여 열 이름을 부여 한다
select sum(saleprice) as 총매출
from orders;

-- 최근 버전의 dbms에서는 as 키워드를 생략할 수 있다
select sum(saleprice) 총매출
from orders;
select sum(saleprice) "전체 매출"
from orders;

-- 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오.
select sum(saleprice)
from orders
where custid=2;

-- 집계 함수는 여러 개를 혼합하여 쓸 수 있다

-- 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오.
select sum(saleprice) as total,
    avg(saleprice) as average,
    min(saleprice) as minimum,
    max(saleprice) as maximum
from orders;

-- 집계 함수 count는 행의 개수를 센다
-- count()의 괄호 안에는 *혹은 속성의 이름이 사용되며
-- 해당 속성의 투플의 개수를 세어 준다
-- 투플의 개수 - 카디널리티
-- count(*)는 전체 투플의 수를 세어준다(특성 속성의 null값은 무시 한다)
-- count(publisher)는 출판사의 수를 세어주는데 null값은 제외된다
-- count(distinct publisher)는 중복을 제거한 출판사의 수를 세어 준다(null값은 제외)

-- 마담서점의 도서 판매 건수를 구하시오.
select count(*)
from orders;

-- group by 검색
-- sql문에서 group by 절을 사용하면 같은 속성값끼리 그룹을 만들 수 있다

-- 고객별로 주문한 도서의 총수량과 총판매액을 구하시오.
select custid, count(*) as 도서수량, sum(saleprice) as 총액
from orders
group by custid;
select * from orders order by custid;

-- having 절은 group by 절의 결과에서 나타나는 구룹을 제한하는 역활을 한다

-- 가격이 8000원 이상인 도서를 구매한 고객에 대하여
-- 고객별 주문 도서의 충수량을 구하시오.
-- 단, 2권이상 구매한 고객만 구하시오.
select custid, count(*) as 도서수량
from orders
where saleprice >=8000
group by custid
having count(*)>=2;

-- group by와 having 절 사용시 주의 사항
-- group by로 투플을 그룹으로 묶은 후 
-- select절에는 group by에서 사용한 속성과 집계함수만 나올 수 있다
select sum(saleprice),bookid -- 틀린 예
from orders
group by custid;
select sum(saleprice),custid -- 맞는 예
from orders
group by custid;

-- where절과 having절이 같이 포함된 sql문은 검색조건이 모호해질 수 있다
-- having절 주의 사항
-- 1. 반드시 group by 절과 같이 작성해야 한다
-- 2. where 절보다 뒤에 나와야 한다
-- 3. 검색조건에는 sum,avg,max,min,count와 같은 집계 함수가 와야 한다

-- group by 절이 포함된 sql 문의 실행 순서
select custid, count(*) as 도서수량 ---- 5    
from orders --------------------------- 1
where saleprice>=8000 ----------------- 2
group by custid ----------------------- 3
having count(*)>1 --------------------- 4
order by custid; ---------------------- 6













