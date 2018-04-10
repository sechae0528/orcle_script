
--------------- 테이블생성------------------------------------------------------

create table `news` (
	`no` int,
	`title` varchar(50),
	`desc` longtext
);


create table `member`(
		`no` int,
		`name` varchar(20),
		`position` varchar(30),
		`year` int
);

create table `basicsalary`(
		`position` varchar(20),
		`salary` int

);



-------------- 테이블안의 컬럼명 변경-------------------------------------------

alter table `news` change column `title` `title2` varchar(100);

alter table `member` change column `name` `name` varchar(40);

alter table `basicsalary` change column `position` `position` varchar(30);




-------------- 테이블안의 데이터 삽입-------------------------------------------

insert into `news` (`no`, `title`, `desc`)
values
(1, "아이폰 X 출시", "아이폰 X가 새롭게 출시되었습니다."),
(2, "갤럭시 S9출시", "갤럭시 S9가 새롭게 출시되었습니다."),
(3, "휘감아지는 고감도 투명센서", "휘감아지는 고감도 투명 터치센서가 출시되었습니다.")


insert into `member` (`no`, `name`, `position`, `year`)
values
(1001, "이철수", "사원", 2),
(1002, "홍길동", "과장", 7),
(1003, "김영희", "대리", 5),
(1004, "손흥민", "차장", 10),
(1005, "박지성", "사원", 1),
(1006, "이천수", "대리", 4),
(1007, "안정환", "사장", 15),
(1008, "박항서", "부장", 13),
(1009, "지소연", "과장", 8),
(1010, "차범근", "사원", 2);



insert into `basicsalary` (`position`, `salary`)
values
("사장", 12000),
("부장", 9000),
("차장", 8000),
("과장", 7000),
("대리", 5500),
("사원", 4500);
