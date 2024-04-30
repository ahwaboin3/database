-- pdb1_mdguest계정으로 접속
-- book 테이블 조회
select * from book;

-- 실제 mdguest사용자가 book테이블을 가지고 있지 않기 때문에
-- 위의 문장은 오류가 발생한다
-- 스키마.테이블이름 형식으로 사용해야 한다
select * from madang.book;

-- customer 테이블 조회
select * from madang.customer;

-- with grant option을 받았기 때문에 mdguest는 
-- customer테이블의 select, update 권한을 다른 사용자에게 부여 할 수 있다

-- (mdguest 계정으로)
-- madang.book 테이블과 madang.customer 테이블의 select 권한을
-- mdguest2에 부여하시오.
grant select on madang.customer to mdguest2;

select * from madang.book;





