-- 20180605 퀴즈
---------------------------------------------------------------------------
-- <1번 문제>
-- 다음 중 지역(REGIONID) 별 평균 판매량을 구하기 위한 올바른 방법은?
---------------------------------------------------------------------------
SELECT REGIONID, AVG(QTY) FROM KOPO_CHANNEL_SEASONALITY GROUP BY REGIONID

---------------------------------------------------------------------------
-- <2번 문제>
--  RMSE_MAE_EXAMPLE 테이블에서 아래 그림과 같이 새로운 컬럼 ("ERROR")를 
--  절대값(QTY-PREDICTION) 의 값으로 산출하기위한 쿼리를 작성하세요
---------------------------------------------------------------------------
ABS(QTY-PREDICTION) AS ERROR

---------------------------------------------------------------------------
-- <3번 문제>
--   RMSE_MAE_EXAMPLE_STEP2 테이블로 각 주차별 에러를 산출하였지만
--  까다로운 고객이 아이템별(1), 주차별(2),평균에러 산출을 요청했다. 
--  각각 RMSE_MAE_EXAMPLE_STEP2_김효관_1 및 2 이름의 테이블을 생성하세요.
---------------------------------------------------------------------------
-- 첫번째
SELECT * from RMSE_MAE_EXAMPLE_STEP2

CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_채성은_1 
AS
SELECT ITEM,
        --AVG(ERROR) AS MAE
        AVG(ABS(QTY-PREDICTION)) AS MAE
        FROM RMSE_MAE_EXAMPLE_STEP2
GROUP BY ITEM

-- 정답 --
CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_채성은_1 
AS
SELECT T1.ITEM
        --집계함수
        ,AVG(T1.ERROR) AS MAE
FROM (SELECT
           ITEM
           , YEARWEEK
           ,QTY
           ,PREDICTION
           ,ABS(QTY-PREDICTION) AS ERROR
           FROM RMSE_MAE_EXAMPLE_STEP2
      )T1
-- ITEM 별 집계
GROUP BY T1.ITEM           
---------------------------------------------------------------------------           
-- 두번째
CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_채성은_2 
AS
SELECT SUBSTR(YEARWEEK,5,6) AS WEEK,
        AVG(ERROR) AS MAE
        FROM RMSE_MAE_EXAMPLE_STEP2
GROUP BY YEARWEEK
ORDER BY YEARWEEK

-- 정답 --
CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_채성은_2 
AS
SELECT SUBSTR(T1.YEARWEEK,5,6) AS WEEK
        --집계함수
        ,AVG(T1.ERROR) AS MAE
FROM (SELECT
           ITEM
           , YEARWEEK
           ,QTY
           ,PREDICTION
           ,ABS(QTY-PREDICTION) AS ERROR
           FROM RMSE_MAE_EXAMPLE_STEP2
      )T1
-- WEEK 별 집계
GROUP BY SUBSTR(T1.YEARWEEK,5,6) 
ORDER BY SUBSTR(T1.YEARWEEK,5,6)

---------------------------------------------------------------------------
-- <4번 문제>
-- 2번에서 작성한 내용을 오차 산출 시 (제곱) 으로 변경하고 컬럼명을 POW_ERROR로 
-- 변경하고,평균 산출 후 ROOT 연산 (SQRT) 을 하도록 변경해 보세요.
---------------------------------------------------------------------------
SELECT ITEM,
    AVG(T1.POW_ERROR),
    SQRT(AVG(T1.POW_ERROR)) AS RMSE
FROM     
(
    SELECT ITEM,
        YEARWEEK,
        QTY,
        PREDICTION,
        ABS(QTY-PREDICTION) AS ERROR,
        POWER(ABS(QTY-PREDICTION),2) AS POW_ERROR
    FROM RMSE_MAE_EXAMPLE_STEP2
) T1   
GROUP BY T1.ITEM
ORDER BY T1.ITEM;