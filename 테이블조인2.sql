
-- 마스터 테이블
select * from kopo_stock_mst;

-- 로그 실적
select * from kopo_stock_log;

-- 테이블조인후 새로운 테이블 만들기
CREATE TABLE KOPO_ST_CSE_JOIN AS
(
SELECT 
       A.SCREEN_CODE,
       A.SCREED_DIV,
       B.OPEN,
       B.HIGH,
       B.LOW
    from KOPO_STOCK_MST A 
    LEFT JOIN KOPO_STOCK_LOG B
    ON A.SCREEN_CODE = B.ST_CODE
    WHERE 1=1
    AND A.SCREED_DIV = 'KOSPI'              
);

SELECT * from KOPO_ST_CSE_JOIN;


-- 전체 테이블에서 테이블명에 JOIN이 들어간 테이블 조회
SELECT * FROM TABS
    WHERE TABLE_NAME LIKE '%JOIN%';
    
    
SELECT 
       A.SCREEN_CODE,
       A.SCREED_DIV AS SCREEN_DEV,
       B.OPEN,
       B.HIGH,
       B.LOW
    from KOPO_STOCK_MST A, 
    KOPO_STOCK_LOG B
    WHERE 1=1
    AND A.SCREEN_CODE = B.ST_CODE (+);
    
SELECT REGIONID,
        PRODUCT,
        COUNT(*)
        FROM KOPO_CHANNEL_SEANSONALITY_NEW
        GROUP BY REGIONID, PRODUCT
        ORDER BY REGIONID, PRODUCT;
        
SELECT * FROM
KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID;


SELECT * from kopo_product_mst;    