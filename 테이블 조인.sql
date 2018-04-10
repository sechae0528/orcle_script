select * from tabs;


select * from test_leftjoindata;

-- 테이블 만들기
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

--테이블 안에 디비 편집하기       
edit lefttable;

edit RIGHTTABLE;

select * from lefttable;

select * from righttable;

-- 테이블 2개 LEFT JOIN
SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, B.PRODUCTNAME
    FROM LEFTTABLE A LEFT JOIN RIGHTTABLE B
    ON A.PRODUCTGROUP = B.PRODUCTID;

-- 테이블 2개 INNER JOIN
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



    
-- 테이블 3개 조인방법    
    
 SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, A.PRODUCTNAME, C.PROMOTION_RATIO
 from (   
    
    SELECT A.REGIONID, A.PRODUCTGROUP, A.YEARWEEK, A.QTY, B.PRODUTCNAME
    FROM LEFTTABLE A LEFT JOIN RIGHTTABLE B
    ON A.PRODUCTGROUP = B.PRODUCTID
    
    )A LEFT JOIN promotion C
    ON A.YEARWEEK = C.PROMOTION_WEEK;
    
   

-- 테이블 3개이상 조인방법 중요!!

-- 첫번째 방법 
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


-- 두번째 방법    
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
    


-- 데이터 걸러서 선택하기 
select * from lefttable
where 1=1
and yearweek = '201502';   
    
    
    

-- 테이블에서 컬럼 이럼 재수정할 때    
alter table righttable 
rename column test to productname



create table PRODUCT_SCORE 
(        
       PROCUT varchar2(20),
       SCORE NUMBER
       );
       
   
alter table PRODUCT_SCORE ;


-- 테이블안의 컬럼명 재설정
rename column PROCUT to PRODUCT;

edit PRODUCT_SCORE;


--테이블에서 컬럼 타입변경시
alter table promotion modify(promotion_ratio NUMBER);
