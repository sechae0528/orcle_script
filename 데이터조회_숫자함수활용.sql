-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- ������ ��ȸ (�����Լ���) --
------------------------------------------------------------------------
-- �ֿ��Լ�
-- ROUND : �־��� ���ڸ� �ݿø� �� �� �����
--               �� >  ROUND(12.345,2) -> 12.35

-- CEIL : �־��� ���ڿ� ���� ������ ū ���� ����� (�ø�)
--               �� >  CEIL(12.345) -> 13

-- FLOOR : �־��� ���ڿ� ���� ������ ���� ���� ����� ( ����) 
--               �� >  FLOOR(12.345) -> 12

-- MOD : �־��� ���ڸ� ������ �� �� ������ �� ����� (%)
--               �� >  MOD(12,10) -> 2

-- POWER : �־��� ����1�� ����2 ���� ����� (����)
--               �� >  POWER(3,2) -> 9
-------------------------------------------------------------------------

SELECT
    ROUND(12.345, 2)
    ,CEIL(12.345)
    ,FLOOR(12.345)
    ,MOD(12,10)
    ,POWER(3,2)
    FROM DUAL;
    
-------------------------------------------------------------------------
-- ���� : NUMBER_EXAMPLE�� FIRST/NUMBER�� Ȱ���Ͽ� �Ʒ��� ���� 
----------����� ����ϼ���
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
-- ����: RMSE_MAE_EXAMPLE2 ���̺��� 
---------ACCURACY = 1 ? ABS(������-������) / ������ ������ Ȱ���Ͽ�
---------��Ȯ���� �����ϼ��� (�Ҽ��� 2°�ڸ� �ݿø�)
-------------------------------------------------------------------------
SELECT YEARWEEK
       ,ACTUAL
       ,FCST   
       ,ROUND((1-ABS(FCST-ACTUAL)/FCST),4)*100 AS ACCURACY
       FROM RMSE_MAE_EXAMPLE2;

-- ���� 
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
-- ������ ��ȸ (��¥�Լ���) --
-------------------------------------------------------------------------
-- �ֿ��Լ�
-- SYSDATE : �ý��� ���� ��¥/�ð�
--          
-- NEXT_DAY : �ش��ϴ� ��¥ ������ ���Ͽ� �ش��ϴ� ��¥ ���
--               
-- LAST_-DAY : ���� ���� ������ ��¥
--                     
-------------------------------------------------------------------------

SELECT
    SYSDATE
    ,NEXT_DAY(SYSDATE,1)
    ,LAST_DAY(SYSDATE)
FROM DUAL;


-- ���� : 'YYYYWW'
-- ��¥ : 'YYYYMMDD'
SELECT TO_CHAR(SYSDATE, 'YYYY MON DD')
FROM DUAL;

SELECT TO_CHAR(SYSDATE-7, 'YYYY MM DD')||'��' FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY WW') FROM DUAL;

SELECT TO_CHAR(SYSDATE-30, 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL;

SELECT TO_CHAR(SYSDATE-1, 'YYYYMMDD') FROM DUAL;

-------------------------------------------------------------------------
-------------------------------------------------------------------------       
-- ������ ��ȸ (�Ϲ��Լ���) --
-------------------------------------------------------------------------
-- �ֿ��Լ�
-- CASE : ���ǿ� �´°�� WHEN�� ������ ġȯ
--              
-- DECODE : SWITCH CASE ���� ����
--               
-- NVL : NULL ���� ������ �ٸ������� ġȯ
--               �� >  NVL(PRODUCT, NULL)

-- NVL2 : NULL�� �ƴҰ�� A NULL�� ��� B�� ġȯ
--               �� >  NVL2(PRODUCT,VOLUME)
-------------------------------------------------------------------------

-------------------------------------------------------------------------
--CASE WHEN ����ϱ�
-------------------------------------------------------------------------
-- ���ǹ�
-- CASE ���� WHEN ���1 THEN ���1
--               WHEN ���2 THEN ���2
--               ELSE ���3
--END ���÷���
-------------------------------------------------------------------------
SELECT 
    YEARWEEK,
    CASE WHEN QTY<1000 THEN 1000
         WHEN QTY>1000 AND QTY <10000 THEN 10000
         ELSE 30000 END AS QTY
FROM KOPO_CHANNEL_SEASONALITY_NEW;
