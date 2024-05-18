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

-- === 비밀번호 찾기 === --
select userid
from tbl_member
where status = 1 and userid = 'jjoung';

-- === 주문상세 테이블 === --
select *
from TBL_ORDERDETAIL;

-- === 맛선택 테이블 === --
select *
from tbl_tasteselect;

-- === 선택내역 테이블 === --
select *
from tbl_selectlist;

-- === 제품 테이블 === --
select *
from tbl_product;

-- === 맛 테이블 === --
select * 
from tbl_taste;

insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(1, 'P', 'jjoung');

insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(1, 1, 2);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(2, 1, 3);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(3, 1, 4);

commit;

-- === JOIN 사용하여 제품번호와 맛번호 불러오기 === --
SELECT selectno, fk_productcodeno, tasteselectno, FK_USERID
FROM
(
    select tasteselectno, fk_selectno, fk_tasteno
    from tbl_tasteselect
) T 
JOIN
(
    select selectno, fk_productcodeno, FK_USERID
    from
    (
        select selectno, fk_productcodeno, FK_USERID
        from tbl_selectlist
    )
    JOIN
    (
        select userid
        from TBL_MEMBER
    )
    ON FK_USERID = USERID
) O
ON fk_selectno = selectno
where fk_userid = 'jjoung';

-----------------------------------------------------------
-- === 장바구니 테이블 연결 이전 === --
SELECT FK_USERID, selectno, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG
FROM
(
    SELECT tasteselectno, fk_selectno, TASTENAME
    FROM
    (
        select tasteselectno, fk_selectno, fk_tasteno
        from tbl_tasteselect
     )
     JOIN
    (
        SELECT TASTENO, TASTENAME
        FROM TBL_TASTE
    )
    ON FK_TASTENO = TASTENO
) T
JOIN
(
    select selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
    from
    (
        SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
        FROM
        (
            SELECT PRODUCTCODENO, PRODUCTNAME, PRICE, PRODUCTIMG
            from tbl_product
        )
        JOIN
            (
            select selectno, fk_productcodeno, FK_USERID
             from tbl_selectlist
             )
        ON PRODUCTCODENO = FK_PRODUCTCODENO
    )
    JOIN
    (
        select userid
        from TBL_MEMBER
    )
    ON FK_USERID = USERID
) O
ON fk_selectno = selectno
where fk_userid = 'jjoung';

------------------------------------------------------------------------
-- === 장바구니 테이블 연결 === --
SELECT O.FK_USERID, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG, COUNT
FROM
(
    SELECT FK_USERID, selectno, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG
    FROM
    (
        SELECT tasteselectno, fk_selectno, TASTENAME
        FROM
        (
            select tasteselectno, fk_selectno, fk_tasteno
            from tbl_tasteselect
        )
        JOIN
        (
            SELECT TASTENO, TASTENAME
            FROM TBL_TASTE
        )
        ON FK_TASTENO = TASTENO
    ) T
    JOIN
    (
        select selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
        from
        (
            SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
            FROM
            (
                SELECT PRODUCTCODENO, PRODUCTNAME, PRICE, PRODUCTIMG
                from tbl_product
            )
            JOIN
            (
                select selectno, fk_productcodeno, FK_USERID
                from tbl_selectlist
            )
            ON PRODUCTCODENO = FK_PRODUCTCODENO
        )
        JOIN
        (
            select userid
            from TBL_MEMBER
        )
        ON FK_USERID = USERID
    )
    ON fk_selectno = selectno
) O
    JOIN
(
    SELECT FK_USERID, CARTNO, COUNT, FK_SELECTNO
    FROM TBL_CART
)
on FK_SELECTNO = SELECTNO
where O.fk_userid = 'jjoung';
