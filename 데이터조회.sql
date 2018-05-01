
-- SELECTION 행선택

select * from kopo_product_volume
where 1=1
and volume > 3000;


select * from kopo_product_volume
where 1=1
and yearweek >= 201601
and PRODUCTGROUP = 'ST0001';


-- 원하는 컬럼(열)만 가져오고 싶을 때,

SELECT PRODUCTGROUP from kopo_product_volume;


------------------------------------------------------
-- UNION 합집합 (컬럼정보가 같은 때만 합집합 가능)
-------------------------------------------------------

SELECT REGIONID, PRODUCTGROUP, YEARWEEK, VOLUME 
    FROM kopo_product_volume_A01
UNION
SELECT REGIONID, PRODUCTGROUP, YEARWEEK, VOLUME
    FROM kopo_product_volume_A02;
    
    
-- UNION ALL 은 중복제거를 하지 않음, 정렬이 안됨. 대신 쿼리속도가 빠름.

-- 'ctr + e ' 를 누르면 처리한 건수와 cost 수를 알 수 있음.
--  UNION 이 UNION ALL 보다 COST 사용량이 많은 것을 볼 수 있음.

SELECT * FROM KOPO_CHANNEL_RESULT_A01
UNION 
SELECT * FROM KOPO_CHANNEL_RESULT_A02;


SELECT REGIONID, PRODUCTGROUP, YEARWEEK, QTY 
    FROM KOPO_CHANNEL_RESULT_A01
UNION ALL
SELECT REGIONID, PRODUCTGROUP, YEARWEEK, QTY
    FROM KOPO_CHANNEL_RESULT_A02;
    
-- 사용자 테이블 목록 조회하기
--SELECT {컬럼 리스트} OR {*}
--FROM TABS;

--COLUMN = NUM_ROW : 테이블 내에 건수 확인 가능

-- 데이터 조회하기
--SELECT {컬럼 리스트} OR {*}
--FROM {테이블명}



---------------------------------------------------
-- Expression 이용하기
----------------------------------------------------
--SELECT
--   {Expression} AS {컬럼명},
--   REGIONID
--FROM {테이블명}

select * from kopo_product_volume;


---- Expression 표현법  (컬럼 || 컬럼) ( CONCAT도 사용가능)
---- 컬럼을 붙여서 한 컬럼에 나타낼 때 사용
SELECT 
    'D516' AS MEASUREID,
    3*4 AS TEMVALUE,
    REGIONID || '_' || PRODUCTGROUP || '_' || YEARWEEK AS KEY,
    CONCAT(REGIONID, PRODUCTGROUP) AS CON,
    -- CONCAT(REGIONID,CONCAT('_',PRODUCTGROUP)) AS CON2,  
    --CONCAT 사용시에는 컬럼2개까지만 가능 3개이상하려면 중첩해야한다.
    REGIONID,    
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME
  FROM kopo_product_volume;
  

-- EXPRESS 예제 : KOPO_PRODUCT_VOLUME 에서
-- Expression을 활용하여
--맨 앞에 MeasureID 이름의 컬럼으로 “KOPO_D510”
--값이 생성되도록 조회하세요

SELECT * FROM KOPO_PRODUCT_VOLUME;
  
SELECT
    'KOPO_D510' AS MEASUREID,
    REGIONID,
    PRODUCTGROUP,
    YEARWEEK,
    VOLUME,
    CAST(YEARWEEK AS NUMBER) * VOLUME AS TEST14
    FROM KOPO_PRODUCT_VOLUME;
   

----------------------------------------------------------
-- 중복된 값 제거하기(DISTINCT)
----------------------------------------------------------
--SELECT
--   DISTINCT {컬럼명}
--FROM {테이블명}

SELECT DISTINCT REGIONID, 
                PRODUCTGROUP,
                PRODUCT,
                YEARWEEK,
                YEAR,
                WEEK,
                QTY 
    FROM KOPO_CHANNEL_SEASONALITY;

-- DISTIONCT 예제
-- 상품군(PRODUCTGROUP)에 대한 DISTINCT 구현 후
--컬럼이름을 PRODUCT로 변경해보세요

SELECT DISTINCT PRODUCTGROUP AS PRODUCT
    FROM KOPO_PRODUCT_VOLUME;

-------------------------------------------------------------
-- 조건절(WHERE) 사용하기
-------------------------------------------------------------
-- SELECT {컬럼 리스트}
-- FROM {테이블명}
-- WHERE 조건절

-- 예제 : KOPO_PRODUCT_VOLUME 테이블에서
----------ST0002 상품의 201515, 201516년도 제품만 조회하세요
SELECT * FROM KOPO_PRODUCT_VOLUME
    WHERE 1=1
    AND PRODUCTGROUP = 'ST0002'
    AND (YEARWEEK = '201515'
        OR YEARWEEK = '201516');
    
SELECT * FROM KOPO_PRODUCT_VOLUME
    WHERE 1=1
    AND PRODUCTGROUP = 'ST0002'
    AND YEARWEEK IN ('201515', '201516');
    
    
    
-- 연산자 사용  
-------------------------------------------------------------    
     
-- 예제: KOPO_PROMOTION 테이블에서 조회를 통해
---------PMAP에 10%할인된 가격을 ROUND 처리하여 PMAP이라는 컬럼을 생성하세요
-- ROUND 함수 (나타낼 수, 반올림하여 나타낼 자릿수)
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
    


-- 예제 : KOPO_PROMOTION 테이블에서 PMAP/MAP_PRICE 비율을 구해서 PERCENT
----------컬럼을 생성하세요
-----CASE 와 END 는 꼭 같이 써야함!!!

--분모가 0일 때를 걸러줘야함
SELECT 
    CASE WHEN MAP_PRICE = 0
            THEN 1
       ELSE PMAP/MAP_PRICE END AS PERCENT
FROM KOPO_PROMOTION;

-- 이렇게도 사용가능 (WHEN을 여러번 써서)
SELECT 
    CASE WHEN MAP_PRICE = 0
            THEN 1
         WHEN MAP_PRICE = 1
            THEN 2
       ELSE PMAP/MAP_PRICE END AS PROMOTION_RATIO
FROM KOPO_PROMOTION;

-- 만약 분모가 NULL 이면 NVL() 사용
-- NVL(MAP_PRICE, 1) MAP_PRICE가 NULL 이면 1값을 넣어서 실행해라. 
SELECT 
    CASE WHEN MAP_PRICE = 0
            THEN 1
         WHEN MAP_PRICE = 1
            THEN 2
       ELSE PMAP/NVL(MAP_PRICE, 1) END AS PROMOTION_RATIO
FROM KOPO_PROMOTION;


-----연산자 리스트 중요한 것만
-------------------------------------------------------------
------BETWEEN a AND b : a와 b 사이에 있는 범위 값을 모두 검색(a, b 값 포함)
------IN (a,b,c) : A 이거나 B 이거나 C 인 조건을 검색
------LIKE : 특정 패턴을 가지고 있는 조건을 검색 
-------(예 > LIKE '%MST%' : MST란 단어가 있는 데이터는 모두 검색) 
------IS NULL/ IS NOT NULL : Null 값을 검색 / Null 이 아닌 값을 검색