
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

SELECT REGIONID, PRODUCTGROUP, YEARWEEK VOLUME 
    FROM kopo_product_volume_A01
-- UNION ALL 은 중복제거를 하지 않음, 정렬이 안됨.
UNION
SELECT REGIONID, PRODUCTGROUP, YEARWEEK VOLUME
    FROM kopo_product_volume_A02;
    
   