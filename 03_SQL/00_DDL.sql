create user SKN13@localhost identified by '1111';
create user SKN13@'%' identified by '1111';

-- 생성된 계정을 확인
select user, host from mysql.user;

-- 실행 : control + enter
-- SQL문 작성: 한 명령문이 끝나면 ;으로 종료
#
/* block 주석 */


-- 계정에 권한 부여
-- grant 부여할 권한 on 대상 테이블 to 권한을 부여할 계정
grant all privileges on *.* to SKN13@localhost;
grant all privileges on *.* to SKN13@'%';

-- *:DB, .*:table

create database test_db;


show databases;
use

create table test_db.member();
use test_db;

create table test_db.member(
	id varchar(10) primary key,
    password varchar(10) not null,
    name varchar(50) not null,
    point int default 1000,
    email varchar(100) not null unique,
    age int check(age > 20),
    join_date timestamp not null default current_timestamp
    
);

show tables;

desc tables;

drop table if exists member;

insert into test_db.member values('id-100', '1111', '이순신', 5000, 'lee@a.com', 30, '2023-12-10 11:22:33');

-- point, joim_date : defalut값, age :null
insert into test_db.member(id, password, name, email)
values('id-200', '2222', '유관순', 'rye@a.com');

select * from member;

insert into test_db.member(id, password, name, point, email)
values('id-300', '3333', '강감찬', null, 'kang@a.com');

select * from member;

insert into test_db.member(id, password, name, email, age)
values('id-400', '2222', '유관순', 'rye2@a.com', 5);
