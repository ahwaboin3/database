-- 주석
-- SQL 소개
-- Documents\dev\database\workspace\chapter03\chapter03-01.sql
-- DBMS에 원하는 내용을 비교적 쉽게 알려 주고 결과를 얻는데 사용하는
-- 데이터베이스 전용 언어가 SQL이다
-- 축구의 역사라는 도서의 출판사와 가격을 알고 싶다
select bookname,publisher,price
from book
where bookname like '축구의 역사';
-- SQL - Structured Query Language
-- SQL은 기능에 따라 데이터 정의어, 데이터 조작어, 데이터 제어어로 나뉜다
-- 데이터 정의어DDL-테이블이나 관계의 구조를 생성하는데 사용하며
-- create, alter, drop문이 등이 있다
-- 데이터 조작어 DML - 테이블에 데이터를 검색, 삽입, 수정, 삭제하는데 사용하며
-- select, insert, delete, update문 등이 있다. 여기서 select문은 특별히
-- 질의어(query)라고 부른다
-- 데이터 제어어 DCL - 데이터의 사용 권한을 관리하는 데 사용하며
-- grant, revoke문 등이 있다



