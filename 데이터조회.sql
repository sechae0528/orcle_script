
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



-- UNION 합집합 (컬럼정보가 같은 때만 합집합 가능)

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
  
  