-- 데이터 조회 (문자함수편) --

-------------------------------------------------------------------------
-- 주요함수
-- LOWER/UPPER : 입력 값을 전부 대/소 문자로 변환  
--               예 >  LOWER(‘ABCD’) → abcd / UPPER(‘ABCD’) → ABCD

-- CONCAT : 두 문자열을 결합해서 출력. || 연산자와 동일
--               예 >  CONCAT(‘A’,’B’) -> AB

-- SUBSTR : 주어진 문자에서 특정 문자만 추출  
--               예 >  SUBSTR(‘ABC’,1,2) -> AB

-- LPAD/RPAD : 주어진 문자열에서 왼쪽으로 특정 문자를 채움
--               예 >  LPAD(‘love’,6,’*’) -> **love

-- LTRIM/RTRIM : 주어진 문자열에서 왼쪽에서 특정 문자를 지움  
--               예 >  LLTRIM(‘*love’,’*’) -> love

-- REPLACE : 주어진 문자열에서 A 를 E 로 치환함
--               예 >  REPLACE(‘AB’,’A’,’E’) -> EB
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 대/소문자 변경 (UPPER, LOWER)
--SELECT 
--   UPPER(컬럼명),
--   LOWER(컬럼명),
--FROM {테이블명}
-------------------------------------------------------------------------
SELECT 
    UPPER(PRODUCT) AS CASE1,
    LOWER(PRODUCT) AS CASE2
    FROM KOPO_CHANNEL_SEASONALITY_NEW;

-- 입력하는 값을 대/소문자 변경하기    
SELECT *
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND LOWER(REGIONID) = LOWER(&UI_INPUT1)
AND LOWER(PRODUCT) = LOWER(&UI_INPUT2);


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 컬럼 값 합치기 ( CONCAT, || )
--SELECT 
--   CONCAT(컬럼명1, 컬럼명2),
--   컬럼명1 || 컬럼명2
--FROM {테이블명}
-------------------------------------------------------------------------
SELECT 
    CONCAT(REGIONID,CONCAT('_',PRODUCT)) AS KEYCOL1,
    REGIONID||'_'||PRODUCT AS KEYCOL2
FROM KOPO_CHANNEL_SEASONALITY_NEW;


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 컬럼 값 추출하기
--SELECT 
--   SUBSTR(‘문자열’ OR 컬럼명, 시작인덱스, 종료인덱스)
--FROM {테이블명}
-------------------------------------------------------------------------
SELECT 
    PRODUCT,
    SUBSTR(PRODUCT,1,7)
FROM KOPO_CHANNEL_SEASONALITY_NEW;

SELECT substr('201642',1,4) FROM DUAL;
-- 2016 (1번째이상 4번째이하 조회)
SELECT substr('201642',5,6) FROM DUAL;
-- 42 (5번째이상 6번째이하 조회)

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 컬럼 값 채우기
--SELECT 
--   LPAD(컬럼명, 자릿수, ‘붙일문자‘)
--FROM {테이블명}
-------------------------------------------------------------------------
SELECT 
LPAD(PRODUCTGROUP, 10, '0')
FROM KOPO_CHANNEL_SEASONALITY_NEW;


SELECT lpad('UN42F6000', 13, '0') FROM DUAL;
-- 왼쪽에 0을 붙여서 13자리를 만들어라.
SELECT upper('asddxcDDDDDss') FROM DUAL;
--모든 문자를 대문자로 바꿔라.

-------------------------------------------------------------------------
-- 예제 : KOPO_CUSTOMERDATA에서 CUSTOMERCODE를 12자리로 조회하세요
----------단, 12자리가 안될경우 앞에 ‘*’로 채우세요
SELECT lpad(CUSTOMERCODE, 12, '*') FROM KOPO_CUSTOMERDATA;
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 컬럼 값 변경하기
--SELECT 
--   REPLACE(문자열 OR 컬럼명, ‘문자1‘,’문자2’)
--FROM {테이블명}
-------------------------------------------------------------------------
SELECT 
    REGIONID,
    REPLACE(REGIONID,'A','REGION')
FROM KOPO_CHANNEL_SEASONALITY_NEW;


-------------------------------------------------------------------------
-- 예제 : KOPO_CUSTOMERDATA의 고객코드는10자리이다
---------만약 10자리가 아니면 왼쪽에 0으로 채운다
---------이후 고객코드의 뒷 4자리는 암호화를 위해 * 처리를 해야합니다.

SELECT CUSTOMERCODE FROM KOPO_CUSTOMERDATA;


select * from KOPO_CUSTOMERDATA order by lpad(CUSTOMERCODE,10,'0');

select 
    lpad(CUSTOMERCODE,10,'0')
    from KOPO_CUSTOMERDATA;

SELECT substr(lpad(CUSTOMERCODE,10,'0'), -4) 
FROM KOPO_CUSTOMERDATA;

SELECT 
    REPLACE(lpad(CUSTOMERCODE,10,'0') ,substr(lpad(CUSTOMERCODE,10,'0'), -4),'****')
FROM KOPO_CUSTOMERDATA;

-- 최종 정답!! --
SELECT 
--10자리
LPAD(CUSTOMERCODE,10,'0'),
-- 뒷4자리
SUBSTR(LPAD(CUSTOMERCODE,10,'0'), -4),
REPLACE(LPAD(CUSTOMERCODE,10,'0') 
        ,substr(LPAD(CUSTOMERCODE,10,'0'), -4)
        ,'****')
FROM KOPO_CUSTOMERDATA;        