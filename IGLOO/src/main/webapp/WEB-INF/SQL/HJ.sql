-- === 테이블 확인 === --
select * from tab;

-- === 아이디 중복여부 확인 === --
select userid
from tbl_member
where userid = 'jjoung' ;

-- === 이메일 중복여부 확인 === --
select email
from tbl_member
where email = '암호화된 이메일';

-- === 회원가입 === --
insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday)
values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

-- === 테스트용 회원가입 --- ==
select *
from tbl_member;

-- delete from tbl_member where userid = 'jjoung';

commit;