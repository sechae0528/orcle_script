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

