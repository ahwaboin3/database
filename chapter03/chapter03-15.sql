--Documents\dev\database\workspace\chapter03\chapter03-15.sql

--[판매원 데이터베이스]
-- (1) chapter03-14.sql에 만든 테이블 생성문을 실행

-- (2) 모든 판매원의 이름과 급여를 보이시오. 단, 중복 행은 제거 한다
select DISTINCT name, salary from sales_person;

-- sales_person에 데이터 삽입
insert into sales_person values('김판매1',31,3001);
insert into sales_person values('김판매2',32,3002);
insert into sales_person values('김판매3',33,3003);
insert into sales_person values('김판매4',34,3004);
insert into sales_person values('김판매5',35,3005);

-- 3. 나이가 30세 미만인 판매원의 이름을 보이시오.
insert into sales_person values('김판매6',26,2006);
insert into sales_person values('김판매7',27,2007);
select name from sales_person where age<30;

-- 4. 'S'로 끝나는 도시에 사는 고객의 이름을 보이시오
select name from sales_customer where city like '%s';
insert into sales_customer values('김고객1','New York','증권거래사');
insert into sales_customer values('김고객2','Los Angeles','movie star');
insert into sales_customer values('김고객3','Chicago','pizza store owner');
insert into sales_customer values('김고객4','Houston','farmer');
insert into sales_customer values('김고객5','Phoenix','pilot');
-- 5. 주문을 한 고객의 수(서로 다른 고객만)을 구하시오.
select count(distinct custname) from sales_order;
insert into sales_order values(1,'김고객1','김판매1',1001);
insert into sales_order values(2,'김고객2','김판매1',1001);
insert into sales_order values(3,'김고객2','김판매2',1001);
insert into sales_order values(4,'김고객3','김판매3',1001);
insert into sales_order values(5,'김고객4','김판매4',1001);
-- 6. 판매원 각각에 대하여 주문의 수를 계산하시오.
select salesperson, count(*) from sales_order group by salesperson;

-- 7. 'LA'에 사는 고객으로부터 주문을 받은 판매원의 이름과 나이를 보이시오
-- (부속질의 사용)
-- sales_customer테이블의 기본키를 onumber속성으로 변경
select name,age from sales_person
where name in
(select salesperson from sales_order
where custname in 
(select name from sales_customer where city='LA'));

 
insert into sales_customer values('김고객6','LA','직업6');
insert into sales_customer values('김고객7','LA','직업7');
insert into sales_order values(6,'김고객6','김판매1',1006);
insert into sales_order values(7,'김고객6','김판매1',1007);
insert into sales_order values(8,'김고객6','김판매3',1008);

-- 8. LA에 사는 고객으로 부터 주문을 받은 판매원의 이름과 나이를 보이시오
--(조인을 사용)
select p.name,p.age 
from sales_customer c, sales_order o, sales_person p
where c.name=o.custname 
and o.salesperson=p.name
and c.city like 'LA';

--9. 두 번 이상 주문을 받은 판매원의 이름을 보이시오.
select salesperson from sales_order
group by salesperson having count(*)>=2;

--10. 판매원 TOM의 봉급을 45,000원으로 변경하는 sql문을 작성하시오.
insert into sales_person values('TOM',38,2008);
update sales_person set salary=45000 where name like 'TOM';
select * from sales_person where name like 'TOM';










