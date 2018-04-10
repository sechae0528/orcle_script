
-- 다시 실행취소를 하고 싶을 때 사용 (안전하게 하기 위해서)
start transaction

delete from member

-- rollback이 실행되지 않음x 완전히 수정상태로 하고 싶을 때 사용
commit
-- transaction 실행 후 다시 원상복귀하고 싶을때  사용
rollback