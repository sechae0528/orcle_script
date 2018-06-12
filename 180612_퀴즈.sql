-- 180612_����

------------------------------------------------------------------------------
-- 1. CUSTOMERDATA�� CUSTOMER_NAME���̺��� Ű�� �������� �ʰ� �����غ�����. 
--    (īƼ�ǰ�) �ش� ���ο� �����ϴ� ��� ������� �� ���
------------------------------------------------------------------------------
select * from customerdata;
select * from customer_name;

select A.*,B.*
    from customerdata A
    ,customer_name B;
 

-- īƼ�ǰ�  
select A.*,B.*
    from customerdata A
    ,customer_name B
    ORDER BY TO_CHAR(A.CUSTID);    
    
    
------------------------------------------------------------------------------
-- 2. Toad ����Ű 
--  �ּ�ó�� (ctrl+b) �ּ�����(ctrl+shift+b)
--  �����丮 ���� : F8
--  �÷��� ǥ�� : ���̺�ġ . +CTRL or CTRL+T
--  SQL ����: CTRL + ENTER
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- 3. ���� �� ����Ŭ���� ����������� ���� �ٸ������ �����ϴ� �����?
-- (����� ORACLE �ϴ��� ANSI(�̱����ǥ����) �� :(4)!!!!
------------------------------------------------------------------------------

--(1) ��ü ����� �� ����
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B;

SELECT A.*,B.*
FROM CUSTOMERDATA A
CROSS JOIN CUSTOMER_NAME B; 

--(2) INNER ����
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B
WHERE 1=1
AND A.CUSTID = B.CUSTID;

SELECT A.*,B.*
FROM CUSTOMERDATA A
INNER JOIN CUSTOMER_NAME B
ON 1=1
AND A.CUSTID = B.CUSTID; 

--(3)LEFT ����
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B
WHERE 1=1
AND A.CUSTID = B.CUSTID(+);

SELECT A.*,B.*
FROM CUSTOMERDATA A
LEFT JOIN CUSTOMER_NAME B
ON 1=1
AND A.CUSTID = B.CUSTID; 


--(4)FULL OUTER ����(FULL OUTER ������ ���� ��ø� �ؾ���)
-- Ʋ����
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B
WHERE 1=1
AND A.CUSTID(+) = B.CUSTID(+);

-- �´� ��
SELECT A.*,B.*
FROM CUSTOMERDATA A
FULL OUTER JOIN CUSTOMER_NAME B
ON 1=1
AND TO_CHAR(A.CUSTID) = B.CUSTID;  


--(5)RIGHT ����
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B
WHERE 1=1
AND TO_CHAR(A.CUSTID(+)) = B.CUSTID;

SELECT A.*,B.*
FROM CUSTOMERDATA A
RIGHT JOIN CUSTOMER_NAME B
ON 1=1
AND A.CUSTID = B.CUSTID;


------------------------------------------------------------------------------
-- 4. CUST_MGT ���̺��� custid �� mgrid�� Ű�� ������ �����غ�����
------------------------------------------------------------------------------
 
select * from cust_mgt
where 1=1
and custid = mgrid;

SELECT A.*, B.* FROM
CUST_MGT A,
CUST_MGT B
WHERE 1=1
AND A.CUSTID = B.MGRID;
