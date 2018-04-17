-- 데이터베이스 링크생성
-- 내 데이터베이스에서 다른 서버의 데이터베이스 연결해서 접근하는 방법
-- 원격지의 oracle db에 접근하기 위한 설정

-- 1번. tnsname 활용
CREATE DATABASE LINK 정하고 싶은 이름
CONNECT TO kopo
IDENTIFIED BY kopo
Using 'POLY_SERVER';


-- 2번. 직접 호출방식 활용
CREATE DATABASE LINK server111
CONNECT TO kopo
IDENTIFIED BY kopo
Using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.110.111)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
  

-- 다른서버에서 데이터가져오는 방법 @정한이름  
select * from kopo_product_volume@server111;

select * from tabs@server111;


-- 생성된 데이터베이스 링크 확인방법
SELECT * FROM ALL_DB_LINKS;

-- 데이터베이스 링크 삭제방법
DROP DATABASE LINK ASUS_LINK;


