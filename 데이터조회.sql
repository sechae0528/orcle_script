
-- SELECTION �༱��

select * from kopo_product_volume
where 1=1
and volume > 3000;


select * from kopo_product_volume
where 1=1
and yearweek >= 201601
and PRODUCTGROUP = 'ST0001';


-- ���ϴ� �÷�(��)�� �������� ���� ��,

SELECT PRODUCTGROUP from kopo_product_volume;



-- UNION ������ (�÷������� ���� ���� ������ ����)

SELECT REGIONID, PRODUCTGROUP, YEARWEEK VOLUME 
    FROM kopo_product_volume_A01
-- UNION ALL �� �ߺ����Ÿ� ���� ����, ������ �ȵ�.
UNION
SELECT REGIONID, PRODUCTGROUP, YEARWEEK VOLUME
    FROM kopo_product_volume_A02;
    
   