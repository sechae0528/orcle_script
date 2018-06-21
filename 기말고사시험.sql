---------------------------------------------------------------------------
-- 1�б� �⸻��� --
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- 1�� [�⺻��ȸ]kopo channel_seasonality_final ���̺��� ���� ������
--      �����ϴ� ���̺��� �����ϼ���
--    (���� != 53 AND ���� >= 2015 AND ��ǰ(PRODUCT1 �� PRODUCT2)
-- KOPO_ST_�̸�_FINAL1 ���̺�� �����ϼ��� (��: KOPO_ST_��ȿ��_FINAL1)
---------------------------------------------------------------------------
CREATE TABLE KOPO_ST_ä����_FINAL1 
AS
SELECT REGIONID,
       PRODUCT,
       YEARWEEK,
       QTY
FROM kopo_channel_seasonality_final
WHERE 1=1
AND SUBSTR(YEARWEEK,5,2) != 53
AND SUBSTR(YEARWEEK,1,4) >= 2015
AND PRODUCT IN ('PRODUCT1','PRODUCT2')
-- ���� ���ÿ��� PRODUCT NOT IN
-- AND (PRODUCT = 'PRODUCT1' OR PRODUCT = 'PRODUCT2');
ORDER BY REGIONID ASC, PRODUCT ASC, YEARWEEK ASC;

---------------------------------------------------------------------------
-- 2�� [GROUP-BY]
--   1�� ��� ���̺��� ����/��ǰ�� ����Ǹŷ��� �Ҽ��� ����
--   �ݿø��Ͽ� AVG_QTY ���� ������ �� KOPO_ST_�̸�_FINAL2 ���̺�� �����ϼ���
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_ä����_FINAL2  
AS
SELECT REGIONID,
       PRODUCT,
      ROUND(AVG(QTY),0) AS AVG_QTY
FROM KOPO_ST_ä����_FINAL1
GROUP BY REGIONID, PRODUCT;

---------------------------------------------------------------------------
-- 3�� [JOIN] 1����� ���̺��� �������� 2����� ���̺��� LEFT �����Ͽ�
--      [REGIONID, PRODUCT, YEARWEEK, QTY, AVG_QTY] �÷��� ��ȸ�Ͽ�
--      ���̺��� �����ϼ���. (����Ű�� REGIONID, PRODUCT)
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_ä����_FINAL3  
AS
SELECT A.REGIONID
        ,A.PRODUCT
        ,A.YEARWEEK
        ,A.QTY
        ,B.AVG_QTY
FROM KOPO_ST_ä����_FINAL1 A
LEFT JOIN KOPO_ST_ä����_FINAL2 B
ON 1=1
AND A.REGIONID = B.REGIONID
AND A.PRODUCT = B.PRODUCT;


---------------------------------------------------------------------------
-- 4�� [������ �Լ�]3����� ���̺��� QTY/AVG_QTY�� ����Ͽ� RATIO
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_ä����_FINAL4  
AS
SELECT REGIONID
       ,PRODUCT
       ,YEARWEEK
       ,QTY
       ,AVG_QTY
      -- ,ROUND((QTY/AVG_QTY),2) AS RATIO
       ,CASE WHEN AVG_QTY = 0
                THEN 1
            ELSE ROUND((QTY/AVG_QTY),2) END AS RATIO
FROM KOPO_ST_ä����_FINAL3;


---------------------------------------------------------------------------
-- 5��
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_ä����_FINAL5  
AS
SELECT REGIONID
       ,PRODUCT
       ,WEEK       
       ,ROUND(AVG(RATIO),2) AS RATIO
    FROM ( SELECT REGIONID
            ,PRODUCT
            ,YEARWEEK
            ,SUBSTR(YEARWEEK,5,6) AS WEEK
            ,QTY
            ,AVG_QTY
            ,RATIO
            FROM KOPO_ST_ä����_FINAL4
          )
GROUP BY REGIONID,PRODUCT ,WEEK;

-- ���
SELECT A.REGIONID
       ,A.PRODUCT
       ,SUBSTR(A.YEARWEEK,-2) AS WEEK       
       ,ROUND(AVG(RATIO),2) AS RATIO
    FROM KOPO_ST_ä����_FINAL4 A
GROUP BY REGIONID,PRODUCT ,SUBSTR(A.YEARWEEK,-2);

---------------------------------------------------------------------------
-- 6��
---------------------------------------------------------------------------
CREATE TABLE  KOPO_ST_ä����_FINAL6  
AS  
SELECT 
    *
     FROM KOPO_ST_ä����_FINAL5
PIVOT( 
    SUM(RATIO)
    FOR WEEK IN ('01' AS W01,'02' AS W02,'03' AS W03,'04' AS W04,'05' AS W05
    ,'06' AS W06,'07' AS W07,'08' AS W08,'09' AS W09,'10' AS W10
    )
);