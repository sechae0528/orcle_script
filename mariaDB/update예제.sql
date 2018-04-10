
---- update 예제 ------------------------------------------------------------------

-- update 테이블명 set 컬럼 = 변경값 where 조건

-- 1. member테이블에서 김태희 이름을 김태리로 이름 변경
update member set name = '김태리' where name = '김태희';

-- 2. member 테이블에서 조인성 email을 insung@naver.com으로 변경
update member set email = 'insung@naver.com' where name = '조인성';

-- 3. member 테이블에서 손예진, 최민식 authcode를 2로 변경
update member set authcode = 2 where name = '손예진' or name = '최민식';

-- 4. board 테이블에서 5번 글의 내용을 hello mariadb 로 변경
update board set content = 'hello mariadb' where no = 5;

-- 5. auth 테이블에서 authority 컬럼값의 예비회원을 승인대기로 변경
update auth set authority = '승인대기' where authority = '예비회원';
