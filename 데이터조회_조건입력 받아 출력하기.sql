-- 데이터 조회하기 --

SELECT * FROM KOPO_PRODUCT_VOLUME;

--------------------------------------------------------------------------
-- 사용자 조건 입력받기
--SELECT
--   {컬럼 리스트}
--FROM KOPO_PRODUCT_VOLUME
--WHERE 컬럼명 = &colon
--------------------------------------------------------------------------
-- PRODUCT에 지정값을 넣어서 조회하기 --
SELECT
   REGIONID
   , PRODUCTGROUP
   , YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = &PRODUCT
OR YEARWEEK = '201544';

--- 예제 : KOPO_PROMOTION 테이블에서 STARTWEEK ENDWEEK 2개의
--- -------사용자 변수를 입력 받아 201501, 201503 사이 데이터를 조회하세요.

SELECT * from KOPO_PROMOTION;

SELECT REGIONID
   , ITEM
   , TARGETWEEK
   , PLANWEEK
   , MAP_PRICE
   , IR
   , PMAP
   , PRODUCT
FROM KOPO_PROMOTION
WHERE 1=1
AND TARGETWEEK BETWEEN &STARTWEEK AND &ENDWEEK;

---------------------------------------------------------------------------
-- 정렬하기
-- 기본 값은 오름차순
-- ASC[오름차순] / DESC [내림차순]
---------------------------------------------------------------------------
--SELECT
--   {컬럼 리스트}
--FROM KOPO_PRODUCT_VOLUME
--WHERE {조건절}
--ORDER BY {컬럼 리스트}

--실습예제
SELECT
   REGIONID, PRODUCTGROUP, YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
AND YEARWEEK BETWEEN 201501 AND 201503
ORDER BY YEARWEEK DESC;


SELECT * 
FROM KOPO_CUSTOMERDATA;

SELECT DISTINCT GENDER 
FROM KOPO_CUSTOMERDATA;

---------------------------------------------------------------------------
---문자를 넘버링해서 정렬하기 
-- NOT Available -> Male -> Female

SELECT A.*,
       CASE WHEN A.GENDER = 'Not Available'
            THEN 0
            WHEN A.GENDER = 'Male'
            THEN 1
            ELSE 2 END AS SORT_ORDER 
FROM KOPO_CUSTOMERDATA A
ORDER BY SORT_ORDER;


SELECT A.*,
        --LOWER (소문자 변환) UPPER (대문자 변환)
       CASE WHEN UPPER(A.GENDER) = 'NOT AVAILABLE'
            THEN 0
            WHEN LOWER(A.GENDER) = 'male'
            THEN 1
            ELSE 2 END AS SORT_ORDER 
FROM KOPO_CUSTOMERDATA A
ORDER BY SORT_ORDER;


-- 예제 : KOPO_PRODUCT_VOLUME 테이블에서 지역, 상품, 주차 
----------오름차순 형태로  조회되게 하세요

SELECT DISTINCT PRODUCTGROUP 
FROM KOPO_PRODUCT_VOLUME;

SELECT *
FROM KOPO_PRODUCT_VOLUME
ORDER BY REGIONID, PRODUCTGROUP, YEARWEEK;


---------------------------------------------------------------------------
-- 집합 연산자 (UNION, INTERSECT, MINUS)
-- { 테이블 #1}
-- UNION ALL / INTERSECT / MINUS
-- { 테이블 #2}
---------------------------------------------------------------------------
-- UNION (합집합) -- UNION 과 UNION ALL 의 차이는 ctrl + e 로 확인해보기
SELECT * 
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
UNION --ALL
SELECT * 
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0002';

---------------------------------------------------------------------------
-- INTERSECT (교집합)
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
INTERSECT
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0002';

---------------------------------------------------------------------------
-- MINUS (차집합)
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0001'
MINUS
SELECT YEARWEEK
FROM KOPO_PRODUCT_VOLUME
WHERE PRODUCTGROUP = 'ST0002';
 
-- NOT IN (차집합)
SELECT *
FROM KOPO_PRODUCT_VOLUME
WHERE 1=1
AND PRODUCTGROUP = 'ST0001'
AND YEARWEEK NOT IN ( SELECT DISTINCT YEARWEEK
                        FROM KOPO_CHANNEL_RESULT_NEW
                    )
ORDER BY YEARWEEK;
                        