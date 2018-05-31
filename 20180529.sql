-- 20180530 퀴즈

-- 1번 
create table RMSE_MAE_ST_OMJ
as
select 1-ABS(FCST-ACTUAL)/FCST ACCURACY
from RMSE_MAE_EXAMPLE2;

-- 4번
select a.*, 
case when substr(CUSTID,1,1)='A' then  1
     when substr(CUSTID,1,1)='B' then  0 
     when substr(CUSTID,1,1)='C' then  2
     else 3 end as newOrder
     from  CUSTOMERDATA a
     order by new_order;
     
-- 4번 응용(substr함수를 인덱스 컬럼으로 대체)
--- INDEX_COLUMN
select
    DATA.*,
    case when DATA.INDEX_COL = 'A' THEN 0
        when DATA.INDEX_COL = 'B' THEN 1
        when DATA.INDEX_COL = 'C' THEN 2
        ELSE 3 END AS PRIO
FROM    
(
select A.*,
    substr(CUSTID,1,1) AS INDEX_COL
    from customerdata A
)DATA
ORDER BY PRIO;

-- 날짜데이터 변환
-- 년 + 월
select to_number(to_char(sysdate,'YYYYMM')) 
from dual;
-- 년 + 주차 (실무에서 많이 씀)
select to_char(sysdate,'YYYYIW') 
from dual;


-- Decode 함수(switch와 비슷)     
select A.*,
    decode(A.gender, 'Male',1,'Female',2,0) as sort_order
from kopo_customerdata A
where 1=1
order by sort_order;    


-- 분모가 0인 경우 예외처리를 decode를 이용하여 해결한 문제
select A.*,
    DECODE(A.PREDICTION_QTY,0,0
    ,0.5,'UNDEFINED'
    ,(1-ABS(PREDICTION_QTY-REAL_QTY)/PREDICTION_QTY)) AS NEW_ACCURACY    
from DT_RESULT_FINAL3 A; 

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








