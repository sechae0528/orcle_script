-- �׷��Լ�(�����Լ�)
-- 1. ��ü ���̺��� ���
select avg(qty)
from kopo_channel_seasonality_new;

--2. ��ü ���̺��� �ұ׷�ȭ (groub by�� �ݵ�� �ʿ�)
select regionid, avg(qty)
from kopo_channel_seasonality_new
group by regionid
order by regionid;


select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product;

-- having ������

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

-- RMSE�� item�� �׷�ȭ�Ͽ� ���ϱ�
select A.item,
    sqrt(avg(power(abs(QTY-PREDICTION),2))) RMSE
from RMSE_MAE_EXAMPlE A
group by A.item
order by A.item;

-- ���� ������ ������ ��� Ǯ� �� ���̺�� �����ֵ��� �Ϸ���
-- ITME�� ���� �Լ� ����
SELECT ITEM,
    AVG(ERROR_POW),
    SQRT(AVG(ERROR_POW))
FROM     
(
    -- ERROR�� ���Ѵ�
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
-- ������ ��ȸ (�����Լ���) --
-------------------------------------------------------------------------
-- �ֿ��Լ�
-- COUNT : �־��� �ڷ� ���� ������ �Ǽ��� �����
--              
-- SUM : �־��� �ڷ� ���� ������ �հ踦 �����
--               
-- AVG : �־��� �ڷ� ���� ������ ����� �����
--               
-- MIN/MAX : �־��� �ڷ� ���� ������ �ִ�/�ּҰ��������
--               �� >  FLOOR(12.345) -> 12
-- PIVOT
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- GROUP BY
-------------------------------------------------------------------------
-- SELECT 
--    ������ �÷�1,
--    ������ �÷�2,��
--    AVG(*) ? �����Լ�
--FROM KOPO_CHANNEL_SEASONALITY_NEW
--WHERE ������
--GROUP BY ������ �÷�1, ������ �÷�2
--HAVING ������ (����)
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
-- GROUP BY (����)
-------------------------------------------------------------------------
-- SELECT 
--    ������ �÷�1,
--    ������ �÷�2,��
--    AVG(�÷���)
--FROM KOPO_CHANNEL_SEASONALITY_NEW
--GROUP BY ������ �÷�1, ������ �÷�2
--HAVING AVG(�÷���) > ������ ��
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
-- ���� : RMSE_MAE_EXAMPLE ���̺��� Ȱ���Ͽ� ITEM�� RMSE�� ���ϼ���
-- ���� : ������ - ������
-- MAE : (������ - ������) / ����
-- RMSE : (������ ����/����)�� ��Ʈ
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- RMSE ���ϱ�!!!
-------------------------------------------------------------------------
SELECT * FROM RMSE_MAE_EXAMPLE;

-- ��
-- 1. ���� - ����
-- 2. (���� - ����)�� 2����
-- 3. '2' + AVG(��ü ���� ���)
--4. '3' + ��Ʈ ����� RMSE ���� ���´�.

SELECT 
    ITEM,
    SQRT(AVG(POWER(QTY-PREDICTION,2)) ) AS RMSE
FROM RMSE_MAE_EXAMPLE
GROUP BY ITEM;    
    
-------------------------------------------------------------------------
-- ���� ������ ������ ��� Ǯ� �� ���̺�� �����ֵ��� �Ϸ���
-------------------------------------------------------------------------
SELECT 
    ITEM,
    AVG(ERROR) AS MAE,
    AVG(ERROR_POW),
    SQRT(AVG(ERROR_POW)) AS RMSE
    FROM
    (
        -- ERROR�� ���Ѵ�
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
    
    

