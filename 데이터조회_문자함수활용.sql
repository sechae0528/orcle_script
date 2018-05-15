-- ������ ��ȸ (�����Լ���) --

-------------------------------------------------------------------------
-- �ֿ��Լ�
-- LOWER/UPPER : �Է� ���� ���� ��/�� ���ڷ� ��ȯ  
--               �� >  LOWER(��ABCD��) �� abcd / UPPER(��ABCD��) �� ABCD

-- CONCAT : �� ���ڿ��� �����ؼ� ���. || �����ڿ� ����
--               �� >  CONCAT(��A��,��B��) -> AB

-- SUBSTR : �־��� ���ڿ��� Ư�� ���ڸ� ����  
--               �� >  SUBSTR(��ABC��,1,2) -> AB

-- LPAD/RPAD : �־��� ���ڿ����� �������� Ư�� ���ڸ� ä��
--               �� >  LPAD(��love��,6,��*��) -> **love

-- LTRIM/RTRIM : �־��� ���ڿ����� ���ʿ��� Ư�� ���ڸ� ����  
--               �� >  LLTRIM(��*love��,��*��) -> love

-- REPLACE : �־��� ���ڿ����� A �� E �� ġȯ��
--               �� >  REPLACE(��AB��,��A��,��E��) -> EB
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- ��/�ҹ��� ���� (UPPER, LOWER)
--SELECT 
--   UPPER(�÷���),
--   LOWER(�÷���),
--FROM {���̺��}
-------------------------------------------------------------------------
SELECT 
    UPPER(PRODUCT) AS CASE1,
    LOWER(PRODUCT) AS CASE2
    FROM KOPO_CHANNEL_SEASONALITY_NEW;

-- �Է��ϴ� ���� ��/�ҹ��� �����ϱ�    
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND LOWER(REGIONID) = LOWER(&UI_INPUT1)
AND LOWER(PRODUCT) = LOWER(&UI_INPUT2);


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- �÷� �� ��ġ�� ( CONCAT, || )
--SELECT 
--   CONCAT(�÷���1, �÷���2),
--   �÷���1 || �÷���2
--FROM {���̺��}
-------------------------------------------------------------------------
SELECT 
    CONCAT(REGIONID,CONCAT('_',PRODUCT)) AS KEYCOL1,
    REGIONID||'_'||PRODUCT AS KEYCOL2
FROM KOPO_CHANNEL_SEASONALITY_NEW;


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- �÷� �� �����ϱ�
--SELECT 
--   SUBSTR(�����ڿ��� OR �÷���, �����ε���, �����ε���)
--FROM {���̺��}
-------------------------------------------------------------------------
SELECT 
    PRODUCT,
    SUBSTR(PRODUCT,1,7)
FROM KOPO_CHANNEL_SEASONALITY_NEW;

SELECT substr('201642',1,4) FROM DUAL;
-- 2016 (1��°�̻� 4��°���� ��ȸ)
SELECT substr('201642',5,6) FROM DUAL;
-- 42 (5��°�̻� 6��°���� ��ȸ)

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- �÷� �� ä���
--SELECT 
--   LPAD(�÷���, �ڸ���, �����Ϲ��ڡ�)
--FROM {���̺��}
-------------------------------------------------------------------------
SELECT 
LPAD(PRODUCTGROUP, 10, '0')
FROM KOPO_CHANNEL_SEASONALITY_NEW;


SELECT lpad('UN42F6000', 13, '0') FROM DUAL;
-- ���ʿ� 0�� �ٿ��� 13�ڸ��� ������.
SELECT upper('asddxcDDDDDss') FROM DUAL;
--��� ���ڸ� �빮�ڷ� �ٲ��.

-------------------------------------------------------------------------
-- ���� : KOPO_CUSTOMERDATA���� CUSTOMERCODE�� 12�ڸ��� ��ȸ�ϼ���
----------��, 12�ڸ��� �ȵɰ�� �տ� ��*���� ä�켼��
SELECT lpad(CUSTOMERCODE, 12, '*') FROM KOPO_CUSTOMERDATA;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- �÷� �� �����ϱ�
--SELECT 
--   REPLACE(���ڿ� OR �÷���, ������1��,������2��)
--FROM {���̺��}
-------------------------------------------------------------------------
SELECT 
    REGIONID,
    REPLACE(REGIONID,'A','REGION')
FROM KOPO_CHANNEL_SEASONALITY_NEW;


-------------------------------------------------------------------------
-- ���� : KOPO_CUSTOMERDATA�� ���ڵ��10�ڸ��̴�
---------���� 10�ڸ��� �ƴϸ� ���ʿ� 0���� ä���
---------���� ���ڵ��� �� 4�ڸ��� ��ȣȭ�� ���� * ó���� �ؾ��մϴ�.

SELECT CUSTOMERCODE FROM KOPO_CUSTOMERDATA;


select * from KOPO_CUSTOMERDATA order by lpad(CUSTOMERCODE,10,'0');

select 
    lpad(CUSTOMERCODE,10,'0')
    from KOPO_CUSTOMERDATA;

SELECT substr(lpad(CUSTOMERCODE,10,'0'), -4) 
FROM KOPO_CUSTOMERDATA;

SELECT 
    REPLACE(lpad(CUSTOMERCODE,10,'0') ,substr(lpad(CUSTOMERCODE,10,'0'), -4),'****')
FROM KOPO_CUSTOMERDATA;

-- ���� ����!! --
SELECT 
--10�ڸ�
LPAD(CUSTOMERCODE,10,'0'),
-- ��4�ڸ�
SUBSTR(LPAD(CUSTOMERCODE,10,'0'), -4),
REPLACE(LPAD(CUSTOMERCODE,10,'0') 
        ,substr(LPAD(CUSTOMERCODE,10,'0'), -4)
        ,'****')
FROM KOPO_CUSTOMERDATA;        