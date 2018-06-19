---------------------------------------------------------------------------
-- 1학기 기말고사 --
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- 1번
--(주차 != 53 AND 연도 >= 2015 AND 상품(PRODUCT1 및 PRODUCT2)
---------------------------------------------------------------------------
CREATE TABLE KOPO_ST_채성은_FINAL1 
AS
SELECT REGIONID,
       PRODUCT,
       YEARWEEK,
       QTY
FROM kopo_channel_seasonality_final
WHERE 1=1
AND TO_NUMBER(SUBSTR(YEARWEEK,5,6)) != 53
AND (SUBSTR(YEARWEEK,1,4))>= '2015'
AND (PRODUCT = 'PRODUCT1' OR PRODUCT = 'PRODUCT2');

---------------------------------------------------------------------------
-- 2번
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL2  
AS
SELECT REGIONID,
        PRODUCT,
      ROUND(AVG(QTY),0) AS AVG_QTY
FROM KOPO_ST_김효관_FINAL1
GROUP BY REGIONID, PRODUCT;

---------------------------------------------------------------------------
-- 3번
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
-- 4번
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_채성은_FINAL4  
AS
SELECT REGIONID
       ,PRODUCT
       ,YEARWEEK
       ,QTY
       ,AVG_QTY
       ,ROUND((QTY/AVG_QTY),2) AS RATIO
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