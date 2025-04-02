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

