select * from tabs;


select * from test_leftjoindata;

-- ���̺� �����
create table lefttable 
(
       regionid varchar2(20),
       productgroup varchar2(20),
       yearweek varchar2(20),
       qty number
       );
       
CREATE righttable 
(
       
       productid varchar2(20),
       producname varchar2(20)
       
       );

--���̺� �ȿ� ��� �����ϱ�       
edit lefttable;

edit RIGHTTABLE;

select * from lefttable;

select * from righttable;

-- ���̺� 2�� LEFT JOIN
SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, B.PRODUCTNAME
    FROM LEFTTABLE A LEFT JOIN RIGHTTABLE B
    ON A.PRODUCTGROUP = B.PRODUCTID;

-- ���̺� 2�� INNER JOIN
SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, B.PRODUCTNAME
    FROM LEFTTABLE A inner join RIGHTTABLE B
    ON A.PRODUCTGROUP = B.PRODUCTID;


create table promotion 
(        
       promotion_week varchar2(20),
       promotion_ratio varchar2(20)
       );
       

edit promotion;

select * from promotion;



    
-- ���̺� 3�� ���ι��    
    
 SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, A.PRODUCTNAME, C.PROMOTION_RATIO
 from (   
    
    SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, B.PRODUTCNAME
    FROM LEFTTABLE A LEFT JOIN RIGHTTABLE B
    ON A.PRODUCTGROUP = B.PRODUCTID
    
    )A LEFT JOIN promotion C
    ON A.YEARWEEK = C.PROMOTION_WEEK;
    
   

-- ���̺� 3���̻� ���ι�� �߿�!!

-- ù��° ��� 
SELECT  A.REGIONID, 
        A.PRODUCTGROUP, 
        A.YEARWEEK, 
        A.QTY, 
        B.PRODUCTNAME, 
        C.PROMOTION_RATIO, 
        D.SCORE
    FROM LEFTTABLE A LEFT JOIN RIGHTTABLE B
    ON A.PRODUCTGROUP = B.PRODUCTID
    LEFT JOIN promotion C
    ON A.YEARWEEK = C.PROMOTION_WEEK
    LEFT JOIN PRODUCT_SCORE D
    ON A.PRODUCTGROUP = D.PRODUCT;


-- �ι�° ���    
SELECT  A.REGIONID, 
        A.PRODUCTGROUP, 
        A.YEARWEEK, 
        A.QTY, 
        B.PRODUCTNAME, 
        C.PROMOTION_RATIO, 
        D.SCORE
    FROM LEFTTABLE A,
         RIGHTTABLE B, 
         promotion C,
         PRODUCT_SCORE D
    WHERE 1=1
    AND  A.PRODUCTGROUP = B.PRODUCTID (+)
    AND  A.YEARWEEK = C.PROMOTION_WEEK (+)
    AND  A.PRODUCTGROUP = D.PRODUCT (+);
    


-- ������ �ɷ��� �����ϱ� 
select * from lefttable
where 1=1
and yearweek = '201502';   
    
    
    

-- ���̺��� �÷� �̷� ������� ��    
alter table righttable 
rename column test to productname



create table PRODUCT_SCORE 
(        
       PROCUT varchar2(20),
       SCORE NUMBER
       );
       
   
alter table PRODUCT_SCORE ;


-- ���̺���� �÷��� �缳��
rename column PROCUT to PRODUCT;

edit PRODUCT_SCORE;


--���̺��� �÷� Ÿ�Ժ����
alter table promotion modify(promotion_ratio NUMBER);
