-- 20180530 ����

-- 1�� 
create table RMSE_MAE_ST_OMJ
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


-- Decode �Լ�(switch�� ���)     
select A.*,
    decode(A.gender, 'Male',1,'Female',2,0) as sort_order
from kopo_customerdata A
where 1=1
order by sort_order;    


-- �и� 0�� ��� ����ó���� decode�� �̿��Ͽ� �ذ��� ����
select A.*,
    DECODE(A.PREDICTION_QTY,0,0
    ,0.5,'UNDEFINED'
    ,(1-ABS(PREDICTION_QTY-REAL_QTY)/PREDICTION_QTY)) AS NEW_ACCURACY    
from DT_RESULT_FINAL3 A; 

-- �׷��Լ�(�����Լ�)
-- 1. ��ü ���̺��� ���
select avg(qty)
from kopo_channel_seasonality_new;

--2. ��ü ���̺��� �ұ׷�ȭ (groub by�� �ݵ�� �ʿ�)
select regionid, avg(qty)
from kopo_channel_seasonality_new
group by regionid
order by regionid;


select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product;

-- having ������

select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product
having avg(qty)>2000;

select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product
having avg(qty)>2000
and regionid like 'A%';

select regionid,
       product,
       avg(qty)
from kopo_channel_seasonality_new
group by regionid,product
having avg(qty)>2000
and regionid like '_01%';

-- RMSE�� item�� �׷�ȭ�Ͽ� ���ϱ�
select A.item,
    sqrt(avg(power(abs(QTY-PREDICTION),2))) RMSE
from RMSE_MAE_EXAMPlE A
group by A.item
order by A.item;

-- ���� ������ ������ ��� Ǯ� �� ���̺�� �����ֵ��� �Ϸ���
-- ITME�� ���� �Լ� ����
SELECT ITEM,
    AVG(ERROR_POW),
    SQRT(AVG(ERROR_POW))
FROM     
(
    -- ERROR�� ���Ѵ�
    SELECT ITEM,
        YEARWEEK,
        QTY,
        PREDICTION,
        ABS(QTY-PREDICTION) AS ERROR,
        POWER(ABS(QTY-PREDICTION),2) AS ERROR_POW
    FROM RMSE_MAE_EXAMPLE
)    
GROUP BY ITEM
ORDER BY ITEM;








