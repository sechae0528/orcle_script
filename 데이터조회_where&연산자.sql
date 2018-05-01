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

