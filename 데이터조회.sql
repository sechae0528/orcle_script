
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
