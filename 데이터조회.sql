
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



-- UNION ������ (�÷������� ���� ���� ������ ����)

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
  
  