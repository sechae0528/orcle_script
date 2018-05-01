
-- SELECTION �༱��

select * from kopo_product_volume
where 1=1
and volume > 3000;


select * from kopo_product_volume
where 1=1
and yearweek >= 201601
and PRODUCTGROUP = 'ST0001';


-- ���ϴ� �÷�(��)�� �������� ���� ��,

SELECT PRODUCTGROUP from kopo_product_volume;


------------------------------------------------------
-- UNION ������ (�÷������� ���� ���� ������ ����)
-------------------------------------------------------

SELECT REGIONID, PRODUCTGROUP, YEARWEEK, VOLUME 
    FROM kopo_product_volume_A01
UNION
SELECT REGIONID, PRODUCTGROUP, YEARWEEK, VOLUME
    FROM kopo_product_volume_A02;
    
    
-- UNION ALL �� �ߺ����Ÿ� ���� ����, ������ �ȵ�. ��� �����ӵ��� ����.

-- 'ctr + e ' �� ������ ó���� �Ǽ��� cost ���� �� �� ����.
--  UNION �� UNION ALL ���� COST ��뷮�� ���� ���� �� �� ����.

SELECT * FROM KOPO_CHANNEL_RESULT_A01
UNION 
SELECT * FROM KOPO_CHANNEL_RESULT_A02;


SELECT REGIONID, PRODUCTGROUP, YEARWEEK, QTY 
    FROM KOPO_CHANNEL_RESULT_A01
UNION ALL
SELECT REGIONID, PRODUCTGROUP, YEARWEEK, QTY
    FROM KOPO_CHANNEL_RESULT_A02;
    
-- ����� ���̺� ��� ��ȸ�ϱ�
--SELECT {�÷� ����Ʈ} OR {*}
--FROM TABS;

--COLUMN = NUM_ROW : ���̺� ���� �Ǽ� Ȯ�� ����

-- ������ ��ȸ�ϱ�
--SELECT {�÷� ����Ʈ} OR {*}
--FROM {���̺��}



---------------------------------------------------
-- Expression �̿��ϱ�
----------------------------------------------------
--SELECT
--   {Expression} AS {�÷���},
--   REGIONID
--FROM {���̺��}

select * from kopo_product_volume;


---- Expression ǥ����  (�÷� || �÷�) ( CONCAT�� ��밡��)
---- �÷��� �ٿ��� �� �÷��� ��Ÿ�� �� ���
SELECT 
    'D516' AS MEASUREID,
    3*4 AS TEMVALUE,
    REGIONID || '_' || PRODUCTGROUP || '_' || YEARWEEK AS KEY,
    CONCAT(REGIONID, PRODUCTGROUP) AS CON,
    -- CONCAT(REGIONID,CONCAT('_',PRODUCTGROUP)) AS CON2,  
    --CONCAT ���ÿ��� �÷�2�������� ���� 3���̻��Ϸ��� ��ø�ؾ��Ѵ�.
    REGIONID,    
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME
  FROM kopo_product_volume;
  

-- EXPRESS ���� : KOPO_PRODUCT_VOLUME ����
-- Expression�� Ȱ���Ͽ�
--�� �տ� MeasureID �̸��� �÷����� ��KOPO_D510��
--���� �����ǵ��� ��ȸ�ϼ���

SELECT * FROM KOPO_PRODUCT_VOLUME;
  
SELECT
    'KOPO_D510' AS MEASUREID,
    REGIONID,
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME,
    CAST(YEARWEEK AS NUMBER) * VOLUME AS TEST14
    FROM KOPO_PRODUCT_VOLUME;
   

----------------------------------------------------------
-- �ߺ��� �� �����ϱ�(DISTINCT)
----------------------------------------------------------
--SELECT
--   DISTINCT {�÷���}
--FROM {���̺��}

SELECT DISTINCT REGIONID, 
                PRODUCTGROUP,
                PRODUCT,
                YEARWEEK,
                YEAR,
                WEEK,
                QTY 
    FROM KOPO_CHANNEL_SEASONALITY;

-- DISTIONCT ����
-- ��ǰ��(PRODUCTGROUP)�� ���� DISTINCT ���� ��
--�÷��̸��� PRODUCT�� �����غ�����

SELECT DISTINCT PRODUCTGROUP AS PRODUCT
    FROM KOPO_PRODUCT_VOLUME;

-------------------------------------------------------------
-- ������(WHERE) ����ϱ�
-------------------------------------------------------------
-- SELECT {�÷� ����Ʈ}
-- FROM {���̺��}
-- WHERE ������

-- ���� : KOPO_PRODUCT_VOLUME ���̺���
----------ST0002 ��ǰ�� 201515, 201516�⵵ ��ǰ�� ��ȸ�ϼ���
SELECT * FROM KOPO_PRODUCT_VOLUME
    WHERE 1=1
    AND PRODUCTGROUP = 'ST0002'
    AND (YEARWEEK = '201515'
        OR YEARWEEK = '201516');
    
SELECT * FROM KOPO_PRODUCT_VOLUME
    WHERE 1=1
    AND PRODUCTGROUP = 'ST0002'
    AND YEARWEEK IN ('201515', '201516');
    
    
    
-- ������ ���  
-------------------------------------------------------------    
     
-- ����: KOPO_PROMOTION ���̺��� ��ȸ�� ����
---------PMAP�� 10%���ε� ������ ROUND ó���Ͽ� PMAP�̶�� �÷��� �����ϼ���
-- ROUND �Լ� (��Ÿ�� ��, �ݿø��Ͽ� ��Ÿ�� �ڸ���)
SELECT REGIONID,
        ITEM,  
        TARGETWEEK, 
        PLANWEEK,
        MAP_PRICE,
        IR,
        PMAP,
        PRODUCT,
        ROUND(PMAP*0.9,1) AS PMAP_NEW
    FROM KOPO_PROMOTION;
    


-- ���� : KOPO_PROMOTION ���̺��� PMAP/MAP_PRICE ������ ���ؼ� PERCENT
----------�÷��� �����ϼ���
-----CASE �� END �� �� ���� �����!!!

--�и� 0�� ���� �ɷ������
SELECT 
    CASE WHEN MAP_PRICE = 0
            THEN 1
       ELSE PMAP/MAP_PRICE END AS PERCENT
FROM KOPO_PROMOTION;

-- �̷��Ե� ��밡�� (WHEN�� ������ �Ἥ)
SELECT 
    CASE WHEN MAP_PRICE = 0
            THEN 1
         WHEN MAP_PRICE = 1
            THEN 2
       ELSE PMAP/MAP_PRICE END AS PROMOTION_RATIO
FROM KOPO_PROMOTION;

-- ���� �и� NULL �̸� NVL() ���
-- NVL(MAP_PRICE, 1) MAP_PRICE�� NULL �̸� 1���� �־ �����ض�. 
SELECT 
    CASE WHEN MAP_PRICE = 0
            THEN 1
         WHEN MAP_PRICE = 1
            THEN 2
       ELSE PMAP/NVL(MAP_PRICE, 1) END AS PROMOTION_RATIO
FROM KOPO_PROMOTION;


-----������ ����Ʈ �߿��� �͸�
-------------------------------------------------------------
------BETWEEN a AND b : a�� b ���̿� �ִ� ���� ���� ��� �˻�(a, b �� ����)
------IN (a,b,c) : A �̰ų� B �̰ų� C �� ������ �˻�
------LIKE : Ư�� ������ ������ �ִ� ������ �˻� 
-------(�� > LIKE '%MST%' : MST�� �ܾ �ִ� �����ʹ� ��� �˻�) 
------IS NULL/ IS NOT NULL : Null ���� �˻� / Null �� �ƴ� ���� �˻�