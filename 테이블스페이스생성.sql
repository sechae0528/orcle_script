-- 테이블 스페이스 생성

create tablespace TS_Chae01
    datafile 'E:\oracle1\data\TS_chae_01.dbf' size 1024M
    autoextend on next 100M maxsize unlimited
    segment space management auto;

-- 테이블사용할 유저 생성

CREATE USER sechae
                  IDENTIFIED BY        sechae
                  DEFAULT TABLESPACE   TS_Chae01
                  TEMPORARY TABLESPACE TEMP;



select * from dba_tablespaces;


--유저에게 권한 주기

GRANT CONNECT, RESOURCE, DBA TO sechae;
