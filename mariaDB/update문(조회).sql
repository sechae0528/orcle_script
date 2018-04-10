-------------------- <update문>(조회)----------------------------------------------


-- new 라는 테이블에 ctegory 칼럼 추가

alter table `news` add column `category` varchar(50)



-- no =1인 카테고리에 it라는 말 추가
update news set category = 'IT' where no = 1

update news set title = '아이폰 X 신규 출시' where no = 1


-- 1. member 테이블의 각 인원의 연차를 1년씩 증가
update member set year = year + 1

-- 2. member 테이블의 이천수 -> 이만수 개명
update member set name = '이만수' where name = '이철수'

-- 3. member 테이블의 이만수, 차범근 대리로 승진
update member set position = '대리' where name = '이만수' or name ='차범근'

-- 4. member 테이블의 지소연 차장으로 승진
update member set position = '차장' where name = '지소연'

-- 5. basicsalary 테이블의 부장, 차장 기본급 1500 상승
update basicsalary set salary = salary + 1500 where position = '부장' or position = '차장'

-- 6. basicsalary 테이블의 과장, 대리 사원 기본급 1000 상승
update basicsalary set salary = salary + 1000 where position = '과장' or position = '대리'or position = '사원'

-- 7. basicsalary 테이블의 직급을 사원 -> 주임으로 변경
update basicsalary set position = '주임' where position = '사원'