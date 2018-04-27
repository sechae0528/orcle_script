-- 1. flight 테이블 생성
create table `flight` (
	`no` int,
	`flightName` varchar(50),
	`aircraftCode` varchar(50),
	`departure` varchar(50),
	`destination` varchar(50),
	`departTime` DATETIME,
	`arrivalTime` DATETIME
);

-- 2. aircraft 테이블 생성
create table `aircraft` (
	`no` int,
	`aircraftName` varchar(50),
	`aircraftCode` varchar(50),
	`seats` int
);

-- 3. flight 데이터 insert 쿼리
insert into `flight` (`no`, `flightName`, `aircraftCode`, `departure`, `destination`, `departTime`, `arrivalTime`)
values
(1, "OZ800", "A1","SEOUL","JEJU",'2018-04-24 14:25:00', '2018-04-24 15:30:00'),
(2, "YE750", "B3","PUSAN","SEOUL", '2018-04-24 11:00:00', '2018-04-24 12:00:00'),
(3, "DE323", "B2","SEOUL","GWANGJU", '2018-04-24 11:30:00', '2018-04-24 13:00:00'),
(4, "ZE472", "A1","SEOUL","YEOSU", '2018-04-24 09:50:00', '2018-04-24 11:00:00'),
(5, "SB385", "B2","GWANGJU","SACHEON", '2018-04-24 12:20:00', '2018-04-24 14:00:00'),
(6, "DB218", "B3","YEOSU","PUSAN", '2018-04-24 15:15:00', '2018-04-24 16:30:00'),
(7, "ZQ448", "A2","DAEGU","JEJU", '2018-04-24 09:30:00', '2018-04-24 11:00:00'),
(8, "PQ124", "A2","SEOUL","DAEGU", '2018-04-24 17:20:00', '2018-04-24 18:50:00'),
(9, "GJ141", "B1","JEJU","IKSAN", '2018-04-24 19:00:00', '2018-04-24 20:00:00'),
(10, "LG124", "B2","SEOUL","DAEGU", '2018-04-24 21:00:00', '2018-04-24 22:20:00');

-- 4.  aircraft 데이터 insert 쿼리
insert into `aircraft` (`no`, `aircraftName`, `aircraftCode`, `seats`)
values
(1, "A380", "A1",600),
(2, "A312", "A2",500),
(3, "B787", "B1",450),
(4, "B747", "B2",550),
(5, "B800", "B3",800);

-- 5. 출발지가 seoul인 flight select 쿼리
select * from flight where departure = 'seoul';

-- 6. seats가 600 이상인 aircraft select 쿼리
select * from aircraft where seats >= 600;

-- 7. seats가 550 이상인 flight select 쿼리 (서브쿼리 사용)
select * from flight where aircraftCode in (select aircraftCode from aircraft where seats >= 550);

-- 8. 여행시간이 가장 긴 flight select 쿼리 (서브쿼리, max, length, arrivalTime - departTime 사용)

select * from flight where (arrivalTime - departTime) = (select max(arrivalTime-departTime) from flight);

-- 밑에 쿼리가 더 정확함
select * from flight
where ((day(arrivalTime)*24*60 + hour(arrivalTime)*60 + minute(arrivalTime))
		-(day(arrivalTime)*24*60 + hour(departTime)*60  + minute(departTime)))
		=(select max((day(arrivalTime)*24*60 + hour(arrivalTime)*60 + minute(arrivalTime))
		-(day(departTime)*24*60 + hour(departTime)*60  + minute(departTime))) from flight);


select * from flight where TIMESTAMPDIFF(minute, departTime, arrivalTime) 
= (select MAX(TIMESTAMPDIFF(minute, departTime, arrivalTime)) from flight);




select max((hour(arrivalTime)*60 + minute(arrivalTime))-(hour(departTime)*60 + minute(departTime))) from flight

select ((day(arrivalTime)*24*60 + hour(arrivalTime)*60 + minute(arrivalTime))
		-(day(arrivalTime)*24*60 + hour(departTime)*60  + minute(departTime))) from flight




