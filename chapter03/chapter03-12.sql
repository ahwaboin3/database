--Documents\dev\database\workspace\chapter03\chapter03-12.sql

-- 연습 문제 풀이

-- [극장 데이터 베이스]
-- 극장 테이블
create table theater(
    ttid number primary key,
    ttname varchar2(30),
    ttlocation varchar2(30)
);
-- 상영관 테이블
-- 영화 가격은 20000원을 넘지 않아야 한다
create table cinema(
    ttid number,
    cid number,
    moviename varchar2(40),
    movieprice number check(movieprice<20000),
    chairnumber number,
    primary key (ttid,cid)
);
-- 예약 테이블 생성
-- 상영관 번호는 1부터 10사이이다
-- 같은 사람이 같은 좌석번호를 두 번 예약하지 않아야 한다
create table reservation(
    ttid number,
    cid number check(cid>=1) check(cid<=10),
    cusid number,
    seatnumber number unique,
    rdate date,
    primary key(ttid,cid,cusid)
);
-- 고객 테이블 생성
-- 문자열의 크기: 바이트
-- 예) varchar2(20)
-- 20byte -> 유니코드(unicode)는 한글자에 2byte
-- 10글자정도 넣을 수 있는 크기
create table movie_customer(
    cusid number primary key,
    cusname varchar2(50),
    cusaddr varchar2(300)
);

-- [판매원 데이터베이스]
-- 판매원 테이블 생성
create table sales_person(
    name varchar2(100) primary key,
    age number,
    salary number
);

--주문 테이블 생성
drop table sales_order;
create table sales_order(
    onumber number,
    custname varchar2(50),
    salesperson varchar(50),
    amount number,
    primary key (onumber),
    foreign key(custname) references sales_customer(name),
    foreign key(salesperson) references sales_person(name)
);
-- 고객 테이블 생성
create table sales_customer(
    name varchar2(50) primary key,
    city varchar2(50),
    industrytype varchar2(50)
);

-- [기업 프로젝트 데이터베이스]
-- 직원 테이블 생성
create table b_employee(
    empno number primary key,
    name varchar2(50),
    phoneno varchar2(20),
    address varchar2(100),
    sex char(1),
    position varchar2(50),
    deptno number
);

-- 부서 테이블 생성
create table b_department(
    deptno number primary key,
    deptname varchar2(50),
    manager number
);
-- 프로젝트 테이블 생성
create table b_project(
    projno number primary key,
    projname varchar2(50),
    deptno number
);

-- 작업 테이블 생성
create table b_works(
    empno number,
    projno number,
    hours_worked number,
    primary key(empno, projno),
    foreign key(empno) references b_employee(empno),
    foreign key(projno) references b_project(projno)
);






















