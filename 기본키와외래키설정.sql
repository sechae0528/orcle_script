-- �⺻Ű�� ������ ���̺� ����

create table kopo_product_volume(
regionid varchar2(20),
productgroup varchar2(20),
yearweek varchar2(8),
volume number not null,
constraint pk_kopo_product_volume primary key(regionid,productgroup, yearweek));


-- ���̺� ����������ֱ�

insert into kopo_product_volume
values ('A01','ST0002','201504',20);

insert into kopo_product_volume
values ('A01','ST0002','201503',20);




create table kopo_event_info_foreign(
 eventid varchar2(20),
 eventperiod varchar2(20),
 PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key(eventid));

 
-- �⺻Ű�� �ܷ�Ű�� ������ ���̺� ���� 

 create TABLE KOPO_PRODUCT_VOLUME_FOREIGN(
 REGIONID VARCHAR2(20),
 PRODUCTGROUP VARCHAR2(20),
 YEARWEEK VARCHAR2(8),
 VOLUME NUMBER NOT NULL,
 EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(eventid) references kopo_event_info_foreign(eventid) 
 -- �ڽ����̺� �̺�Ʈ ������ �ִµ� �θ����̺��� ������� �õ��Ҷ�,
 -- �ڽ����̺� �ִ� �÷����� ���� ��,
on delete cascade);


--------------------------------------------------------------------------
-- �ڽ����̺� �̺�Ʈ ������ �ִµ� �θ����̺��� ������� �õ��Ҷ�,
-- �ڽ����̺� �ִ� �÷����� ���� ��,
--ON DELETE CASCADE

---------------------------------------------------------------------------
-- �ڽ����̺� �̺�Ʈ ������ �ִµ� �θ����̺��� ������� �õ��Ҷ�,
-- �ڽ����̺� �ִ� �÷����� NULL������ ���� ��,
--ON DELETE SET NULL


SELECT * FROM tabs;

--���̺��� �⺻Ű�� �ٸ� ������ Ȯ���ϰ� ���� ��,
desc KOPO_PRODUCT_VOLUME_FOREIGN;



--�ڽ����̺��� ������ ��,

alter table kopo_product_volume_foreign 
    enable constraint fk_kopo_product_volume_foreign;



-- ���̺� ������ ����Ȯ��

select count(*) from KOPO_PRODUCT_VOLUME_FOREIGN;

select count(*) from kopo_event_info_foreign;

desc KOPO_PRODUCT_VOLUME_FOREIGN;