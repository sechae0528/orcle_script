-- Expression �̿��ϱ�
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