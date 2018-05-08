-- 테이블 조인 방법 --

select * from flight a, aircraft b
	where a.aircraftCode = b.aircraftCode;
	
select * from flight a, aircraft b
	where a.aircraftCode = b.aircraftCode
		and b.aircraftCode = 'A1';

select * from flight a, aircraft b
	where a.aircraftCode = b.aircraftCode
		and a.flightName = 'OZ800';
	 
	 
-- ------------------------------예제 ----------------------------------------------------------	 
-- 1. 관리자인 회원의 id, name만 출력하세요 (0이라는 코드를 쓰면 안됨)
select * from member a, auth b
	where a.authcode = b.authcode
		and b.authority = '관리자';
	 
-- 2. 글제목, 회원이름 두가지만 출력하세요.
select b.title, a.name  from member a, board b
	where a.id = b.id;


-- 테이블 3개 조인할 때,
-- 3. 권한이 '회원'인 회원이름, 회원id, 글제목, 글내용, 권한만 출력하세요(2라는 코드를 쓰면 안됨)
select a.name, a.id, c.title, c.content, b.authority from member a, auth b, board c
		where a.authcode = b.authcode
	 		and a.id = c.id
	 		and b.authority = '회원';
	 		
	 		
-- ---------------------------------------------------------------------------------------------	 		
-- left join 문법
-- ------------------------------예제 -----------------------------------------------------------	 
select * from flight a
left join aircraft b
	on a.aircraftCode = b.aircraftCode;
	

-- 1. 회원이름, 권한 출력 (회원전체)
select a.name, b.authority from member a
left join auth b
	on a.authcode = b.authcode;
	
-- 2. 제목, 작성자 이름 출력 (글 전체)
select a.title, b.name from board a
left join member b
	on a.id = b.id;
	
-- ----------------------------------------------------------------------------------------------














