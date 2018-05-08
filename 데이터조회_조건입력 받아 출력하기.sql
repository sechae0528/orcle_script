-- ������ ��ȸ�ϱ� --

SELECT * FROM KOPO_PRODUCT_VOLUME;

--------------------------------------------------------------------------
-- ����� ���� �Է¹ޱ�
--SELECT
--   {�÷� ����Ʈ}
--FROM KOPO_PRODUCT_VOLUME
--WHERE �÷��� = &colon
--------------------------------------------------------------------------
-- PRODUCT�� �������� �־ ��ȸ�ϱ� --
SELECT
   REGIONID
   , PRODUCTGROUP
   , YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = &PRODUCT
OR YEARWEEK = '201544';

--- ���� : KOPO_PROMOTION ���̺��� STARTWEEK ENDWEEK 2����
--- -------����� ������ �Է� �޾� 201501, 201503 ���� �����͸� ��ȸ�ϼ���.

SELECT * from KOPO_PROMOTION;

SELECT REGIONID
   , ITEM
   , TARGETWEEK
   , PLANWEEK
   , MAP_PRICE
   , IR
   , PMAP
   , PRODUCT
FROM KOPO_PROMOTION
WHERE 1=1
AND TARGETWEEK BETWEEN &STARTWEEK AND &ENDWEEK;

---------------------------------------------------------------------------
-- �����ϱ�
-- �⺻ ���� ��������
-- ASC[��������] / DESC [��������]
---------------------------------------------------------------------------
--SELECT
--   {�÷� ����Ʈ}
--FROM KOPO_PRODUCT_VOLUME
--WHERE {������}
--ORDER BY {�÷� ����Ʈ}

--�ǽ�����
SELECT
   REGIONID, PRODUCTGROUP, YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
AND YEARWEEK BETWEEN 201501 AND 201503
ORDER BY YEARWEEK DESC;


SELECT * 
FROM KOPO_CUSTOMERDATA;

SELECT DISTINCT GENDER 
FROM KOPO_CUSTOMERDATA;

---------------------------------------------------------------------------
---���ڸ� �ѹ����ؼ� �����ϱ� 
-- NOT Available -> Male -> Female

SELECT A.*,
       CASE WHEN A.GENDER = 'Not Available'
            THEN 0
            WHEN A.GENDER = 'Male'
            THEN 1
            ELSE 2 END AS SORT_ORDER 
FROM KOPO_CUSTOMERDATA A
ORDER BY SORT_ORDER;


SELECT A.*,
        --LOWER (�ҹ��� ��ȯ) UPPER (�빮�� ��ȯ)
       CASE WHEN UPPER(A.GENDER) = 'NOT AVAILABLE'
            THEN 0
            WHEN LOWER(A.GENDER) = 'male'
            THEN 1
            ELSE 2 END AS SORT_ORDER 
FROM KOPO_CUSTOMERDATA A
ORDER BY SORT_ORDER;


-- ���� : KOPO_PRODUCT_VOLUME ���̺��� ����, ��ǰ, ���� 
----------�������� ���·�  ��ȸ�ǰ� �ϼ���

SELECT DISTINCT PRODUCTGROUP 
FROM KOPO_PRODUCT_VOLUME;

SELECT *
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK;


---------------------------------------------------------------------------
-- ���� ������ (UNION, INTERSECT, MINUS)
-- { ���̺� #1}
-- UNION ALL / INTERSECT / MINUS
-- { ���̺� #2}
---------------------------------------------------------------------------
-- UNION (������) -- UNION �� UNION ALL �� ���̴� ctrl + e �� Ȯ���غ���
SELECT * 
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
UNION --ALL
SELECT * 
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0002';

---------------------------------------------------------------------------
-- INTERSECT (������)
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
INTERSECT
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0002';

---------------------------------------------------------------------------
-- MINUS (������)
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
MINUS
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0002';
 
-- NOT IN (������)
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE 1=1
AND PRODUCTGROUP = 'ST0001'
AND YEARWEEK NOT IN ( SELECT DISTINCT YEARWEEK
                        FROM KOPO_CHANNEL_RESULT_NEW
                    )
ORDER BY YEARWEEK;
                        