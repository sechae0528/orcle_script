-- 180612_퀴즈

------------------------------------------------------------------------------
-- 1. CUSTOMERDATA와 CUSTOMER_NAME테이블을 키를 설정하지 않고 조인해보세요. 
--    (카티션곱) 해당 조인에 참여하는 모든 대상행을 다 출력
------------------------------------------------------------------------------
select * from customerdata;
select * from customer_name;

select A.*,B.*
    from customerdata A
    ,customer_name B;
 

-- 카티션곱  
select A.*,B.*
    from customerdata A
    ,customer_name B
    ORDER BY TO_CHAR(A.CUSTID);    
    
    
------------------------------------------------------------------------------
-- 2. Toad 단축키 
--  주석처리 (ctrl+b) 주석해제(ctrl+shift+b)
--  히스토리 보기 : F8
--  컬럼명 표시 : 테이블별치 . +CTRL or CTRL+T
--  SQL 실행: CTRL + ENTER
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- 3. 다음 중 오라클에서 실행시켰을때 서로 다른결과를 산출하는 결과는?
-- (상단은 ORACLE 하단은 ANSI(미국산업표준임) 답 :(4)!!!!
------------------------------------------------------------------------------

--(1) 전체 경우의 수 조인
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B;

SELECT A.*,B.*
FROM CUSTOMERDATA A
CROSS JOIN CUSTOMER_NAME B; 

--(2) INNER 조인
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

--(3)LEFT 조인
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


--(4)FULL OUTER 조인(FULL OUTER 조인은 직접 명시를 해야함)
-- 틀린것
SELECT A.*,B.*
FROM CUSTOMERDATA A
,CUSTOMER_NAME B
WHERE 1=1
AND A.CUSTID(+) = B.CUSTID(+);

-- 맞는 것
SELECT A.*,B.*
FROM CUSTOMERDATA A
FULL OUTER JOIN CUSTOMER_NAME B
ON 1=1
AND TO_CHAR(A.CUSTID) = B.CUSTID;  


--(5)RIGHT 조인
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
-- 4. CUST_MGT 테이블에서 custid 와 mgrid를 키로 조인을 수행해보세요
------------------------------------------------------------------------------
 
select * from cust_mgt
where 1=1
and custid = mgrid;

SELECT A.*, B.* FROM
CUST_MGT A,
CUST_MGT B
WHERE 1=1
AND A.CUSTID = B.MGRID;
