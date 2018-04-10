-- 기본키를 포함한 테이블 생성

create table kopo_product_volume(
regionid varchar2(20),
productgroup varchar2(20),
yearweek varchar2(8),
volume number not null,
constraint pk_kopo_product_volume primary key(regionid,productgroup, yearweek));


-- 테이블에 데이터집어넣기

insert into kopo_product_volume
values ('A01','ST0002','201504',20);

insert into kopo_product_volume
values ('A01','ST0002','201503',20);




create table kopo_event_info_foreign(
 eventid varchar2(20),
 eventperiod varchar2(20),
 PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(eventid));

 
-- 기본키와 외래키를 포함한 테이블 생성 

 create TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
 REGIONID VARCHAR2(20),
 PRODUCTGROUP VARCHAR2(20),
 YEARWEEK VARCHAR2(8),
 VOLUME NUMBER NOT NULL,
 EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references kopo_event_info_foreign(eventid) 
 -- 자식테이블에 이벤트 정보가 있는데 부모테이블에서 지우려고 시도할때,
 -- 자식테이블에 있는 컬럼까지 지울 때,
on delete cascade);


--------------------------------------------------------------------------
-- 자식테이블에 이벤트 정보가 있는데 부모테이블에서 지우려고 시도할때,
-- 자식테이블에 있는 컬럼까지 지울 때,
--ON DELETE CASCADE

---------------------------------------------------------------------------
-- 자식테이블에 이벤트 정보가 있는데 부모테이블에서 지우려고 시도할때,
-- 자식테이블에 있는 컬럼에는 NULL값으로 남길 때,
--ON DELETE SET NULL


SELECT * FROM tabs;

--테이블의 기본키나 다른 정보를 확인하고 싶을 때,
desc KOPO_PRODUCT_VOLUME_FOREIGN;



--자식테이블을 연결할 때,

alter table kopo_product_volume_foreign 
    enable constraint fk_kopo_product_volume_foreign;



-- 테이블에 데이터 갯수확인

select count(*) from KOPO_PRODUCT_VOLUME_FOREIGN;

select count(*) from kopo_event_info_foreign;

desc KOPO_PRODUCT_VOLUME_FOREIGN;