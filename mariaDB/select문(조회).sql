-------------- 테이블 조회select---------------------------------------------------

select * from news;
select `no`, `title` from news
	where `no` = 1
	   or `no` = 2;
	   

	   
select `no`, `title` from news
	where `no` = 1 and `title` = '아이폰 x 출시';
	  
	  
-- 1.member 테이블에서 모든 데이터 조회

select * from member;

-- 2. basicsalary 테이블에서 모든 데이터 조회

select * from basicsalary;

-- 3. 번호가 1004인 사람을 member 테이블에서 조회

select * from member
	where `no` = 1004;
	  
-- 4. 과장, 차장의 salary를 basicsalary 테이블에서 조회

select `salary`, `position` from basicsalary
	where `position` = '차장'
		or `position` = '과장';
		
-- 5. position이 사원인 인원을 member 테이블에서 조회

select * from member
	where `position` = '사원';
	
-- 6. 연차가 10년 이상인 인원을 member 테이블에서 조회

select * from member
	where `year` >= 10;
	
-- 7. salary가 5000 미만인 직급을 basicsalary 테이블에서 조회

select `position` from basicsalary
	where `salary` < 5000	;
	
-- 8. 연차가 10년 미만이고 직급이 대리인 인원을 member 테이블에서 조회

select * from member
	where `year` <10 and `position` = '대리';	
	

-- (select 일 때는 굳이 ``쓰지 않아도 가능)


-- 현재시간 조회

select now() 



------------- <내림차순, 오름차순 정리> -----------------------------------------

-- 오름차순 정리

select * from member order by no


-- 내림차순 정리 (desc 를 빼면 오름차순)
select * from member order by no desc

-- 여러개로 정리 줄 수 있음. 먼저 연차오름차순, 넘버 오름차순 순으로 정리
select * from member order by year desc, no desc 



----------- count(*) 갯수 조회-----------------------------------------------------


select count(*) '사원수 ' from member
	where position = '사원'


-- 1. member 테이블에서 사원인 인원수
select count(*) '사원수' from member where position = '사원';

-- 2. member 테이블에서 과장인 인원수
select count(*) '과장수' from member where position = '과장';

-- 3. member 테이블에서 연차가 5년 이상인 인원 수
select count(*) '연차5년이상' from member where year >= 5;

-- 4. member 테이블에서 번호가 1005미만인 인원 수
select count(*) from member where no < 1005;

-- 5. basicsalary 테이블에서 직급 전체 수
select count(position) '직급 전체수' from basicsalary;

-- 6. member 테이블에서 직급 전체 수(중복값 없이)
select count(distinct(position)) '직급수' from member;


