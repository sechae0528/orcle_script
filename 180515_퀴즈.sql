-- ���� :  KOPO2 ���� �� "SORT_EXAMPLE" ���̺��� WEEK ���� 
-- --------�������������ϰ� �������� �ۼ��ϼ���


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