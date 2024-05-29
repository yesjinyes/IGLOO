
show user;

create sequence seq_tbl_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

  
  
  
alter table tbl_order
add reviewstatus Number(1) default '0' not null;  --작성가능한리뷰(default 0), 작성한리뷰 (1)



alter table tbl_order
add constraint CK_tbl_order_reviewstatus check( reviewstatus in(0,1) );

select *
from tbl_order

commit;

select * from TBL_ORDER;
--  P-20240520-000003	jjoung	8000	24/05/20	0



select column from tab;

select * from TBL_REVIEW;
select * from TBL_PRODUCT;


select *
from tbl_product;


select *
from tbl_taste;


SELECT RNO, tastename, tasteimg, ingredients 
FROM
( 
select row_number() over(order by tasteno desc) AS RNO 
		,tastename, tasteimg ,ingredients
from tbl_taste 
) V
WHERE RNO between 1 and 8 ;

 
alter table tbl_taste
add ingredients varchar2(40); 
-- 맛테이블에 재료 컬럼 추가

alter table tbl_taste drop column ingredients;

-----------------
DESCRIBE tbl_taste;
DESCRIBE *;
-----------------


UPDATE tbl_taste
SET ingredients = '#딸기 #블루베리'
WHERE tasteno = 1;

UPDATE tbl_taste
SET ingredients = '#바닐라 #커피'
WHERE tasteno = 2;

UPDATE tbl_taste
SET ingredients = '#블루베리'
WHERE tasteno = 3;

UPDATE tbl_taste
SET ingredients = '#파인애플 #사과'
WHERE tasteno = 4;

UPDATE tbl_taste
SET ingredients = '#우유 #소금'
WHERE tasteno = 5;

UPDATE tbl_taste
SET ingredients = '#마카롱 #초콜릿'
WHERE tasteno = 6;

UPDATE tbl_taste
SET ingredients = '#망고'
WHERE tasteno = 7;

UPDATE tbl_taste
SET ingredients = '#스트로베리 #블루베리'
WHERE tasteno = 8;

UPDATE tbl_taste
SET ingredients = '#딸기 #프레첼'
WHERE tasteno = 9;

UPDATE tbl_taste
SET ingredients = '#초콜릿 #초코볼'
WHERE tasteno = 10;

UPDATE tbl_taste
SET ingredients = '#민트 #초콜릿'
WHERE tasteno = 11;

UPDATE tbl_taste
SET ingredients = '#치즈 #우유'
WHERE tasteno = 12;
----
commit;

-------주문된 맛의 개수 알아오기 -> 맛 개수로 인기순 정렬! 또는 가나다라 정렬!--------
-------------------------------------------------------------------------------

/*      
    TBL_ORDERDETAIL.ORDERDETAILNO  주문상세.주문상세일련번호 
    TBL_TASTE.TASTENO              맛.맛종류번호
    COUNT(*)                       맛별로 주문되어진 개수
*/

-------------------------------------------------------------------------------------------
------------------------------------------- 
 SELECT A.주문상세일련번호, D.맛종류번호
 FROM 주문상세 A
 JOIN 선택내역 B
 ON A.F선택일련번호 = B.선택일련번호
 JOIN 맛선택 C
 ON B.선택일련번호 = C.F선택일련번호
 JOIN 맛 D
 ON C.F맛종류번호 = D.맛종류번호;
 
 SELECT A.ORDERDETAILNO, D.TASTENO
 FROM TBL_ORDERDETAIL A
 JOIN TBL_SELECTLIST B
 ON A.FK_SELECTNO = B.SELECTNO
 JOIN TBL_TASTESELECT C
 ON B.SELECTNO = C.FK_SELECTNO
 JOIN TBL_TASTE D
 ON C.FK_TASTENO = D.TASTENO; 
 
 SELECT V.TASTENAME, COUNT(*) AS CNT
 FROM 
 (
     SELECT A.ORDERDETAILNO, D.TASTENAME
     FROM TBL_ORDERDETAIL A
     JOIN TBL_SELECTLIST B
     ON A.FK_SELECTNO = B.SELECTNO
     JOIN TBL_TASTESELECT C
     ON B.SELECTNO = C.FK_SELECTNO
     JOIN TBL_TASTE D
     ON C.FK_TASTENO = D.TASTENO
 ) V 
 GROUP BY V.TASTENAME;
 
 DESC TBL_TASTE;
 --------------------------------------------------
 SELECT TASTENAME, CNT AS ORDER_CNT
 FROM 
 (
     SELECT V.TASTENAME, COUNT(*) AS CNT
     FROM 
     (
         SELECT A.ORDERDETAILNO, D.TASTENAME
         FROM TBL_ORDERDETAIL A
         JOIN TBL_SELECTLIST B
         ON A.FK_SELECTNO = B.SELECTNO
         JOIN TBL_TASTESELECT C
         ON B.SELECTNO = C.FK_SELECTNO
         JOIN TBL_TASTE D
         ON C.FK_TASTENO = D.TASTENO
     ) V 
     GROUP BY V.TASTENAME
 ) T 
 ORDER BY T.TASTENAME ASC;
 ---------------------------------------------------------
 --===================================================================
     select rno, tastename, REVIEW_CNT 
    from
    (
    select row_number() over(order by REVIEW_CNT desc) as rno, REVIEW_CNT, tastename
    from
    (
     SELECT TASTENAME, CNT AS REVIEW_CNT
     FROM 
     (
         SELECT V.TASTENAME, COUNT(*) AS CNT
         FROM 
         (
             SELECT A.ORDERDETAILNO, D.TASTENAME
             FROM TBL_ORDERDETAIL A
             JOIN TBL_SELECTLIST B
             ON A.FK_SELECTNO = B.SELECTNO
             JOIN TBL_TASTESELECT C
             ON B.SELECTNO = C.FK_SELECTNO
             JOIN TBL_TASTE D
             ON C.FK_TASTENO = D.TASTENO
         ) V 
         GROUP BY V.TASTENAME
     ) T 
     ORDER BY REVIEW_CNT DESC
     )
     )
     WHERE RNO between 1 and 8; 
 --================================================================    
SELECT  rno, tasteno, tastename, tasteimg , ingredients
from
(
select row_number() over(order by tastename desc) as rno
        , tasteno , tastename, tasteimg, ingredients 
from tbl_taste
)V
WHERE rno between 1 and 8
       and tastename like '%'|| '행복' ||'%' ";
-------------------------------------------   
select rno, tastename, REVIEW_CNT 
    from
    (
        select row_number() over(order by REVIEW_CNT desc) as rno, REVIEW_CNT, tastename
        from
        (
         SELECT TASTENAME, CNT AS REVIEW_CNT
         FROM 
         (
             SELECT V.TASTENAME, COUNT(*) AS CNT
             FROM 
             (
                 SELECT A.ORDERDETAILNO, D.TASTENAME
                 FROM TBL_ORDERDETAIL A
                 JOIN TBL_SELECTLIST B
                 ON A.FK_SELECTNO = B.SELECTNO
                 JOIN TBL_TASTESELECT C
                 ON B.SELECTNO = C.FK_SELECTNO
                 JOIN TBL_TASTE D
                 ON C.FK_TASTENO = D.TASTENO
             ) V 
             GROUP BY V.TASTENAME
         ) T 
         ORDER BY REVIEW_CNT DESC
         )
     )
     WHERE RNO between 1 and 8; 
     
     ---
    ------▼정보, 8개자르기, 정렬 까지 완성 이지만 cnt가 0인 값은 안나옴▼------ 
SELECT tasteno ,tastename, tasteimg, ingredients, NVL(REVIEW_CNT, 0) AS REVIEW_CNT
FROM
(
    SELECT row_number() OVER(ORDER BY NVL(REVIEW_CNT, 0) desc ) AS rno, NVL(REVIEW_CNT, 0) AS REVIEW_CNT, tastename, tasteno, tasteimg, ingredients
    FROM --맨첨 정렬!!얘 중심으로 정렬됨
    (
        SELECT TASTENAME, CNT AS REVIEW_CNT, TASTENO, TASTEIMG, INGREDIENTS
        FROM
        (
            SELECT V.TASTENAME, COUNT(*) AS CNT, V.TASTENO, V.TASTEIMG, V.INGREDIENTS
            FROM
            (
                SELECT A.ORDERDETAILNO, D.TASTENAME, D.TASTENO, D.TASTEIMG, D.INGREDIENTS
                FROM TBL_ORDERDETAIL A
                JOIN TBL_SELECTLIST B
                ON A.FK_SELECTNO = B.SELECTNO
                JOIN TBL_TASTESELECT C
                ON B.SELECTNO = C.FK_SELECTNO
                JOIN TBL_TASTE D
                ON C.FK_TASTENO = D.TASTENO
            ) V
            GROUP BY V.TASTENAME, V.TASTENO, V.TASTEIMG, V.INGREDIENTS
        ) T
        --ORDER BY TASTENO desc --자르기 행 정렬 후의 정렬
    )
)
WHERE RNO BETWEEN 1 AND 8;

 ------▲정보, 8개자르기, 정렬 까지 완성이지만 cnt가 0인 값은 안나옴▲----- 
 SELECT tasteno, tastename, tasteimg, ingredients, NVL(REVIEW_CNT, 0) AS REVIEW_CNT
FROM
(
    SELECT ROW_NUMBER() OVER(ORDER BY NVL(REVIEW_CNT, 0) DESC) AS rno, NVL(REVIEW_CNT, 0) AS REVIEW_CNT, tastename, tasteno, tasteimg, ingredients
    FROM 
    (
        SELECT D.TASTENO, D.TASTENAME, D.TASTEIMG, D.INGREDIENTS, R.CNT AS REVIEW_CNT
        FROM TBL_TASTE D
        LEFT JOIN
        (
            SELECT V.TASTENO, COUNT(*) AS CNT
            FROM
            (
                SELECT A.ORDERDETAILNO, D.TASTENO
                FROM TBL_ORDERDETAIL A
                JOIN TBL_SELECTLIST B ON A.FK_SELECTNO = B.SELECTNO
                JOIN TBL_TASTESELECT C ON B.SELECTNO = C.FK_SELECTNO
                JOIN TBL_TASTE D ON C.FK_TASTENO = D.TASTENO
            ) V
            GROUP BY V.TASTENO
         ) R ON D.TASTENO = R.TASTENO
    ) T
)
WHERE rno BETWEEN 1 AND 16;
     --- ------▲정보, 8개자르기, 정렬 까지 완성▲----- 
--------------------------------------------------------------------------------------------

SELECT  tasteno, tastename, tasteimg , ingredients , count(*)
FROM
(
    select row_number() over(order by tastename asc) AS RNO, tasteno, tastename, tasteimg , ingredients, tasteselectno, fk_selectno
    from
    (
        select tasteselectno, fk_selectno, fk_tasteno
        from tbl_tasteselect
    ) A
    join
    (
        select tasteno ,tastename, tasteimg, ingredients
        from tbl_taste
    ) B 
    ON A.fk_tasteno = B.tasteno
    
) T 
JOIN
(
    select selectno, FK_USERID
    from
    (
        select selectno, FK_USERID
        from tbl_selectlist
    )
    JOIN
    (
        select fk_selectno, fk_ordercode, orderdetailno
        from tbl_orderdetail
    )
    ON fk_selectno = selectno
) O

ON fk_selectno = selectno
group by tasteno, tastename, tasteimg , ingredients;
--order by tastename;
--order by count(*) desc;



SELECT  tasteno, tastename, tasteimg , ingredients
FROM

(
    select row_number() over(order by tasteno desc) AS RNO 
                    , tasteno ,tastename, tasteimg, ingredients
    from tbl_taste
);
 

------


   select *
   from tbl_orderdetail;
   
 select column_name, comments
 from user_col_comments
 where table_name = 'tbl_orderdetail';
 
 
 
SELECT tasteno, tastename, tasteimg , ingredients 
					FROM 
					( 
				select row_number() over(order by tasteno desc) AS RNO 
							, tasteno ,tastename, tasteimg , ingredients 
						   from tbl_taste 
						) V 
						 WHERE RNO between 1 and 3 ;
                         
                         
   select *
   from tbl_review;
   
   select *
   from tbl_orderdetail;
   
   --- 주문된 제품, 아이스크림맛 조회해오기


----- 주문내역에 따른 제품, 맛 정보 조회하기
   select userid, orderdetailno, orderdate, productname, productimg, tastename, reviewstatus
   from tbl_member I
   join tbl_order A
   on I.userid = A.fk_userid 
   join tbl_orderdetail B
   on A.ordercode = B.fk_ordercode
   join tbl_selectlist C 
   on B.fk_selectno = C.selectno
   join tbl_tasteselect D
   on C.selectno = D.fk_selectno
   join tbl_product E
   on C.fk_productcodeno = E.productcodeno
   join tbl_taste F
   on D.fk_tasteno = F.tasteno
   where userid = 'jjoung'
   order by orderdetailno ;
   
   
   
   ----주문내역에따른 
   
   ---리뷰 update

   
   
   
