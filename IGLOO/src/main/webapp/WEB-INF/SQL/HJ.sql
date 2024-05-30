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

-- === 로그인을 위한 로그기록 생성 === --
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
SELECT cartno, O.fk_userid, productname, tastename, price, productimg, COUNT
FROM
(
    SELECT fk_userid, selectno, productname, tastename, price, productimg
    FROM
    (
        SELECT tasteselectno, fk_selectno, tastename
        FROM
        (
            SELECT tasteselectno, fk_selectno, fk_tasteno
            FROM tbl_tasteselect
        )
        JOIN
        (
            SELECT tasteno, tastename
            FROM tbl_taste
        )
        ON fk_tasteno = tasteno
    ) T
    JOIN
    (
        SELECT selectno, fk_productcodeno, productname, price, fk_userid, productimg
        FROM
        (
            SELECT selectno, fk_productcodeno, productname, price, fk_userid, productimg
            FROM
            (
                SELECT productcodeno, productname, price, productimg
                FROM tbl_product
            )
            JOIN
            (
                SELECT selectno, fk_productcodeno, fk_userid
                FROM tbl_selectlist
            )
            ON productcodeno = fk_productcodeno
        )
        JOIN
        (
            SELECT userid
            FROM tbl_member
        )
        ON fk_userid = userid
    )
    ON fk_selectno = selectno
) O
    JOIN
(
    SELECT fk_userid, cartno, COUNT, fk_selectno
    FROM tbl_cart
)
ON fk_selectno = selectno
WHERE O.fk_userid = 'jjoung';

-- === 장바구니 insert === --
insert into tbl_cart(cartno, fk_userid, count, fk_selectno)
values(1,'jjoung', 1, 1);

commit;

----------------------------------------------
-- === 테스트 투!! === --
insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(2, 'P', 'jjoung');

insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(4, 2, 5);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(5, 2, 6);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(6, 2, 13);

insert into tbl_cart(cartno, fk_userid, count, fk_selectno) values(2,'jjoung', 1, 2);

commit;

----------------------------------------------------------------------------------------------
-- === 테스트 내용 지우기 === --
delete from tbl_tasteselect where fk_selectno = '1';
delete from tbl_tasteselect where fk_selectno = '2';
delete from tbl_cart where cartno = '1';
delete from tbl_cart where cartno = '2';
delete from tbl_selectlist where fk_productcodeno = 'P';
delete from tbl_order
commit;

-- === 시퀀스 생성(tbl_selectlist) === --
create sequence seq_selectno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SELECTNO이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_cart) === --
create sequence seq_cartno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CARTNO이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_tasteselect) === --
create sequence seq_tasteselectno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TASTESELECTNO이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_order) === --
create sequence seq_ordercode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- === 시퀀스 확인 === --
select * from user_sequences;

commit;
----------------------------------------------------------------
-- === 테스트 === --
insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(seq_selectno.nextval, 'P', 'jjoung');

insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 1, 5);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 1, 6);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 1, 13);

insert into tbl_cart(cartno, fk_userid, count, fk_selectno) values(seq_cartno.nextval,'jjoung', 1, 1);

commit;

-- 주문코드 형식: P-20240520-00000001 (컵코드+날짜(년월일)+"-"+시퀀스
-- 테스트용 -- 
-- insert into tbl_order(ordercode, fk_userid, totalprice) values ('P'||to_char(sysdate, 'yyyy-mm-dd')||'00000001' , 'leenr', 30000);

-- rollback;

insert into tbl_order(ordercode, fk_userid, totalprice) values('P' || '-' || to_char(sysdate, 'yyyymmdd') || '-' || lpad(seq_ordercode.nextval,6,'0'), 'jjoung', 8000);

commit;
-- delete from tbl_order where fk_userid = 'jjoung';

----------------------------------------------------------------------------

-- === 주문내역 출력 === --
SELECT ORDERDATE, PRODUCTIMG, PRODUCTNAME, TASTENAME, ORDERPRICE
     , ORDERDETAILNO, ORDERCODE, TOTALPRICE, PICKUPSTATUS, ORDERCOUNT, PICKUPTIME
FROM
(
    SELECT ORDERDATE, TOTALPRICE, A.FK_USERID, ORDERCODE, PRODUCTNAME, TASTENAME, PRODUCTIMG, ORDERDETAILNO, ORDERCOUNT, ORDERPRICE, PICKUPSTATUS, PICKUPTIME
    FROM
    (
        ------------------------------------------------------------
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
            (   SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
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
        ---------------------------------------
    ) A
    JOIN
    (
        select ORDERDETAILNO, ORDERCODE, FK_USERID, ORDERCOUNT, FK_SELECTNO, ORDERPRICE, PICKUPSTATUS, PICKUPTIME, TOTALPRICE, ORDERDATE
        from
        (
            SELECT ORDERCODE, FK_USERID, TOTALPRICE, ORDERDATE
            FROM TBL_ORDER
        )
        join
        (
            SELECT ORDERDETAILNO, FK_ORDERCODE, ORDERCOUNT, FK_SELECTNO, ORDERPRICE, PICKUPSTATUS, PICKUPTIME
            FROM TBL_ORDERDETAIL
        )
        on ORDERCODE = FK_ORDERCODE
    ) B
    ON A.FK_USERID = B.FK_USERID
)
where fk_userid = 'jjoung';

-- === 픽업상태(주문완료/준비중/픽업대기/픽업완료) 로 제약 변경 === --
alter table TBL_ORDERDETAIL
drop constraint CK_pickupstatus;
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

alter table TBL_ORDERDETAIL add constraint CK_pickupstatus check(pickupstatus in(1,2,3,4));
-- Table TBL_ORDERDETAIL이(가) 변경되었습니다.

commit;

-- === 제품검색, 맛검색 === --
SELECT ORDERDATE, PRODUCTIMG, PRODUCTNAME, TASTENAME
     , ORDERDETAILNO, ORDERCODE, TOTALPRICE, PICKUPSTATUS, ORDERCOUNT, PICKUPTIME, selectno
FROM
(
    SELECT A.FK_USERID, ORDERCODE, TOTALPRICE, ORDERDATE, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG, selectno
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
            (   SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
                FROM
                (
                    SELECT PRODUCTCODENO, PRODUCTNAME, PRICE, PRODUCTIMG
                    from tbl_product
                )
                RIGHT JOIN
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
    ) A
    JOIN
    (
        SELECT ORDERCODE, FK_USERID, TOTALPRICE, ORDERDATE
        FROM TBL_ORDER
    ) B
    ON A.FK_USERID = B.FK_USERID
)
JOIN
(
    SELECT ORDERDETAILNO, FK_ORDERCODE, ORDERCOUNT, FK_SELECTNO, ORDERPRICE, PICKUPSTATUS, PICKUPTIME
    FROM TBL_ORDERDETAIL
)
ON ORDERCODE = FK_ORDERCODE
where fk_userid = 'jjoung' and (PRODUCTNAME like '%' || '마' || '%' or TASTENAME like '%' || '마' || '%');


------------------------------------------------------------------------------------------

-- === 기간설정 검색 === --
SELECT ORDERDATE, PRODUCTIMG, PRODUCTNAME, TASTENAME
     , ORDERDETAILNO, ORDERCODE, TOTALPRICE, PICKUPSTATUS, ORDERCOUNT, PICKUPTIME
FROM
(
    SELECT A.FK_USERID, ORDERCODE, TOTALPRICE, ORDERDATE, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG
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
            (   SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
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
    ) A
    JOIN
    (
        SELECT ORDERCODE, FK_USERID, TOTALPRICE, ORDERDATE
        FROM TBL_ORDER
    ) B
    ON A.FK_USERID = B.FK_USERID
)
JOIN
(
    SELECT ORDERDETAILNO, FK_ORDERCODE, ORDERCOUNT, FK_SELECTNO, ORDERPRICE, PICKUPSTATUS, PICKUPTIME
    FROM TBL_ORDERDETAIL
)
ON ORDERCODE = FK_ORDERCODE
where fk_userid = 'jjoung' and ORDERDATE;

select *
from tbl_order
where fk_userid = 'jjoung' and ORDERDATE > '2024.05.10';

------------------------------------------------------------------------------------
insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(seq_selectno.nextval, 'P', 'jjoung');
commit;
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 10, 15);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 10, 6);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 10, 10);
commit;
insert into tbl_cart(cartno, fk_userid, count, fk_selectno) values(seq_cartno.nextval,'jjoung', 1, 10);
commit;
insert into tbl_order(ordercode, fk_userid, totalprice) values('P' || '-' || to_char(sysdate, 'yyyymmdd') || '-' || lpad(seq_ordercode.nextval,6,'0'), 'jjoung', 8000);
commit;

-----------------------------------------------------------------------------------------------

SELECT selectno
FROM
(
    SELECT A.FK_USERID, ORDERCODE, TOTALPRICE, ORDERDATE, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG, selectno
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
            (   SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
                FROM
                (
                    SELECT PRODUCTCODENO, PRODUCTNAME, PRICE, PRODUCTIMG
                    from tbl_product
                )
                RIGHT JOIN
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
    ) A
    JOIN
    (
        SELECT ORDERCODE, FK_USERID, TOTALPRICE, ORDERDATE
        FROM TBL_ORDER
    ) B
    ON A.FK_USERID = B.FK_USERID
)
JOIN
(
    SELECT ORDERDETAILNO, FK_ORDERCODE, ORDERCOUNT, FK_SELECTNO, ORDERPRICE, PICKUPSTATUS, PICKUPTIME
    FROM TBL_ORDERDETAIL
)
ON ORDERCODE = FK_ORDERCODE
where fk_userid = 'jjoung' and (PRODUCTNAME like '%' || '마' || '%' or TASTENAME like '%' || '마' || '%');


------------------------------------------------------

SELECT ORDERDATE, PRODUCTIMG, PRODUCTNAME, TASTENAME
     , ORDERDETAILNO, ORDERCODE, TOTALPRICE, PICKUPSTATUS, ORDERCOUNT, PICKUPTIME, selectno
FROM
(
    SELECT A.FK_USERID, ORDERCODE, TOTALPRICE, ORDERDATE, PRODUCTNAME, TASTENAME, PRICE, PRODUCTIMG, selectno
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
            (   SELECT selectno, fk_productcodeno, PRODUCTNAME, PRICE, FK_USERID, PRODUCTIMG
                FROM
                (
                    SELECT PRODUCTCODENO, PRODUCTNAME, PRICE, PRODUCTIMG
                    from tbl_product
                )
                RIGHT JOIN
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
    ) A
    JOIN
    (
        SELECT ORDERCODE, FK_USERID, TOTALPRICE, ORDERDATE
        FROM TBL_ORDER
    ) B
    ON A.FK_USERID = B.FK_USERID
)
JOIN
(
    SELECT ORDERDETAILNO, FK_ORDERCODE, ORDERCOUNT, FK_SELECTNO, ORDERPRICE, PICKUPSTATUS, PICKUPTIME
    FROM TBL_ORDERDETAIL
)
ON ORDERCODE = FK_ORDERCODE
where selectno in(1,3,3)
order by selectno desc;

-- === 시퀀스 확인 === --
select * from user_sequences;

insert into tbl_orderdetail(orderdetailno, fk_ordercode, ordercount, fk_selectno, orderprice, pickupstatus, pickuptime) 
values(SEQ_ORDERDETAILNO.nextval, 'P-20240522-000004', 1, 3, 8000, 1, sysdate);

select *
from tbl_orderdetail;

commit;

---------------------------------------------------------
--------------------------------------------------------
---------------------------------------------------------

-- === 테이블 내용 삭제 === --
delete from tbl_selectlist;
delete from tbl_tasteselect;
delete from tbl_cart;
delete from tbl_order;
delete from tbl_orderdetail;

commit;


-- === 시퀀스 삭제 하기 === --
drop sequence SEQ_CARTNO;
drop sequence SEQ_ORDERCODE;
drop sequence SEQ_ORDERDETAILNO;
drop sequence SEQ_SELECTNO;
drop sequence SEQ_TASTESELECTNO;

commit;

-------------------------- === 시퀀스 재생성 === ----------------------
-- === 시퀀스 생성(tbl_selectlist) === --
create sequence seq_selectno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_SELECTNO이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_cart) === --
create sequence seq_cartno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_CARTNO이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_tasteselect) === --
create sequence seq_tasteselectno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TASTESELECTNO이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_order) === --
create sequence seq_ordercode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ORDERCODE이(가) 생성되었습니다.

-- === 시퀀스 생성(tbl_orderdetail) === --
create sequence seq_orderdetailno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_ORDERDETAILNO이(가) 생성되었습니다


-- === insert 해주기(장바구니, 주문내역 확인용) === --
-- tbl_selectlist, tbl_tasteselect, tbl_cart, tbl_order, tbl_orderdetail

-- === 정보1 === --
insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(seq_selectno.nextval, 'P', 'jjoung');

insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 7, 5);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 7, 6);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 7, 13);
commit;
insert into tbl_cart(cartno, fk_userid, count, fk_selectno) values(seq_cartno.nextval,'jjoung', 1, 7);

insert into tbl_order(ordercode, fk_userid, totalprice) values('P' || '-' || to_char(sysdate, 'yyyymmdd') || '-' || lpad(seq_ordercode.nextval,6,'0'), 'jjoung', 8000);

commit;

insert into tbl_orderdetail(orderdetailno, fk_ordercode, ordercount, fk_selectno, orderprice)
values(seq_orderdetailno.nextval,'P-20240527-000005', 1, 7, 8000);

commit;

---------------------------------------------
-- === 정보2 === --
insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(seq_selectno.nextval, 'Q', 'jjoung');

commit;

insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 8, 10);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 8, 6);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 8, 15);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 8, 20);

insert into tbl_cart(cartno, fk_userid, count, fk_selectno) values(seq_cartno.nextval,'jjoung', 1, 8);

insert into tbl_order(ordercode, fk_userid, totalprice) values('Q' || '-' || to_char(sysdate, 'yyyymmdd') || '-' || lpad(seq_ordercode.nextval,6,'0'), 'jjoung', 10000);

commit;

insert into tbl_orderdetail(orderdetailno, fk_ordercode, ordercount, fk_selectno, orderprice)
values(seq_orderdetailno.nextval,'Q-20240527-000006', 1, 8, 8000);

commit;

-----------------------------------------------------------------------------------------------------

-- === 주문내역 === --
select SELECTNO, productname, tastename, orderdate, productimg, ORDERDETAILNO, ORDERCODE, TOTALPRICE
       , PICKUPSTATUS, ORDERCOUNT, PICKUPTIME
from TBL_TASTESELECT join tbl_taste on FK_TASTENO = TASTENO
    join TBL_SELECTLIST on FK_SELECTNO = SELECTNO
    join TBL_PRODUCT on FK_PRODUCTCODENO = PRODUCTCODENO
    join TBL_ORDER on TBL_SELECTLIST.FK_USERID =TBL_ORDER.FK_USERID
    join TBL_ORDERDETAIL on FK_ORDERCODE = ORDERCODE
where SELECTNO in (1,3)
order by SELECTNO desc;

---------------------------------

-- {(제품 - [선택내역) - 맛선택 - 맛] - 회원} - (주문 - 주문상세)
SELECT ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
FROM
(
SELECT fk_userid, ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
    FROM
    (
        SELECT fk_ordercode, fk_userid, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
        FROM
        (
            SELECT selectno, fk_userid, productname, productimg, tastename
            FROM 
            (
                SELECT productcodeno, productname, productimg
                FROM tbl_product
            )
            JOIN
            (
                SELECT selectno, fk_productcodeno, fk_userid, tastename
                FROM (
                    SELECT selectno, fk_productcodeno, fk_userid
                    FROM tbl_selectlist
                )
                JOIN
                (
                    SELECT fk_selectno, tastename
                    FROM 
                    (
                        SELECT fk_selectno, fk_tasteno
                        FROM tbl_tasteselect
                    )
                    JOIN
                    (
                        SELECT tasteno, tastename
                        FROM tbl_taste
                    )
                    ON fk_tasteno = tasteno
                )
                ON selectno = fk_selectno
            )
            ON productcodeno = fk_productcodeno
        )
        JOIN
        (
            SELECT fk_ordercode, orderprice, pickupstatus, pickuptime, ordercount, fk_selectno
            FROM tbl_orderdetail
        )
        ON selectno = fk_selectno
    )
    JOIN 
    (
        SELECT ordercode, orderdate
        FROM tbl_order
    )
    ON fk_ordercode = ordercode
)
JOIN
(
    SELECT userid
    FROM TBL_MEMBER
)
ON fk_userid = userid
WHERE userid = 'jjoung';


/*
    주문상세 - Fk_ordercode, Orderprice, Pickupstatus, Pickuptime, Ordercount
    oddto.setFk_ordercode(rs.getString("ORDERCODE"));
    oddto.setOrderprice(rs.getInt("ORDERPRICE"));
    oddto.setPickupstatus(rs.getInt("PICKUPSTATUS"));
    oddto.setPickuptime(rs.getString("PICKUPTIME"));
    oddto.setOrdercount(rs.getInt("ORDERCOUNT"));

    주문 - Orderdate
    odto.setOrderdate(rs.getString("ORDERDATE"));

    제품 - Productname, Productimg
    pdto.setProductname(rs.getString("productname"));
    pdto.setProductimg(rs.getString("productimg"));

    맛 - setTastename
    tdto.setTastename(rs.getString("tastename"));
 */

-----------------------------------------------------------
-- === finalselectlist === --
SELECT selectno, ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
FROM
(
SELECT selectno, fk_userid, ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
    FROM
    (
        SELECT selectno, fk_ordercode, fk_userid, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
        FROM
        (
            SELECT selectno, fk_userid, productname, productimg, tastename
            FROM
            (
                SELECT productcodeno, productname, productimg
                FROM tbl_product
            )
            JOIN
            (
                SELECT selectno, fk_productcodeno, fk_userid, tastename
                FROM (
                    SELECT selectno, fk_productcodeno, fk_userid
                    FROM tbl_selectlist
                )
                JOIN
                (
                    SELECT fk_selectno, tastename
                    FROM
                    (
                        SELECT fk_selectno, fk_tasteno
                        FROM tbl_tasteselect
                    )
                    JOIN
                    (
                        SELECT tasteno, tastename
                        FROM tbl_taste
                    )
                    ON fk_tasteno = tasteno
                )
                ON selectno = fk_selectno
            )
            ON productcodeno = fk_productcodeno
        )
        JOIN
        (
            SELECT fk_ordercode, orderprice, pickupstatus, pickuptime, ordercount, fk_selectno
            FROM tbl_orderdetail
        )
        ON selectno = fk_selectno
    )
    JOIN
    (
        SELECT ordercode, orderdate
        FROM tbl_order
    )
    ON fk_ordercode = ordercode
)
JOIN
(
    SELECT userid
    FROM TBL_MEMBER
)
ON fk_userid = userid
WHERE selectno in (1,2)
order by selectno desc;

-- selectno in( " + selecnoJoin + " )

----------------------------------------------------

-- selectno 찾기
SELECT selectno
FROM
(
SELECT selectno, fk_userid, ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
    FROM
    (
        SELECT selectno, fk_ordercode, fk_userid, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
        FROM
        (
            SELECT selectno, fk_userid, productname, productimg, tastename
            FROM
            (
                SELECT productcodeno, productname, productimg
                FROM tbl_product
            )
            JOIN
            (
                SELECT selectno, fk_productcodeno, fk_userid, tastename
                FROM (
                    SELECT selectno, fk_productcodeno, fk_userid
                    FROM tbl_selectlist
                )
                JOIN
                (
                    SELECT fk_selectno, tastename
                    FROM
                    (
                        SELECT fk_selectno, fk_tasteno
                        FROM tbl_tasteselect
                    )
                    JOIN
                    (
                        SELECT tasteno, tastename
                        FROM tbl_taste
                    )
                    ON fk_tasteno = tasteno
                )
                ON selectno = fk_selectno
            )
            ON productcodeno = fk_productcodeno
        )
        JOIN
        (
            SELECT fk_ordercode, orderprice, pickupstatus, pickuptime, ordercount, fk_selectno
            FROM tbl_orderdetail
        )
        ON selectno = fk_selectno
    )
    JOIN
    (
        SELECT ordercode, orderdate
        FROM tbl_order
    )
    ON fk_ordercode = ordercode
)
JOIN
(
    SELECT userid
    FROM TBL_MEMBER
)
ON fk_userid = userid
where fk_userid = 'jjoung' and (PRODUCTNAME like '%' || '아' || '%' or TASTENAME like '%' || '아' || '%');

-- === 기간설정 === --
SELECT ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
FROM
(
SELECT selectno, fk_userid, ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
    FROM
    (
        SELECT selectno, fk_ordercode, fk_userid, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename
        FROM
        (
            SELECT selectno, fk_userid, productname, productimg, tastename
            FROM
            (
                SELECT productcodeno, productname, productimg
                FROM tbl_product
            )
            JOIN
            (
                SELECT selectno, fk_productcodeno, fk_userid, tastename
                FROM (
                    SELECT selectno, fk_productcodeno, fk_userid
                    FROM tbl_selectlist
                )
                JOIN
                (
                    SELECT fk_selectno, tastename
                    FROM
                    (
                        SELECT fk_selectno, fk_tasteno
                        FROM tbl_tasteselect
                    )
                    JOIN
                    (
                        SELECT tasteno, tastename
                        FROM tbl_taste
                    )
                    ON fk_tasteno = tasteno
                )
                ON selectno = fk_selectno
            )
            ON productcodeno = fk_productcodeno
        )
        JOIN
        (
            SELECT fk_ordercode, orderprice, pickupstatus, pickuptime, ordercount, fk_selectno
            FROM tbl_orderdetail
        )
        ON selectno = fk_selectno
    )
    JOIN
    (
        SELECT ordercode, orderdate
        FROM tbl_order
    )
    ON fk_ordercode = ordercode
)
JOIN
(
    SELECT userid
    FROM TBL_MEMBER
)
ON fk_userid = userid
where fk_userid = 'jjoung' and ORDERDATE > '2000.05.20'
order by selectno desc ;

-----------------------------------------------------------------
select *
from tbl_cart;
-- === 장바구니 수량 수정 === --
update tbl_cart set count = 2
where fk_userid = 'jjoung' and cartno = 1;

rollback;

-- === 장바구니 추가 === --
insert into tbl_selectlist(selectno, fk_productcodeno, fk_userid) values(seq_selectno.nextval, 'Q', 'jjoung');

commit;

insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 5, 8);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 5, 1);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 5, 3);
insert into tbl_tasteselect(tasteselectno, fk_selectno, fk_tasteno) values(seq_tasteselectno.nextval, 5, 20);

insert into tbl_cart(cartno, fk_userid, count, fk_selectno) values(seq_cartno.nextval,'jjoung', 3, 5);

insert into tbl_order(ordercode, fk_userid, totalprice) values('Q' || '-' || to_char(sysdate, 'yyyymmdd') || '-' || lpad(seq_ordercode.nextval,6,'0'), 'jjoung', 10000);

commit;

insert into tbl_orderdetail(orderdetailno, fk_ordercode, ordercount, fk_selectno, orderprice)
values(seq_orderdetailno.nextval,'Q-20240526-000003', 3, 5, 10000);

commit;

select productimgbelow
from tbl_product

INSERT INTO tbl_product(productcodeno, productname, productimg, price, productdetail, productimgbelow)
values('I','이글루','igloo.png',12000,'이글루특품','igloo_photo_20240527015302868810751999300.png');

rollback;

-- === 장바구니 제거 === --
delete TBL_CART
where cartno = 3

rollback;

--------------------------------------
-- === 선택한 맛의 이름 === --
SELECT tastename, tasteno
FROM
(
    select tasteno, tastename
    from tbl_taste
)
JOIN
(
    select fk_tasteno
    from tbl_tasteselect
    where fk_selectno = '8'
)
ON tasteno = fk_tasteno;

-- === 기존 맛에 대한 선택내역번호 가져오기 === --
select tasteselectno
from tbl_tasteselect
where fk_selectno = '5'
order by tasteselectno;

-- === 맛수정 === --
update tbl_tasteselect set fk_tasteno = ? 
where fk_selectno = ? 

SELECT ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename 
 FROM 
 ( 
 SELECT selectno, fk_userid, ordercode, orderdate, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename 
    FROM 
    ( 
        SELECT selectno, fk_ordercode, fk_userid, orderprice, pickupstatus, pickuptime, ordercount, productname, productimg, tastename 
        FROM 
        ( 
            SELECT selectno, fk_userid, productname, productimg, tastename 
            FROM 
            ( 
                SELECT productcodeno, productname, productimg 
                FROM tbl_product 
            ) 
            JOIN 
            ( 
                SELECT selectno, fk_productcodeno, fk_userid, tastename 
                FROM ( 
                    SELECT selectno, fk_productcodeno, fk_userid 
                    FROM tbl_selectlist 
                ) 
                JOIN 
                ( 
                    SELECT fk_selectno, tastename 
                    FROM 
                    ( 
                        SELECT fk_selectno, fk_tasteno 
                        FROM tbl_tasteselect 
                    ) 
                    JOIN 
                    ( 
                        SELECT tasteno, tastename 
                        FROM tbl_taste 
                    ) 
                    ON fk_tasteno = tasteno 
                ) 
                ON selectno = fk_selectno 
            ) 
            ON productcodeno = fk_productcodeno 
        ) 
        JOIN 
        ( 
            SELECT fk_ordercode, orderprice, pickupstatus, pickuptime, ordercount, fk_selectno 
            FROM tbl_orderdetail 
        ) 
        ON selectno = fk_selectno 
    ) 
    JOIN 
    ( 
        SELECT ordercode, orderdate 
        FROM tbl_order 
    ) 
    ON fk_ordercode = ordercode 
) 
JOIN 
( 
    SELECT userid 
    FROM TBL_MEMBER 
) 
ON fk_userid = userid 
where fk_userid = 'jjoung' and ORDERDATE > ?
order by selectno desc ;