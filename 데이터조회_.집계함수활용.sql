-- 그룹함수(집계함수)
-- 1. 전체 테이블을 대상
select avg(qty)
from kopo_channel_seasonality_new;

--2. 전체 테이블을 소그룹화 (groub by절 반드시 필요)
select regionid, avg(qty)
from kopo_channel_seasonality_new
group by regionid
order by regionid;


select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product;

-- having 조건절

select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product
having avg(qty)>2000;

select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product
having avg(qty)>2000
and regionid like 'A%';

select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product
having avg(qty)>2000
and regionid like '_01%';

-- RMSE를 item별 그룹화하여 구하기
select A.item,
    sqrt(avg(power(abs(QTY-PREDICTION),2))) RMSE
from RMSE_MAE_EXAMPlE A
group by A.item
order by A.item;

-- 위의 문제를 과정을 모두 풀어서 한 테이블로 보여주도록 하려면
-- ITME별 집계 함수 구현
SELECT ITEM,
    AVG(ERROR_POW),
    SQRT(AVG(ERROR_POW))
FROM     
(
    -- ERROR를 구한다
    SELECT ITEM,
        YEARWEEK,
        QTY,
        PREDICTION,
        ABS(QTY-PREDICTION) AS ERROR,
        POWER(ABS(QTY-PREDICTION),2) AS ERROR_POW
    FROM RMSE_MAE_EXAMPLE
)    
GROUP BY ITEM
ORDER BY ITEM;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------       
-- 데이터 조회 (집계함수편) --
-------------------------------------------------------------------------------
-- 주요함수
-- COUNT : 주어진 자료 집계 단위의 건수를 출력함
--              
-- SUM : 주어진 자료 집계 단위의 합계를 출력함
--               
-- AVG : 주어진 자료 집계 단위의 평균을 출력함
--               
-- MIN/MAX : 주어진 자료 집계 단위의 최대/최소값을출력함
--               예 >  FLOOR(12.345) -> 12
-- PIVOT
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- GROUP BY
-------------------------------------------------------------------------------
-- SELECT 
--    집계대상 컬럼1,
--    집계대상 컬럼2,…
--    AVG(*) ? 집계함수
--FROM KOPO_CHANNEL_SEASONALITY_NEW
--WHERE 조건절
--GROUP BY 집계대상 컬럼1, 집계대상 컬럼2
--HAVING 조건절 (집계)
-------------------------------------------------------------------------------
SELECT * FROM KOPO_CHANNEL_SEASONALITY_NEW;

SELECT 
    REGIONID,
    PRODUCT,
    AVG(QTY)
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT
ORDER BY REGIONID, PRODUCT;

-------------------------------------------------------------------------------
-- GROUP BY (조건)
-------------------------------------------------------------------------------
-- SELECT 
--    집계대상 컬럼1,
--    집계대상 컬럼2,…
--    AVG(컬럼명)
--FROM KOPO_CHANNEL_SEASONALITY_NEW
--GROUP BY 집계대상 컬럼1, 집계대상 컬럼2
--HAVING AVG(컬럼명) > 임의의 값
-------------------------------------------------------------------------------
SELECT 
    REGIONID,
    PRODUCT,
    AVG(QTY)
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT
HAVING AVG(QTY) > 10000
ORDER BY REGIONID, PRODUCT;

-------------------------------------------------------------------------------
-- 예제 : RMSE_MAE_EXAMPLE 테이블을 활용하여 ITEM별 RMSE를 구하세요
-- 오차 : 실측값 - 예측값
-- MAE : (실측값 - 예측값) / 갯수
-- RMSE : (오차의 제곱/갯수)의 루트
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- RMSE 구하기!!!
-------------------------------------------------------------------------------
SELECT * FROM RMSE_MAE_EXAMPLE;

-- 답
-- 1. 실측 - 예측
-- 2. (실측 - 예측)을 2제곱
-- 3. '2' + AVG(전체 합의 평균)
--4. '3' + 루트 씌우면 RMSE 오차 나온다.

SELECT 
    ITEM,
    SQRT(AVG(POWER(QTY-PREDICTION,2)) ) AS RMSE
FROM RMSE_MAE_EXAMPLE
GROUP BY ITEM;    
    
-------------------------------------------------------------------------------
-- 위의 문제를 과정을 모두 풀어서 한 테이블로 보여주도록 하려면
-------------------------------------------------------------------------------
SELECT 
    ITEM,
    AVG(ERROR) AS MAE,
    AVG(ERROR_POW),
    SQRT(AVG(ERROR_POW)) AS RMSE
    FROM
    (
        -- ERROR를 구한다
        SELECT
            ITEM,
            YEARWEEK,
            QTY,
            PREDICTION,
            ABS(QTY-PREDICTION) AS ERROR,
            POWER(ABS(QTY-PREDICTION), 2) AS ERROR_POW
           FROM RMSE_MAE_EXAMPLE
    )
GROUP BY ITEM
ORDER BY ITEM;

-------------------------------------------------------------------------------
-- GROUP BY 사용시 COUNT 사용방법  
-------------------------------------------------------------------------------  
SELECT
    REGIONID,
    PRODUCT,
    COUNT(*)
FROM KOPO_CHANNEL_SEASONALITY
GROUP BY REGIONID, PRODUCT
HAVING COUNT(*) != 314;
    
-------------------------------------------------------------------------------
-- JOIN
-------------------------------------------------------------------------------
-- INNER JOIN : 테이블의 키를 정의하고 키가 서로 존재하는 경우의 자료만 조회할때
-- LEFT JOIN : 기존데이터를 무조건 다 살려야되!!
-- RIGHT JOIN : B테이블의 데이터를 모두 살려야되
-------------------------------------------------------------------------------    

--조인 실습 -------------------------------------------------------------------
SELECT * FROM CUSTOMERDATA;

SELECT * FROM CUSTOMER_NAME;

--LEFT JOIN -------------------------------------------------------------------
SELECT COUNT(*)
FROM ( 
SELECT A.CUSTID
        , A.AVERAGEPRICE
        , A.EMI, A.DEVICECOUNT
        , A.PRODUCTAGE
        , A.CUSTTYPE
        , B.CUSTNAME
    FROM CUSTOMERDATA A 
    LEFT JOIN CUSTOMER_NAME B
    ON A.CUSTID = B.CUSTID
    );
    
-- CUSTNAME에 비어있는 데이터를 보려면    
SELECT A.CUSTID
        , A.AVERAGEPRICE
        , A.EMI
        , A.DEVICECOUNT
        , A.PRODUCTAGE
        , A.CUSTTYPE
        , B.CUSTNAME
    FROM CUSTOMERDATA A 
    LEFT JOIN CUSTOMER_NAME B
    ON A.CUSTID = B.CUSTID
    WHERE  1=1
    AND CUSTNAME IS NULL;
 
--INNER JOIN ------------------------------------------------------------------
-- 좀 더 빠르게 실행하려면 왼쪽, 실행하는 마스터쪽에 작은 데이터를 집어넣는다.
SELECT COUNT(*)
FROM (  
SELECT A.CUSTID
        , A.AVERAGEPRICE
        , A.EMI
        , A.DEVICECOUNT
        , A.PRODUCTAGE
        , A.CUSTTYPE
        , B.CUSTNAME
    FROM CUSTOMERDATA A 
    INNER JOIN CUSTOMER_NAME B
    ON A.CUSTID = B.CUSTID
    );
    
SELECT COUNT(*)
FROM (  
SELECT A.CUSTID
        , B.AVERAGEPRICE
        , B.EMI
        , B.DEVICECOUNT
        , B.PRODUCTAGE
        , B.CUSTTYPE
        , A.CUSTNAME
    FROM CUSTOMER_NAME A 
    INNER JOIN CUSTOMERDATA B
    ON A.CUSTID = B.CUSTID
    );

--RIGHT JOIN ------------------------------------------------------------------
SELECT COUNT(*)
FROM ( 
SELECT A.CUSTID
        , A.AVERAGEPRICE
        , A.EMI
        , A.DEVICECOUNT
        , A.PRODUCTAGE
        , A.CUSTTYPE
        , B.CUSTNAME
    FROM CUSTOMERDATA A 
    RIGHT JOIN CUSTOMER_NAME B
    ON A.CUSTID = B.CUSTID
    );
    
-------------------------------------------------------------------------------
-- PIVOT (행을 열로 변환)
-------------------------------------------------------------------------------
-- SELECT * 
-- FROM(
-- SELECT * FROM {대상테이블명}
--) PIVOT(
--   SUM(SALES)
--   FOR {행을 열로 바꿀 컬럼명} IN (열로 표현할 값 리스트)
--)
-------------------------------------------------------------------------------
SELECT 
    *
     FROM (
        SELECT  *
        FROM DT_RESULT_FINAL2
)
PIVOT( 
    SUM(SALES)
    FOR MEASURE IN ('REAL-QTY' AS REAL_QTY,'PREDICTION-QTY' AS PREDICTION_QTY)
)
