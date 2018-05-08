-- 테이블 조인 방법 --

select * from flight a, aircraft b
	where a.aircraftCode = b.aircraftCode;
	
select * from flight a, aircraft b
	where a.aircraftCode = b.aircraftCode
		and b.aircraftCode = 'A1';

select * from flight a, aircraft b
	where a.aircraftCode = b.aircraftCode
		and a.flightName = 'OZ800';
	 
	 
-- ------------------------------예제 -------------------------------	 
-- 1. 관리자인 회원의 id, name만 출력하세요 (0이라는 코드를 쓰면 안됨)
select * from member a, auth b
	where a.authcode = b.authcode
		and b.authority = '관리자';
	 
-- 2. 글제목, 회원이름 두가지만 출력하세요.
select b.title, a.name  from member a, board b
	where a.id = b.id;


-- 3. 권한이 '회원'인 회원이름, 회원id, 글제목, 글내용, 권한만 출력하세요(2라는 코드를 쓰면 안됨)
select a.name, a.id, c.title, c.content, b.authority from member a, auth b, board c
		where a.authcode = b.authcode
	 		and a.id = c.id
	 		and b.authority = '회원';