--Documents\dev\database\workspace\chapter03\chapter03-16.sql

--[기업 프로젝트 데이터 베이스]
-- chapter03-12.sql에 있는 테이블 생성문으로 테이블 생성
-- 1. 테이블을 생성하는
-- 2. 모든 사원의 이름을 보이시오
select name from b_employee;

insert into b_employee 
values(1,'남사원1','010-1','주소1','m','사원1',1);
insert into b_employee 
values(2,'남사원2','010-2','주소2','m','사원1',2);
insert into b_employee 
values(3,'여사원3','010-3','주소3','f','사원1',1);
insert into b_employee 
values(4,'여사원4','01041','주소4','f','사원1',2);

-- 3. 여자 사원의 이름을 보이시오.
select name from b_employee where sex like 'f';

-- 4. 팀장(manager)의 이름을 보이시오
select name from b_employee e, b_department d
where e.deptno=d.deptno and e.empno in 
(select manager from b_department);

select name from b_employee e
where empno in (select manager from b_department);

insert into b_employee 
values(5,'김팀장1','010-5','주소5','m','manager',1);
insert into b_employee 
values(6,'김팀장2','010-6','주소6','f','manager',2);

alter table b_department modify manager number;

insert into b_department values(1,'부서1',5);
insert into b_department values(2,'부서2',6);

update b_employee set position='부장' where empno=5;
update b_employee set position='과장' where empno=6;

-- 5. IT부서에서 일하는 사원의 이름과 주소
select e.name,e.address from b_department d, b_employee e
where d.deptno=e.deptno and d.deptname like 'IT';

insert into b_employee 
values(7,'김직원7','010-7','주소7','m','사원',3);
insert into b_employee 
values(8,'김직원8','010-8','주소8','f','대리',3);
insert into b_employee 
values(9,'김직원9','010-9','주소9','f','부장',3);
insert into b_department values(3,'IT',9);

-- 6. 홍길동 팀장(manager)부서에서 일하는 사원의 수를 보이시오.
select count(*) from b_department d, b_employee e
where d.deptno=e.deptno and d.manager =
(select empno from b_employee where name like '홍길동');

insert into b_employee 
values(10,'김직원10','010-10','주소10','f','사원',4);
insert into b_employee 
values(11,'김직원11','010-11','주소11','m','대리',4);
insert into b_employee 
values(12,'홍길동','010-12','주소12','m','이사',4);
insert into b_department values(4,'정의의도적',12);

--7 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오.
select w.hours_worked, e.deptno, e.name
from b_works w, b_employee e
where w.empno=e.empno
order by e.deptno, e.name;

insert into b_project values(1,'기업데이터베이스구축',3);

insert into b_works values(7,1,100);
insert into b_works values(8,1,200);
insert into b_works values(9,1,300);

-- 8. 2명 이상의 사원이 참여한 프로젝트의 번호, 이름, 사원의 수를 보이시오.
insert into b_project values(2,'기업인트라넷구축',3);
insert into b_works values(10,2,100);

select projno,projname,count(*)
from b_project
where projno=
(select projno from b_works 
group by projno
having count(*)>1);

select p.projno,p.projname,count(*)
from b_project p inner join b_works w
on p.projno=w.projno
group by p.projno,p.projname
having count(*)>1;

select p.projno,p.projname,count(*) as 사원수
from b_project p, b_works w
where p.projno=w.projno
group by p.projno,p.projname
having count(*)>1;

-- 9. 3명 이상의 사원이 있는 부서의 사원 이름을 보이시오.
select name
from b_employee
where deptno in
(select deptno from b_employee
group by  deptno having count(*)>=3);






