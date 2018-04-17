-- Expression 이용하기
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