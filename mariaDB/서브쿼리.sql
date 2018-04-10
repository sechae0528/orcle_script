
---------  <서브쿼리이용하기> ------------------------------------------------

-- 연봉의 최댓값을 먼저 찾은다음 그 사람의 포지션을 찾을 때,
select position from basicsalary
	where salary = (select max(salary) from basicsalary);

-- select * from member2 where position ='사원' or position = '과장'
select * from member2
	where position in ('사원', '과장');


-- 연봉이 7000이상인 사람들의 정보를 다 가져오기	
select * from member2 where position  in 
(select position from basicsalary where salary >= 7000);



-- 서브쿼리 예제

select * from basicsalary
	where salary = (select max(salary) from basicsalary);
	
select max(salary) from basicsalary;

-- 1. 회원 중 비밀번호가 가장 긴 회원의 목록
select * from member
	where length(pass) = (select max(length(pass)) from member);
	
-- 2. 회원 중 권한이 '회원'인 목록
select * from member
	where authcode = (select authcode from auth where authority = '회원');
	
-- 3. 글을 쓴적이 있는 회원이 아이디 목록
select * from member
	where id in (select id from board);
	
	
	
	