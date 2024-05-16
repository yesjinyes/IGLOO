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

-- === 로그인을 위한 로그기록 시퀀스 생성 === --
create sequence seq_historyno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_HISTORYNO이(가) 생성되었습니다.

-- === 로그인 === --
SELECT userid, name, pwdchangegap
    ,nvl(lastlogingap, registerday) as lastlogingap
    , idle, email, mobile, postcode, address, detailaddress, extraaddress
FROM
(
    select userid, name
    , trunc(months_between(sysdate, lastpwdchangedate)) as pwdchangegap
    , trunc(months_between(sysdate, registerday),0) as registerday
    , idle, email, mobile, postcode, address, detailaddress, extraaddress
    from tbl_member
    where status = 1 and userid = 'jjoung' and pwd = 'qwer1234$'
)M
CROSS JOIN
(
    select trunc(months_between(sysdate, max(logindate)),0) as lastlogingap
    from tbl_loginhistory
    where fk_userid = 'jjoung'
)H;

-- === 휴면처리 === --
update tbl_member set idle = 1
where userid = '휴면계정아이디';

-- === 휴면 아닌 회원만 로그기록 남기기 === --
insert into tbl_loginhistory(historyno, fk_userid, clientip)
values(seq_historyno.nextval, ?, ?);

-- === 회원 테이블 확인 === --
select *
from tbl_member;