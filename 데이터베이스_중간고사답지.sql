-- 1. putty에서 tnsnames.ora 경로를 찾을 때,
-- find / -name 'tnsnames.ora'

-- DB에서 테이블관계확인방법
-- Database -> report -> ER Diagram -> + add object 하고 테이블 하나만 클릭해도 볼수 있음

-- 테이블 스페이스 생성
CREATE TABLESPACE       TS_ANSWER01
   DATAFILE '/home/oracle/kopo_tablespaces/answer/tb_answer01.dbf' SIZE 512M
   AUTOEXTEND ON NEXT 100M MAXSIZE UNLIMITED
   SEGMENT SPACE MANAGEMENT AUTO;
   
-- 테이블 스페이스 삭제
--DROP TABLESPACE       TS_USER01
--   INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
---------------------------------
-- 2. 사용자
---------------------------------   
-- 사용자 생성
CREATE USER answer
                  IDENTIFIED BY        answer
                  DEFAULT TABLESPACE   TS_ANSWER01
                  TEMPORARY TABLESPACE TEMP;

-- 사용자 변경
--ALTER USER HAITEAM
--   IDENTIFIED BY HAITEAM2;
   -- ACCOUNT LOCK/UNLOCK

---------------------------------
-- 3. 사용자 권한
---------------------------------  
-- 사용자 권한 생성 (접속/리소스 및 테이블 생성)
GRANT CONNECT, RESOURCE, DBA TO ANSWER;

-- 로그인 계정 변경
CREATE TABLE KOPO_ST_ACCOUNT(
ACCOUNT_ID VARCHAR2(100),
ACCOUNT_NAME VARCHAR2(100),
ACCOUNT_TEL VARCHAR2(100),
CONSTRAINTS PK_KOPO_ST_ACCOUNT PRIMARY KEY(ACCOUNT_ID)
);

------------------------------------------------------------
-- 로그인 계정 변경
CREATE TABLE KOPO_ST_ACCOUNT(
ACCOUNT_ID VARCHAR2(100),
ACCOUNT_NAME VARCHAR2(100),
ACCOUNT_TEL VARCHAR2(100),
CONSTRAINTS PK_KOPO_ST_ACCOUNT PRIMARY KEY(ACCOUNT_ID)
);

-- 자식테이블 생성
 CREATE TABLE KOPO_ST_PRODUCT(
    PRODUCT VARCHAR2(100),
    PRODUCT_NAME VARCHAR2(100),
    PRODUCT_PRICE NUMBER,
    ACCOUNT VARCHAR2(100),
     constraint PK_KOPO_ST_PRODUCT primary key(PRODUCT),
     constraint FK_KOPO_ST_PRODUCT foreign key(ACCOUNT) references KOPO_ST_ACCOUNT(ACCOUNT_ID) );
     
-- 자식테이블 생성
 CREATE TABLE KOPO_ST_ORDER(
    ORDER_ID VARCHAR2(100),
    ORDER_DATE DATE,
    PRODUCT_INFO VARCHAR2(100),
     constraint PK_KOPO_ST_ORDER primary key(ORDER_ID),
     constraint FK_KOPO_ST_ORDER foreign key(PRODUCT_INFO) references KOPO_ST_PRODUCT(PRODUCT) );
     
     
 EDIT KOPO_ST_ACCOUNT