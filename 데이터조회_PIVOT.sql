-- ��������ȸ_PIVOT, UNPIVOT

-------------------------------------------------------------------------------
-- PIVOT (���� ���� ��ȯ)
-------------------------------------------------------------------------------
-- SELECT * 
-- FROM(
-- SELECT * FROM {������̺��}
--) PIVOT(
--   (������ ������ ǥ���� �÷���) --��>SUM(SALES)
--   FOR {���� ���� �ٲ� �÷���} IN (���� ǥ���� �� ����Ʈ)
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
-- ����: KOPO_CHANNEL_SEASONALITY_NEW ���̺��� ����/��ǰ���� ����Ǹŷ��� 
---------�Ҽ������� ��Ÿ���� W01~W53�� �׸��� ���� PIVOT ���·� ǥ���ϼ���
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
-- UNPIVOT (���� ������)
-------------------------------------------------------------------------------
-- WITH T AS( 
--    {��� ���̺��}
--)
--SELECT * FROM T
--UNPIVOT(���� ���� �÷��� FOR ���� ������ �ٲ� �÷��� IN(������ ǥ���� �� ����Ʈ))
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
-- PIVOT �ǽ� ����� �ٽ� �ٽ� UNPIVOT �ϼ���

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
-- �η�. Partition By �� Group by + Join
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


