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




-------------------------------------------------------------------------
-------------------------------------------------------------------------       
-- 데이터 조회 (집계함수편) --
-------------------------------------------------------------------------
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
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- GROUP BY
-------------------------------------------------------------------------
-- SELECT 
--    집계대상 컬럼1,
--    집계대상 컬럼2,…
--    AVG(*) ? 집계함수
--FROM KOPO_CHANNEL_SEASONALITY_NEW
--WHERE 조건절
--GROUP BY 집계대상 컬럼1, 집계대상 컬럼2
--HAVING 조건절 (집계)
-------------------------------------------------------------------------
SELECT * FROM KOPO_CHANNEL_SEASONALITY_NEW;

SELECT 
    REGIONID,
    PRODUCT,
    AVG(QTY)
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT
ORDER BY REGIONID, PRODUCT;

-------------------------------------------------------------------------
-- GROUP BY (조건)
-------------------------------------------------------------------------
-- SELECT 
--    집계대상 컬럼1,
--    집계대상 컬럼2,…
--    AVG(컬럼명)
--FROM KOPO_CHANNEL_SEASONALITY_NEW
--GROUP BY 집계대상 컬럼1, 집계대상 컬럼2
--HAVING AVG(컬럼명) > 임의의 값
-------------------------------------------------------------------------
SELECT 
    REGIONID,
    PRODUCT,
    AVG(QTY)
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT
HAVING AVG(QTY) > 10000
ORDER BY REGIONID, PRODUCT;

-------------------------------------------------------------------------
-- 예제 : RMSE_MAE_EXAMPLE 테이블을 활용하여 ITEM별 RMSE를 구하세요
-- 오차 : 실측값 - 예측값
-- MAE : (실측값 - 예측값) / 갯수
-- RMSE : (오차의 제곱/갯수)의 루트
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- RMSE 구하기!!!
-------------------------------------------------------------------------
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
    
-------------------------------------------------------------------------
-- 위의 문제를 과정을 모두 풀어서 한 테이블로 보여주도록 하려면
-------------------------------------------------------------------------
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
    
    

