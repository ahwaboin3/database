--Documents\dev\database\workspace\chapter07\c07-01.sql

-- commit문과 rollback문
select * from customer;
-- 고객 테이블에서 5번 고객을 삭제 한다
delete from customer where custid=5;
select * from customer;

-- 일시적으로 반영된 데이터를 복원시키려면 rollback 명령어를 사용한다
rollback;
select * from customer;

-- 다시 고객 테이블에서 5번 고객을 삭제 한다
delete from customer where custid=5;

-- commit 명령어로 데이터베이스에 삭제 작업을 반영시켜 본다
commit;

-- 다시 rollback 명령어 사용
rollback;
select * from customer;

-- commit이라는 명령어는 이전 commit지점에서 적용됐던
-- sql문을 완전히 적용하는 명령어
-- rollback 이전의 commit명령어 전까지 되돌리는 명령어입니다

insert into customer values(5,'박세리','대한민국 서울',null);




