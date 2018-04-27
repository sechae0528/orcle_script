create
alter
drop


insert into news (`no`, `title`,`desc`,`category`)
values(10,'제목','내용.....', '시사')

select `no`, `title`, `desc`, `category` from news
	where no = 2 or title = '%출시%'
	
	
update news set title = '갤럭시10출시' where no = 3

delete from news where no = 10


delete from member where name = '이만수' or name = '차범근' or name = '김영희'

create table `member` (
	`no` int,
	`id` varchar(20),
	`name` varchar(30),
	`pass` varchar(20),
	`email` varchar(30),
	`authcode` int,
	`regDate` timestamp,
	`lastConnectTime` timestamp
);



create table `board` (
	`no` int,
	`id` varchar(20),
	`title` varchar(50),
	`content` longtext,
	`regDate` timestamp,
	`lastUpdate` timestamp
);


create table `auth` (
	`authcode` int,
	`authority` varchar(20)
);






-- 테이블 이름 재설정할 때,

rename table `member` to `member2`






select `desc` 내용 from news

select * from news as a where a.`no` =1

select now()
select sum(salary) `연봉총합` from basicsalary
select avg(salary) `연봉평균` from basicsalary
select concat(name,':',position) as '이름직급' from member2
select * from member2 limit 3
select left(name, 1) from member2
select right(name, 2) from member2
select left(name, 1) as '성', right(name, 2) as '이름' from member2
select substring(문자열, 몇번째부터, 몇개) from table
select substring(name, 2, 1) from member2





insert into `member` (`no`, `id`, `name`, `pass`, `email`, `authcode`, `regDate`, `lastConnectTime`)
values
(1, "abc111", "김태희","qwetyytu123","abc111@naver.com", 0, now(), now()),
(2, "helloworld", "김코딩","**12341234","helloworld@gmail.com", 1, now(), now()),
(3, "gildong", "홍길동","98769876aaa","gildong@daum.net", 1, now(), now()),
(4, "chaboom", "차범근","asdfdg123","chaboom@nate.com", 2, now(), now()),
(5, "polytech", "한가인","rkdls111","polytech@polytech.ac.kr", 2, now(), now()),
(6, "smart", "정우성","00dntjd00","smart@seoul.kr", 2, now(), now()),
(7, "hwang1234", "조인성","dlstjd2018","hwang1234@naver.com", 2, now(), now()),
(8, "qwertrhy", "손예진","dPwls888","qwertrhy@hanmail.net", 3, now(), now()),
(9, "korea0808", "최민식","1234qwertd","korea0808@yahoo.co.kr", 3, now(), now()),
(10, "goodid", "송강호","aa12345678","goodid@gmail.com", 3, now(), now())





insert into `board`
values
(1, "abc111", "공지사항", "공지사항입니다.",now(), now()),
(2, "helloworld", "안녕하세요", "잘부탁드립니다.",now(), now()),
(3, "chaboom", "test", "게시판 test",now(), now()),
(4, "smart", "가입인사", "가입인사드립니다.",now(), now()),
(5, "hwang1234", "hello world", "hello mysql",now(), now()),
(6, "korea0808", "ㅎㅎㅎ", "ㅋㅋㅋㅋㅋ",now(), now())


insert into `auth`
values
(0, "관리자"),
(1, "운영자"),
(2, "회원"),
(3, "예비회원")




-- 1. member 테이블에서 회원번호가 5미만인 회원 선택

select * from member where no < 5


-- 2. member 테이블에서 authcode가 3인 회원 선택

select * from member where authcode = 3

-- 3. member테이블에서 회원번호가 7이하이면서 authcode가 1인 회원 선택

select * from member where no <= 7 and authcode = 1

-- 4. board테이블에서 작성자 id가 chaboom인 글 선택

select * from board where id = "chaboom"
select title, content from board where id = "chaboom"

-- 5. board테이블에서 번호가 3이하인 글 선택

select * from board where no <= 3

-- 6. auth테이블에서 권한이 회원인 테이터 선택

select * from auth where authority = "회원"