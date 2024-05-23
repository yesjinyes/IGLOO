
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
SELECT  tasteno, tastename, tasteimg , ingredients , count(*)
FROM
(
    select tasteno, tastename, tasteimg , ingredients, tasteselectno, fk_selectno
    from
    (
        select tasteselectno, fk_selectno, fk_tasteno
        from tbl_tasteselect
    )
    join
    (
        select row_number() over(order by tasteno desc) AS RNO 
                , tasteno ,tastename, tasteimg, ingredients
        from tbl_taste
    )
    ON fk_tasteno = tasteno
    
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
group by tasteno, tastename, tasteimg , ingredients
order by tastename;
--order by count(*) asc;



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


