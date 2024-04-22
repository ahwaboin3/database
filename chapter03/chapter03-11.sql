--Documents\dev\database\workspace\chapter03\chapter03-11.sql

-- alter문
-- alter문은 생성된 테이블의 속성과 속성에 관한 제약을 변경하며
-- 기본키 및 외래키를 변경한다
-- alter문의 문법
-- alter table 테이블이름
--  [add 속성이름 데이트 타입]
--  [drop column 속성이름]
--  [alter column 속성이름 데이터타입]
--  [alter column 속성이름 [null|not null]
--  [add primary key(속성이름)]
--  [[add|drop]제약이름]
-- modify는 속성을 변경할 때 사용한다

-- 실습할 newbook 테이블 생성
drop table newbook;
create table newbook(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number);

-- newbook 테이블에 varchar2(13)의 자료형을 가진 isbn속성을 추가하시오.
alter table newbook add isbn varchar2(13);

-- newbook 테이블의 isbn속성의 데이터 타입을 number형으로 변경하시오
alter table newbook modify isbn number;

-- newbook 테이블의 isbn속성을 삭제하시오.
alter table newbook drop column isbn;

-- newbook테이블의 bookname속성에 not null 제약조건을 적용하시오.
alter table newbook modify bookname varchar(20) not null;

-- newbook테이블의 bookid 속성을 기본키로 변경하시오.
alter table newbook add primary key(bookid);

-- drop문
-- 테이블을 삭제하는 명령이다
-- drop문은 테이블의 구조와 데이터를 모두 삭제하므로 사용에 주의해야 한다
-- 데이터만 삭제하려면 delete문을 사용한다
-- drop문의 문법
-- drop table 테이블 이름

--newbook 테이블을 삭제하시오
drop table newbook;

--newcustomer 테이블을 삭제하시오
drop table newcustomer;
-- neworders 테이블이 newcustomer를 참조하고 있는 상태이다
-- neworders 테이블부터 삭제 해야 한다
drop table neworders;
drop table newcustomer;








