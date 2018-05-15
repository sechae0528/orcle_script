-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 데이터 조회 (숫자함수편) --
------------------------------------------------------------------------
-- 주요함수
-- ROUND : 주어진 숫자를 반올림 한 후 출력함
--               예 >  ROUND(12.345,2) -> 12.35

-- CEIL : 주어진 숫자와 가장 근접한 큰 정수 출력함 (올림)
--               예 >  CEIL(12.345) -> 13

-- FLOOR : 주어진 숫자와 가장 근접한 작은 정수 출력함 ( 내림) 
--               예 >  FLOOR(12.345) -> 12

-- MOD : 주어진 숫자를 나누기 한 후 나머지 값 출력함 (%)
--               예 >  MOD(12,10) -> 2

-- POWER : 주어진 숫자1의 숫자2 승을 출력함 (제곱)
--               예 >  POWER(3,2) -> 9
-------------------------------------------------------------------------

SELECT
    ROUND(12.345, 2)
    ,CEIL(12.345)
    ,FLOOR(12.345)
    ,MOD(12,10)
    ,POWER(3,2)
    FROM DUAL;
    
-------------------------------------------------------------------------
-- 예제 : NUMBER_EXAMPLE에 FIRST/NUMBER를 활용하여 아래와 같은 
----------결과를 출력하세요
-------------------------------------------------------------------------
SELECT * FROM NUMBER_EXAMPLE;

SELECT 
    FIRST_NUMBER
    ,SECOND_NUMBER
    ,(FIRST_NUMBER/SECOND_NUMBER) AS AVG
    ,ROUND(FIRST_NUMBER/SECOND_NUMBER) AS ROUND_EX
    ,CEIL(FIRST_NUMBER/SECOND_NUMBER) AS CEIL_EX
    ,FLOOR(FIRST_NUMBER/SECOND_NUMBER) AS FLOOR_EX
    ,MOD(FIRST_NUMBER, SECOND_NUMBER) AS MOD_EX
    ,POWER(FIRST_NUMBER, SECOND_NUMBER) AS POW_EX
    FROM NUMBER_EXAMPLE;
    
-------------------------------------------------------------------------    
-- 예제: RMSE_MAE_EXAMPLE2 테이블에서 
---------ACCURACY = 1 ? ABS(예측값-실제값) / 예측값 공식을 활용하여
---------정확도를 산출하세요 (소수점 2째자리 반올림)
-------------------------------------------------------------------------
SELECT YEARWEEK
       ,ACTUAL
       ,FCST   
       ,ROUND((1-ABS(FCST-ACTUAL)/FCST),4)*100 AS ACCURACY
       FROM RMSE_MAE_EXAMPLE2;

-- 응용 
SELECT *
FROM
 (SELECT YEARWEEK
       ,ACTUAL
       ,FCST   
       ,ROUND((1-ABS(FCST-ACTUAL)/FCST),4)*100 AS ACCURACY
       FROM RMSE_MAE_EXAMPLE2
       ) WHERE 1=1
       AND ACCURACY < 50;
       
       
       
SELECT 
    POWER(2,2)
    ,SQRT(4)
    FROM DUAL;
 
-------------------------------------------------------------------------
-------------------------------------------------------------------------       
-- 데이터 조회 (날짜함수편) --
-------------------------------------------------------------------------
-- 주요함수
-- SYSDATE : 시스템 현재 날짜/시간
--          
-- NEXT_DAY : 해당하는 날짜 다음의 요일에 해당하는 날짜 출력
--               
-- LAST_-DAY : 속한 달의 마지막 날짜
--                     
-------------------------------------------------------------------------

SELECT
    SYSDATE
    ,NEXT_DAY(SYSDATE,1)
    ,LAST_DAY(SYSDATE)
FROM DUAL;


-- 주차 : 'YYYYWW'
-- 날짜 : 'YYYYMMDD'
SELECT TO_CHAR(SYSDATE, 'YYYY MON DD')
FROM DUAL;

SELECT TO_CHAR(SYSDATE-7, 'YYYY MM DD')||'일' FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY WW') FROM DUAL;

SELECT TO_CHAR(SYSDATE-30, 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(SYSDATE-1, 'YYYYMMDD') FROM DUAL;

-------------------------------------------------------------------------
-------------------------------------------------------------------------       
-- 데이터 조회 (일반함수편) --
-------------------------------------------------------------------------
-- 주요함수
-- CASE : 조건에 맞는경우 WHEN절 값으로 치환
--              
-- DECODE : SWITCH CASE 문과 같음
--               
-- NVL : NULL 값을 만나면 다른값으로 치환
--               예 >  NVL(PRODUCT, NULL)

-- NVL2 : NULL이 아닐경우 A NULL일 경우 B로 치환
--               예 >  NVL2(PRODUCT,VOLUME)
-------------------------------------------------------------------------

-------------------------------------------------------------------------
--CASE WHEN 사용하기
-------------------------------------------------------------------------
-- 조건문
-- CASE 조건 WHEN 결과1 THEN 출력1
--               WHEN 결과2 THEN 출력2
--               ELSE 출력3
--END “컬럼명
-------------------------------------------------------------------------
SELECT 
    YEARWEEK,
    CASE WHEN QTY<1000 THEN 1000
         WHEN QTY>1000 AND QTY <10000 THEN 10000
         ELSE 30000 END AS QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW;
