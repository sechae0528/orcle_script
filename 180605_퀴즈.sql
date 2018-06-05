-- 20180605 ����
---------------------------------------------------------------------------
-- <1�� ����>
-- ���� �� ����(REGIONID) �� ��� �Ǹŷ��� ���ϱ� ���� �ùٸ� �����?
---------------------------------------------------------------------------
SELECT REGIONID, AVG(QTY) FROM KOPO_CHANNEL_SEASONALITY GROUP BY REGIONID

---------------------------------------------------------------------------
-- <2�� ����>
--  RMSE_MAE_EXAMPLE ���̺��� �Ʒ� �׸��� ���� ���ο� �÷� ("ERROR")�� 
--  ���밪(QTY-PREDICTION) �� ������ �����ϱ����� ������ �ۼ��ϼ���
---------------------------------------------------------------------------
ABS(QTY-PREDICTION) AS ERROR

---------------------------------------------------------------------------
-- <3�� ����>
--   RMSE_MAE_EXAMPLE_STEP2 ���̺�� �� ������ ������ �����Ͽ�����
--  ��ٷο� ���� �����ۺ�(1), ������(2),��տ��� ������ ��û�ߴ�. 
--  ���� RMSE_MAE_EXAMPLE_STEP2_��ȿ��_1 �� 2 �̸��� ���̺��� �����ϼ���.
---------------------------------------------------------------------------
-- ù��°
SELECT * from RMSE_MAE_EXAMPLE_STEP2

CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_ä����_1 
AS
SELECT ITEM,
        --AVG(ERROR) AS MAE
        AVG(ABS(QTY-PREDICTION)) AS MAE
        FROM RMSE_MAE_EXAMPLE_STEP2
GROUP BY ITEM

-- ���� --
CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_ä����_1 
AS
SELECT T1.ITEM
        --�����Լ�
        ,AVG(T1.ERROR) AS MAE
FROM (SELECT
           ITEM
           , YEARWEEK
           ,QTY
           ,PREDICTION
           ,ABS(QTY-PREDICTION) AS ERROR
           FROM RMSE_MAE_EXAMPLE_STEP2
      )T1
-- ITEM �� ����
GROUP BY T1.ITEM           
---------------------------------------------------------------------------           
-- �ι�°
CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_ä����_2 
AS
SELECT SUBSTR(YEARWEEK,5,6) AS WEEK,
        AVG(ERROR) AS MAE
        FROM RMSE_MAE_EXAMPLE_STEP2
GROUP BY YEARWEEK
ORDER BY YEARWEEK

-- ���� --
CREATE TABLE RMSE_MAE_EXAMPLE_STEP2_ä����_2 
AS
SELECT SUBSTR(T1.YEARWEEK,5,6) AS WEEK
        --�����Լ�
        ,AVG(T1.ERROR) AS MAE
FROM (SELECT
           ITEM
           , YEARWEEK
           ,QTY
           ,PREDICTION
           ,ABS(QTY-PREDICTION) AS ERROR
           FROM RMSE_MAE_EXAMPLE_STEP2
      )T1
-- WEEK �� ����
GROUP BY SUBSTR(T1.YEARWEEK,5,6) 
ORDER BY SUBSTR(T1.YEARWEEK,5,6)

---------------------------------------------------------------------------
-- <4�� ����>
-- 2������ �ۼ��� ������ ���� ���� �� (����) ���� �����ϰ� �÷����� POW_ERROR�� 
-- �����ϰ�,��� ���� �� ROOT ���� (SQRT) �� �ϵ��� ������ ������.
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