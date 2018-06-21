---------------------------------------------------------------------------
-- 1학기 기말고사 --
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- 1번 [기본조회]kopo channel_seasonality_final 테이블에서 다음 조건을
--      만족하는 테이블을 생성하세요
--    (주차 != 53 AND 연도 >= 2015 AND 상품(PRODUCT1 및 PRODUCT2)
-- KOPO_ST_이름_FINAL1 테이블로 생성하세요 (예: KOPO_ST_김효관_FINAL1)
---------------------------------------------------------------------------
CREATE TABLE KOPO_ST_채성은_FINAL1 
AS
SELECT REGIONID,
       PRODUCT,
       YEARWEEK,
       QTY
FROM kopo_channel_seasonality_final
WHERE 1=1
AND SUBSTR(YEARWEEK,5,2) != 53
AND SUBSTR(YEARWEEK,1,4) >= 2015
AND PRODUCT IN ('PRODUCT1','PRODUCT2')
-- 제외 사용시에는 PRODUCT NOT IN
-- AND (PRODUCT = 'PRODUCT1' OR PRODUCT = 'PRODUCT2');
ORDER BY REGIONID ASC, PRODUCT ASC, YEARWEEK ASC;

---------------------------------------------------------------------------
-- 2번 [GROUP-BY]
--   1번 결과 테이블에서 지역/상품별 평균판매량을 소수점 없이
--   반올림하여 AVG_QTY 값을 산출한 후 KOPO_ST_이름_FINAL2 테이블로 생성하세요
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL2  
AS
SELECT REGIONID,
       PRODUCT,
      ROUND(AVG(QTY),0) AS AVG_QTY
FROM KOPO_ST_채성은_FINAL1
GROUP BY REGIONID, PRODUCT;

---------------------------------------------------------------------------
-- 3번 [JOIN] 1번결과 테이블을 기준으로 2번결과 테이블을 LEFT 조인하여
--      [REGIONID, PRODUCT, YEARWEEK, QTY, AVG_QTY] 컬럼을 조회하여
--      테이블을 생성하세요. (조인키는 REGIONID, PRODUCT)
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL3  
AS
SELECT A.REGIONID
        ,A.PRODUCT
        ,A.YEARWEEK
        ,A.QTY
        ,B.AVG_QTY
FROM KOPO_ST_채성은_FINAL1 A
LEFT JOIN KOPO_ST_채성은_FINAL2 B
ON 1=1
AND A.REGIONID = B.REGIONID
AND A.PRODUCT = B.PRODUCT;


---------------------------------------------------------------------------
-- 4번 [단일행 함수]3번결과 테이블에서 QTY/AVG_QTY를 계산하여 RATIO
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL4  
AS
SELECT REGIONID
       ,PRODUCT
       ,YEARWEEK
       ,QTY
       ,AVG_QTY
      -- ,ROUND((QTY/AVG_QTY),2) AS RATIO
       ,CASE WHEN AVG_QTY = 0
                THEN 1
            ELSE ROUND((QTY/AVG_QTY),2) END AS RATIO
FROM KOPO_ST_채성은_FINAL3;


---------------------------------------------------------------------------
-- 5번
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL5  
AS
SELECT REGIONID
       ,PRODUCT
       ,WEEK       
       ,ROUND(AVG(RATIO),2) AS RATIO
    FROM ( SELECT REGIONID
            ,PRODUCT
            ,YEARWEEK
            ,SUBSTR(YEARWEEK,5,6) AS WEEK
            ,QTY
            ,AVG_QTY
            ,RATIO
            FROM KOPO_ST_채성은_FINAL4
          )
GROUP BY REGIONID,PRODUCT ,WEEK;

-- 답안
SELECT A.REGIONID
       ,A.PRODUCT
       ,SUBSTR(A.YEARWEEK,-2) AS WEEK       
       ,ROUND(AVG(RATIO),2) AS RATIO
    FROM KOPO_ST_채성은_FINAL4 A
GROUP BY REGIONID,PRODUCT ,SUBSTR(A.YEARWEEK,-2);

---------------------------------------------------------------------------
-- 6번
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL6  
AS  
SELECT 
    *
     FROM KOPO_ST_채성은_FINAL5
PIVOT( 
    SUM(RATIO)
    FOR WEEK IN ('01' AS W01,'02' AS W02,'03' AS W03,'04' AS W04,'05' AS W05
    ,'06' AS W06,'07' AS W07,'08' AS W08,'09' AS W09,'10' AS W10
    )
);