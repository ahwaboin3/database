--Documents\dev\database\workspace\chapter03\chapter03-10.sql

-- 데이터 정의어(DDL, data definition language)
-- 데이터 정의어는 테이블의 구조를 만드는 create문
-- 구조를 변경하는 alter문, 구조를 삭제하는 drop문이 있다

-- create 문
-- create문의 문법
-- create table 테이블 이름
-- ({속성이름 데이터 타입
--  [null|not null|unique|default 기본값|check 체크조건]
-- }
--  [primary key 속성이름(들)]
--  [foreign key 속성이름 references 테이블이름(속성이름)]
--    [on delete{cascade|set null}]
-- )

-- 다음과 같은 속성을 가진 NewBook테이블을 생성하시오.
-- 정수형은 number를 사용하며 문자형은 가변형 문자타입인 varchar2를 사용한다
-- bookid(도서 번호)-number
-- bookname(도서이름)-varchar2(20)
-- publisher(출판사)-varchar2(20)
-- price(가격)-number

-- 문자형 데이터 타입 - char, varchar, varchar2
-- char(n) - n바이트를 가진 문자형 타입이다
-- 저장되는 문자의 길이가 n보다 작으면 나머지는 공백으로 채워서
-- n바이트를 만들어 저장한다
-- 예) char(20)
-- varchar(n)-n바이트를 가진 문자형 타입이지만
-- 저장되는 문자의 길이 만큼만 기억장소를 차지하는 가변형이다
-- 예) varchar(20)
-- varchar2(n) - varchar(n)타입과 같지만 오라클에서 사용을 추천

create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- 기본키를 지정
create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid)
);
drop table newbook;

-- 기본키 지정 2번째 방법
drop table newbook;
create table newbook(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);
-- 두개의 속성을 기본키로 지정
drop table newbook;
create table newbook(
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookname,publisher)
);

drop table newbook;
-- 제약사항 추가
-- bookname은 null값을 가질 수 없고, publisher는 같은 값이 있으면 안 된다.
-- price에 값이 입력되지 않을 경우 기본값 10000을 저장한다
-- 또 가격은 최소 1000원 이상으로 한다
create table newbook(
    bookname varchar2(20) not null,
    publisher varchar2(20) unique,
    price number default 10000 check(price>1000),
    primary key (bookname, publisher));
    
-- 다음과 같은 속성을 가진 NewCustomer테이블을 생성하시오
-- custid(고객번호)-number, 기본키
-- name(이름) - varchar2(40)
-- address(주소)-varchar2(40)
-- phone(전화번호) - varchar2(30)

create table newcustomer(
    custid number primary key,
    name varchar2(40),
    address varchar2(40),
    phone varchar2(30));
    
-- 다음과 같은 속성을 가진 neworders 테이블을 생성하시오.
-- orderid(주문번호) - number, 기본키
-- custid(고객번호)-number, not null 제약조건
-- bookid(도서번호) - number, not null 제약조건
-- saleprice(판매가격)- number
-- orderdate(판매일자) - date

create table neworders(
    orderid number,
    custid number not null,
    bookid number not null,
    saleprice number,
    orderdate date,
    primary key(orderid));
    
-- custid(고객번호)-number, not null제약 조건, 
-- 외래키(newcustomer.custid, 연쇄삭제)
drop table neworders;
create table neworders(
    orderid number,
    custid number not null,
    bookid number not null,
    saleprice number,
    orderdate date,
    primary key(orderid),
    foreign key(custid) references newcustomer(custid) 
    on delete cascade
);
-- 외래키 제약조건을 명시할 때는 주의할 점
-- 반드시 참조되는 테이블(부모 테이블)이 존재해야 하며
-- 참조되는 테이블의 기본키여야 한다
-- 외래키 지정 시 on delete옵션
-- cascade - 연쇄 삭제
-- set null - null 값으로 바꾼다
-- no action - 기본값으로 어떠한 동작도 취하지 않는다

-- 속성 데이터 타입 종류
-- number(p,s)/실수형 p자리 정수 부분, s자리는 소수부분
-- p와 s를 생략하여 number라고 쓰면 number(8,2)로 저장된다
-- char(n)/문자형 고정길이, 문자를 저장하고 남은 공간은 공백으로 채운다
-- varchar2(n)/문자형 가변길이, 4000바이트까지 저장된다
-- date / 날짜형, 연도, 월, 일, 시간을 지정한다













