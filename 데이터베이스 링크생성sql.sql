-- �����ͺ��̽� ��ũ����
-- �� �����ͺ��̽����� �ٸ� ������ �����ͺ��̽� �����ؼ� �����ϴ� ���
-- �������� oracle db�� �����ϱ� ���� ����

-- 1��. tnsname Ȱ��
CREATE DATABASE LINK ���ϰ� ���� �̸�
CONNECT TO kopo
IDENTIFIED BY kopo
Using 'POLY_SERVER';


-- 2��. ���� ȣ���� Ȱ��
CREATE DATABASE LINK server111
CONNECT TO kopo
IDENTIFIED BY kopo
Using '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 192.168.110.111)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )';
  

-- �ٸ��������� �����Ͱ������� ��� @�����̸�  
select * from kopo_product_volume@server111;

select * from tabs@server111;


-- ������ �����ͺ��̽� ��ũ Ȯ�ι��
SELECT * FROM ALL_DB_LINKS;

-- �����ͺ��̽� ��ũ �������
DROP DATABASE LINK ASUS_LINK;


