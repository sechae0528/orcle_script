-- 1. putty���� tnsnames.ora ��θ� ã�� ��,
-- find / -name 'tnsnames.ora'

-- DB���� ���̺����Ȯ�ι��
-- Database -> report -> ER Diagram -> + add object �ϰ� ���̺� �ϳ��� Ŭ���ص� ���� ����

-- ���̺� �����̽� ����
CREATE TABLESPACE       TS_ANSWER01
   DATAFILE '/home/oracle/kopo_tablespaces/answer/tb_answer01.dbf' SIZE 512M
   AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
   SEGMENT SPACE MANAGEMENT AUTO;
   
-- ���̺� �����̽� ����
--DROP TABLESPACE       TS_USER01
--   INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
---------------------------------
-- 2. �����
---------------------------------   
-- ����� ����
CREATE USER answer
                  IDENTIFIED BY        answer
                  DEFAULT TABLESPACE   TS_ANSWER01
                  TEMPORARY TABLESPACE TEMP;

-- ����� ����
--ALTER USER HAITEAM
--   IDENTIFIED BY HAITEAM2;
   -- ACCOUNT LOCK/UNLOCK

---------------------------------
-- 3. ����� ����
---------------------------------  
-- ����� ���� ���� (����/���ҽ� �� ���̺� ����)
GRANT CONNECT, RESOURCE, DBA TO ANSWER;

-- �α��� ���� ����
CREATE TABLE KOPO_ST_ACCOUNT(
ACCOUNT_ID VARCHAR2(100),
ACCOUNT_NAME VARCHAR2(100),
ACCOUNT_TEL VARCHAR2(100),
CONSTRAINTS PK_KOPO_ST_ACCOUNT PRIMARY KEY(ACCOUNT_ID)
);

------------------------------------------------------------
-- �α��� ���� ����
CREATE TABLE KOPO_ST_ACCOUNT(
ACCOUNT_ID VARCHAR2(100),
ACCOUNT_NAME VARCHAR2(100),
ACCOUNT_TEL VARCHAR2(100),
CONSTRAINTS PK_KOPO_ST_ACCOUNT PRIMARY KEY(ACCOUNT_ID)
);

-- �ڽ����̺� ����
 CREATE TABLE KOPO_ST_PRODUCT(
    PRODUCT VARCHAR2(100),
    PRODUCT_NAME VARCHAR2(100),
    PRODUCT_PRICE NUMBER,
    ACCOUNT VARCHAR2(100),
     constraint PK_KOPO_ST_PRODUCT primary key(PRODUCT),
     constraint FK_KOPO_ST_PRODUCT foreign key(ACCOUNT) references KOPO_ST_ACCOUNT(ACCOUNT_ID) );
     
-- �ڽ����̺� ����
 CREATE TABLE KOPO_ST_ORDER(
    ORDER_ID VARCHAR2(100),
    ORDER_DATE DATE,
    PRODUCT_INFO VARCHAR2(100),
     constraint PK_KOPO_ST_ORDER primary key(ORDER_ID),
     constraint FK_KOPO_ST_ORDER foreign key(PRODUCT_INFO) references KOPO_ST_PRODUCT(PRODUCT) );
     
     
 EDIT KOPO_ST_ACCOUNT