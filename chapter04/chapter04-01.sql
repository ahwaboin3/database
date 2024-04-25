--Documents\dev\database\workspace\chapter04\chapter04-01.sql

-- sql고급
-- 01 내장함수
-- sql 내장 함수
-- sql 내장 함수는 다음과 같이 select 절과 where절, update절등에서
-- 모두 사용할 수 있다
-- select 함수명(인자1, 인자2, ...)
-- from 테이블 이름
-- where 열이름=함수명(인자1, 인자2, ...);
-- update 테이블이름
-- set 열이름=함수명(인자1,인자2,...);

-- 오라클에서 제공하는 내장 함수
-- 숫자 함수
-- sql문에서는 수학의 기본적인 사칙 연산자(+,-,*,/)와 나머지(%)연산자 기호를
-- 그대로 사용한다
-- 사직 연산자 외에도 여러 연산자가 있다
-- 이러한 연산자 중 사용 빈도가 높은 것을 내장 함수로 형태로 제공한다
-- abs함수 - 숫자의 절댓값 계산
-- -78과 +78의 절댓값을 구하시오.
select abs(-78),abs(+78)
from dual;

-- from절에서 dual테이블
-- dual 테이블은 실제로 존재하는 테이블이 아니라 오라클에서
-- 일시적인 연산 작업에 사용하기 위해 만든 가상의 테이블이다

-- round(숫자, m) 함수 - m자리를 기준으로 숫자 반올림
-- 4.875를 숫자 첫째 자리까지 반올림한 값을 구하시오.
select round(4.875,1)
from dual;

-- 숫자 함수의 연산
-- 인자에 숫자 대신 열이름도 사용할 수 있고 여러 함수를 복합적으로
-- 사용할 수도 있다
-- 고객별 평균 주문 금액의 백 원 단위로 반올림한 값을 구하시오.
select custid "고객 번호",round(sum(saleprice)/count(*),-2) 평균금액
from orders group by custid;

-- 문자 함수
-- 문자 데이터 타입을 가공한 결과를 반환한다.
-- replace(s1,s2,s3) 함수 대상문자열(s1)의 지정한 문자를(s2)
-- 원하는 문자(s3)로 변경
-- 도서 제목에 야구가 포함된 도서를 '농구'로 변경한 후 도서 목록을 보이시오.
select bookid, replace(bookname,'야구','농구') bookname, publisher, price
from book;

-- length(s) 함수 - 대상 문자열의 글자 수를 반환
-- length - 문자의 수, lengthb - 바이트 단위로 반환
-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
select bookname, length(bookname), lengthb(bookname)
from book where publisher='굿스포츠';

-- substr(s,n,k) 함수 - 대상 문자열의 지정된 자리에서부터 지정된
-- 길이만큼 잘라서 반환

-- 마당서점의 고객 중에서 같은 성(last name)을 가진 사람이 몇 명이나 되는지 
-- 성별 인원수를 구하시오.
select substr(name,1,1), count(*)
from customer group by substr(name,1,1);
select * from customer;
insert into customer values(5,'박세리','대한민국 서울',null);

-- 날짜 시간 함수
-- 날짜 시간 함수의 종류
-- datetime - 날짜와 시간을 나타내는 인수
-- char - 문자나 문자열
-- to_date(char, datetime)
-- 문자형(char)데이트를 date형으로 반환
-- to_char(date, datetime)
-- date형 데이터를 문자열(varchar2)로 반환
-- add_months(date,숫자)
-- 날짜에 지정한 달을 더해 date형으로 반환(1:다음달, -1:이전달)
-- last_day(date)
-- 날짜에 달의 마지막 날을 date형으로 반환
-- sysdate
-- dbms 시스템상의 당일 날짜를 date형으로 반환하는 인자가 없는 함수

-- 마당서점은 주문일로부터 10일 후 매출을 확정한다, 각 주문의 확정일자를 구하시오
select orderid, orderdate , orderdate+10
from orders;
-- 날짜형 데이터는 -와+를 사용하여 원하는 날짜로부터 이전과 이후를 계산할 수 있다

-- sysdate함수는 데이터베이스에 설정된 현재 날짜와 시간을 반환
-- systimestamp 함수는 현재 날짜, 시간과 함께 초 이하의 시간과 서버의
-- timezone까지 출력해 준다
-- dbms서버에 설정된 현재 날짜와 시간, 요일을 확인하시오
select sysdate, to_char(sysdate, 'yyyy/mm/dd/ dy hh24:mi:ss')
from dual;

select * from orders;
insert into orders values(12,1,1,6000,sysdate);

-- null 값 처리
-- null 값에 대한 연산과 집계 함수
-- 집계 함수를 사용할 때 null값이 포함된 행에 대한 주의사항
-- 1. null+숫자 연산의 결과는 null이다
-- 2. 집계 함수를 계산할 때 null이 포함된 행은 집계에서 빠진다
-- 3. 집계 함수에 적용되는 행이 하나도 없으면
-- sum, avg 함수의 결과는 null이 되고, count함수의 결과는 0이다

create table mybook(
    bookid number primary key,
    price number);
insert into mybook values(1,1000);
insert into mybook values(2,2000);
insert into mybook values(3,null);
select * from mybook;

-- 1. null+숫자 연산의 결과는 null이다
select price+100 from mybook where bookid=3;

-- 2. 집계 함수를 계산할 때 null이 포함된 행은 집계에서 빠진다
select count(*),count(price),sum(price),avg(price) from mybook;

-- 3. 집계 함수에 적용되는 행이 하나도 없으면
-- sum, avg 함수의 결과는 null이 되고, count함수의 결과는 0이다
select sum(price),avg(price),count(*)
from mybook where bookid>=4;

-- null 값을 확인하는 방법 - is null, is not null
-- mybook 테이블의 price가 null 값 찾기
select * from mybook where price is null;
-- mybook 테이블의 price가 null이 아닌 값 찾기
select * from mybook where price is not null;

-- nvl함수
-- nvl함수는 null 값을 다른 값으로 대치하여
-- 연산하거나 다른 값으로 출력
-- null값을 임의의 다른 값으로 변경할 수 있다
-- nvl(속성, 값)형식으로 사용
-- 속성이 null 값이면 값으로 대치한다

-- 이름, 전화번호가 포함된 고객목록을 보이시오.
-- 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오.
select * from customer;
select name,nvl(phone,'연락처없음') from customer;

-- rownum 문법
-- 오라클 내부적으로 생성되는 가상 컬럼으로 sql 조회 결과의 순번을 나타낸다

-- 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
select rownum, custid,name,phone from customer
where rownum<=2;

-- rownum 사용 시 주의사항
-- 가나다순으로 정리된 고객목록에서 고객번호, 이름, 전화번호를
-- 앞의 두 명만 보시시오.
select rownum, custid, name, phone
from customer
where rownum <=2
order by name;

-- 오라클의 select문 처리순서
-- 1. from customer - customer 테이블을 읽어 들임
-- 2. where rownum <=2 - 오라클이 데이터를 읽은 순서대로 두 개 투플 선택
-- 3. select rownum, custid, name, phone - 속성 열을 선택
-- 4. order by name - 이름순으로 정렬

-- 부속질의를 사용
select rownum 순번, custid, name, phone
from (select custid, name, phone
        from customer order by name)
where rownum<=2;








