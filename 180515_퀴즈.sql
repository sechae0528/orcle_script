-- 예제 :  KOPO2 서버 내 "SORT_EXAMPLE" 테이블을 WEEK 별로 
-- --------오름차순정렬하고 쿼리문을 작성하세요


select * from sort_example order by to_number(week);

select * from sort_example order by lpad(week,2,'0');


select 
    lpad(week,2,'0') as week
    , qty
from sort_example
order by lpad(week,2,'0');


select 
    week
    , qty
    from sort_example
    order by to_number(week);
    
    
    
SELECT LENGTH('    STR    ') FROM DUAL;

SELECT TRIM(LENGTH('    STR    ')) FROM DUAL;