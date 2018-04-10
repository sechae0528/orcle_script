
--- <오름차순, 내림차순 정리> --------------------------------------------------------


-- 오름차순정리(1,2,3,4...)
select * from member order by name;

-- 내림차순정리(10,9,8,7,...)
select * from member order by name desc;

-- authcode, name에 대해서 오름차순 정리
select * from member order by authcode, name;

select count(*) from member where authcode = 3;

select * from basicsalary;

select sum(salary) from basicsalary;
select * from member;

select concat(id,":", name) from member;

select left(name, 2) from member;



-- 7. board 테이블에서 모든 글을 번호 오름차순으로 선택
select * from board order by no;

-- 8. board 테이블에서 모든 글을 번호 내림차순으로 선택
select * from board order by no desc;

-- 9. board 테이블에서 모든 글을 번호 오름차순, 작성일시 내림차순으로 선택
select * from board order by no, regDate desc;

-- 10. board테이블에서 모든 글을 번호 내림차순, 작성일시 오름차순으로 선택
select * from board order by no desc, regDate;

-- 11. member테이블에서 authcode가 2,3인 사람의 수
select count(*) from member where authcode = 2 or authcode = 3;

-- 12. member테이블에서 no가 1이상 7미만인 사람 중 authcode가 2인 사람의 수
select count(*) from member where no>=1 and no<7 and authcode = 2;

-- 13. member테이블에서 성만 가져오기
select left(name, 1) from member;

-- 14. board테이블에서 '제목 : 내용' 을 '본문' 이라는 컬럼명으로 가져오기
select concat(title,":",content) '본문' from board;

-- 15. member 테이블에서 이름만 가져오기
select right(name, 2) from member;
