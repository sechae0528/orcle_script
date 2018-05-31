-- 20180530 ����

-- 1�� 
create table RMSE_MAE_ST_CSE
as
select 1-ABS(FCST-ACTUAL)/FCST ACCURACY
from RMSE_MAE_EXAMPLE2;

-- 4��
select a.*, 
case when substr(CUSTID,1,1)='A' then  1
     when substr(CUSTID,1,1)='B' then  0 
     when substr(CUSTID,1,1)='C' then  2
     else 3 end as newOrder
     from  CUSTOMERDATA a
     order by new_order;
     
-- 4�� ����(substr�Լ��� �ε��� �÷����� ��ü)
--- INDEX_COLUMN
select
    DATA.*,
    case when DATA.INDEX_COL = 'A' THEN 0
        when DATA.INDEX_COL = 'B' THEN 1
        when DATA.INDEX_COL = 'C' THEN 2
        ELSE 3 END AS PRIO
FROM    
(
select A.*,
    substr(CUSTID,1,1) AS INDEX_COL
    from customerdata A
)DATA
ORDER BY PRIO;

-- ��¥������ ��ȯ
-- �� + ��
select to_number(to_char(sysdate,'YYYYMM')) 
from dual;
-- �� + ���� (�ǹ����� ���� ��)
select to_char(sysdate,'YYYYIW') 
from dual;
