-- 데이터조회_PIVOT, UNPIVOT

-------------------------------------------------------------------------------
-- PIVOT (행을 열로 변환)
-------------------------------------------------------------------------------
-- SELECT * 
-- FROM(
-- SELECT * FROM {대상테이블명}
--) PIVOT(
--   (데이터 값으로 표현할 컬럼명) --예>SUM(SALES)
--   FOR {행을 열로 바꿀 컬럼명} IN (열로 표현할 값 리스트)
--)
-------------------------------------------------------------------------------
SELECT * FROM DT_RESULT_FINAL2
ORDER BY PRODUCTGROUP, PRODUCT, ITEM, YEARWEEK, MEASURE;

SELECT 
    *
     FROM (
        SELECT  *
        FROM DT_RESULT_FINAL2
)
PIVOT( 
    SUM(SALES)
    FOR MEASURE IN ('REAL-QTY' AS REAL_QTY,'PREDICTION-QTY' AS PREDICTION_QTY)
)ORDER BY YEARWEEK;



-------------------------------------------------------------------------------
-- 예제: KOPO_CHANNEL_SEASONALITY_NEW 테이블을 지역/상품별로 평균판매량을 
---------소수점없이 나타내고 W01~W53을 그림과 같은 PIVOT 형태로 표현하세요
-------------------------------------------------------------------------------
SELECT REGIONID
,PRODUCT
,SUBSTR(YEARWEEK,5,6) AS WEEK
,ROUND(AVG(QTY),0) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT, SUBSTR(YEARWEEK,5,6)
ORDER BY REGIONID, PRODUCT, SUBSTR(YEARWEEK,5,6);


SELECT 
    *
     FROM (
        SELECT REGIONID
,PRODUCT
,SUBSTR(YEARWEEK,5,6) AS WEEK
,ROUND(AVG(QTY),0) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT, SUBSTR(YEARWEEK,5,6)
ORDER BY REGIONID, PRODUCT, SUBSTR(YEARWEEK,5,6)
)
PIVOT( 
    SUM(AVG_QTY)
    FOR WEEK IN ('01' AS W01,'02' AS W02,'03' AS W03,'04' AS W04,'05' AS W05
    ,'06' AS W06,'07' AS W07,'08' AS W08,'09' AS W09,'10' AS W10,'11' AS W11
    ,'12' AS W12,'13' AS W13,'14' AS W14,'15' AS W15,'16' AS W16,'17' AS W17
    )
)ORDER BY REGIONID, PRODUCT;


-------------------------------------------------------------------------------
-- UNPIVOT (열을 행으로)
-------------------------------------------------------------------------------
-- WITH T AS( 
--    {대상 테이블명}
--)
--SELECT * FROM T
--UNPIVOT(값에 대한 컬럼명 FOR 열을 행으로 바꿀 컬럼명 IN(행으로 표현할 값 리스트))
-------------------------------------------------------------------------------
-- UNPIVOT
WITH T AS( 
    SELECT * FROM DT_RESULT_FINAL3
)
SELECT * FROM T
UNPIVOT(QTY FOR MEASURE IN(REAL_QTY, PREDICTION_QTY));



SELECT * FROM DT_RESULT_FINAL3;
-- UNPIVOT
WITH T AS( 
    SELECT * FROM DT_RESULT_FINAL3
)
SELECT MEASURE, PRODUCTGROUP, PRODUCT, ITEM, YEARWEEK, QTY FROM T
UNPIVOT(QTY FOR MEASURE IN(REAL_QTY, PREDICTION_QTY));

-------------------------------------------------------------------------------
-- PIVOT 실습 결과를 다시 다시 UNPIVOT 하세요

WITH T AS( 
    SELECT 
    *
     FROM (
        SELECT REGIONID
,PRODUCT
,SUBSTR(YEARWEEK,5,6) AS WEEK
,ROUND(AVG(QTY),0) AS AVG_QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID, PRODUCT, SUBSTR(YEARWEEK,5,6)
ORDER BY REGIONID, PRODUCT, SUBSTR(YEARWEEK,5,6)
)
PIVOT( 
    SUM(AVG_QTY)
    FOR WEEK IN ('01' AS W01,'02' AS W02,'03' AS W03)
)ORDER BY REGIONID, PRODUCT
)
SELECT * FROM T
UNPIVOT(AVG_QTY FOR WEEK IN(W01 AS '01', W02 AS '02',W03 AS '03'));


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 부록. Partition By → Group by + Join
-------------------------------------------------------------------------------
select a.*
    -- partition by equal 
    -- row_number() over (order by qty desc)
    ,row_number() over (order by qty desc) as qty_desc_order
    ,row_number() over (partition by regionid, product order by qty desc) as re_pd_desc_order
    ,avg(qty) over(partition by regionid) as avg_qty_region
    , sum(qty) over(partition by regionid, product) as sum_qty
from kopo_channel_seasonality_new a
-- order by qty desc
order by regionid, product, qty desc;


select a.*, b.qty
from kopo_channel_seasonality_new a,
(select regionid
    , product
    , sum(qty) as qty
from kopo_channel_seasonality_new a
group by regionid, product)b
where 1=1
and a.regionid = b.regionid(+)
and a.product = b.product(+)


