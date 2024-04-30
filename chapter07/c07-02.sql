--Documents\dev\database\workspace\chapter07\c07-01.sql

-- 보안과 권한

-- 로그인 사용자 관리
-- 데이터베이스에 접근하는 각 사용자는 사용자 ID를 가지고 있으며
-- 비밀번호로 접근이 허용된다

-- 권한 관리
-- 모든 각각의 테이블 각각의 sql문도 사용자별로 접근해서 적용할 수 있는
-- 권한이 따로 관리 된다

-- 테이블스페이스와 로그인 사용자 관리
-- 오라클의 데이터 파일은 논리적인 개념인 테이블스페이스 단위로 사용된다
-- 오라클에서 테이블스페이스를 만들고 신규 사용자를 생성하여
-- 할당하는 과정을 살펴보자
-- 오라클 제공하는 USER는 system,sys가 있습니다

-- CDB, PDB
-- CDB는 기본적으로 db가 생성되면 default로 존재하는 cdb 전체 데이터
-- 예) 아파트
-- PDB는 사용자 스키마, 데이터, 코드와 기타 데이터베이스 관련 오브젝트를
-- 담고 있는 유저가 만든 개체이다
-- 하나의 cdb는 복수 개의 pdb를 가질 수 있다
-- 예)아파트 안의 각각의 입주자를 뜻함
-- cdb user는 C##을 앞에 붙어야 한다

-- xe버전의 경우 xepdb1이라는 이름으로 pdb가 생성되어 있다

-- 테이블스페이스 생성하기
-- 테이블스페이스는 오라클에서 데이터를 저정할 때 사용하는
-- 논리적인 저장공간을 의미한다
-- 자동으로 만들어지는 시스템 테이블스페이스가 있고
-- 사용자가 필요에 따라 만들어 사용하는 사용자 테이블스페이스가 있다

-- 예)데이터를 백업하기 위해서등등

-- 사용 테이블스페이스 생성
-- DBA(최고 관리자)권한이 부여된 system계정으로만 생성할 수 있다.
-- create tablespce 문법
/*
    create tablespace 테이블스페이스명
        datafile '저장될 경로 및 사용할 파일명'
        size 저장 공간
*/
-- 10m의 용량을 가진 테이블스페이스를 md_tbs,mb_test를
-- C:\Users\ITPS\Documents\dev\database\workspace\chapter07
-- 폴더에 생성하시오.
-- 이때 데이터 파일 이름은 각각 md_tbs_data01.dbf, md_test_data01.dbf
-- (폴더 위치는 폴더가 없으면 미리 생성해야 한다)
create tablespace md_tbs
    datafile 'C:\Users\ITPS\Documents\dev\database\workspace\chapter07\md_tbs_data01.dbf'
    size 10m;
create tablespace md_tbs
    datafile 'C:\dev\md_tbs_data01.dbf'
    size 10M;
create tablespace md_test
    datafile 'C:\dev\md_test_data01.dbf'
    size 10M;

-- drop tablespace
-- 테이블 스페이스 삭제시 사용하는 명령이다
-- 문법
/* 
    drop tablespace 테이블스페이스명
        [including contents [and datafiles][cascade constraints]];
*/
-- including contents:테이블스페이스의 모든 데이터를 삭제한다
-- and datafiles:os상의 물리적인 데이터 파일을 삭제한다
-- (이 옵션이 없다면 실제 데이터 파일은 삭제되지 않는다)
-- cascade constraints:다른 테이블스페이스의 테이브리로부터 참조되는
-- 제약조건들까지 모두 삭제한다

-- md_test 테이블스페이스를 데이터 파일까지 포함하여 모두 삭제하시오.
drop tablespace md_test including contents and datafiles;

-- 신규 사용자 계정 생성하기
-- create user
-- 사용자 계정을 생성하는 명령이다
-- 문법
/*
create user [사용자이름]
    indentified by [비밀번호]
    default tablespace [테이블스페이스];
*/
-- default tablespace를 지정하지 않으면 
-- 오라클에서 기본으로 users테이블스페이스를 할당한다

-- alter user
-- 비밀번호와 같은 사용자 계정의 설정을 변경하는 명령이다
-- 문법
/*
    alter user [사용자이름]
        indentified by [비밀번호];
*/

-- drop user
-- 사용자 계정을 삭제하는 명령이다.
-- casecade를 사용하면 삭제 시점에 사용자가 보유한 모든 데이터를 같이 삭제한다
-- 문법
/* 
    drop user [사용자이름] cascade;
*/

-- 새로운 사용자 mdguest를 생성하시오. 비밀번호는 mdguest, 
-- 테이블 스페이스는 기본값이 users로 설정한다
create user mdguest
    identified by mdguest;
    
-- 새로운 사용자 mdguest2를 생성하시오. 비밀번호는 mdguest2,
-- 테스트스페이스는 앞에서 생성한 md_tbs로 설정한다
create user mdguest2 identified by mdguest2
default tablespace md_tbs;

-- 권한 관리
-- mdguest, mdguest2 사용자에게 데이터베이스 접속(connect) 및
-- 테이블 생성(resource) 권한, 
-- 테이블스페이스를 무제한으로 사용할 수 있는 권한(unlimited tablespace)
-- 을 부여하시오
-- pdb1/system 계정으로 접속
grant connect,resource, unlimited tablespace to mdguest;
grant connect,resource, unlimited tablespace to mdguest2;

-- 권한 허가 - grant
-- grant 문은 객체를 생성한 소유자가 대상 객체에 대한 권한을
-- 다른 사용자에게 허가하는 명령이다
-- 문법
/* 
    grant 권한 [(컬럼[,...])][,...n]
        [on객체]to{사용자|롤|public[,...n]}
        [with grant option]
*/
-- [,...n]은 반복 가능을 의미한다
-- 권한 : 허가할 권한을 지정한다
-- alter, delete, execute, index, insert, references, select, update
-- 컬럼 : 사용 권한을 부여할 테이블의 열 이름을 지정한다
-- 객체: 사용 권한을 부여할 객체를 지정한다. 객체는 테이블이나 뷰 등을 말한다
-- to 사용자: 사용자나 권한의 묶음인 롤(role)에 권한을 추가할 수 있다
-- public은 모든 사용자가 사용할 수 있도록 공개적으로 권한을 부여한다는 의미
-- with grant option:허가 받은 권한을 다른 사용자에게 다시 부여할 수 있다

-- madang/madang 유저를 생성
create user madang identified by madang;
-- madang 사용자에게 권한 부여
grant connect, resource, unlimited tablespace to madang;

commit;

-- pdb1_madang 계정으로 접속
CREATE TABLE Book (
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8)
);
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

select * from book;

CREATE TABLE Customer (
custid NUMBER(2) PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(50),
phone VARCHAR2(20)
);
INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);
CREATE TABLE Orders (
orderid NUMBER(2) PRIMARY KEY,
custid NUMBER(2) REFERENCES Customer(custid),
bookid NUMBER(2) REFERENCES Book(bookid),
saleprice NUMBER(8),
orderdate DATE
);
INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2020-07-01','yyyy-mm-dd'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2020-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2020-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2020-07-04','yyyy-mm-dd'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2020-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2020-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE('2020-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2020-07-08','yyyy-mm-dd'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2020-07-09','yyyy-mm-dd'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2020-07-10','yyyy-mm-dd'));

commit;

-- pdb1_madang 계정으로 접속
-- mdguest에게 book 테이블의 select권한을 부여하시오
grant select on book to mdguest;

-- mdguest에게 customer테이블의 select, update 권한을
-- with grant option과 함께 부여하시오.
grant select, update on customer to mdguest with grant option;

-- public은 모든 사용자에게 권한을 부여하는 명령이다
-- orders테이블을 모든 사용자가 select할 수 있도록 권한을 부여하시오.
grant select on orders to public;

-- 권한 취소 - revoke
-- grant문으로 허가한 권한을 취소, 회수하는 명령이다
-- 문법
/*
    revoke 권한 [(컬럼[,...n])[,...n]
        [on 객체]from{사용자|롤|public[,...n]}
*/
-- mdguest에게 부여된 book테이블의 select권한을 취소하시오.
revoke select on book from mdguest;























