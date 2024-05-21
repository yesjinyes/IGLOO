
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


SELECT tasteno, tastename, tasteimg  
FROM
( 
select row_number() over(order by tasteno desc) AS RNO 
		,tastename, tasteimg 
from tbl_taste 
) V
WHERE RNO between 1 and 8 ;

 
alter table tbl_taste
add ingredients varchar2(13) not null;










