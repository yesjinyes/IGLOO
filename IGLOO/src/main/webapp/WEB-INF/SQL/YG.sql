desc tbl_product;

select *
from tbl_product;

insert into tbl_product(PRODUCTCODENO, PRODUCTNAME, PRODUCTIMG, PRICE, PRODUCTDETAIL, PRODUCTIMGBELOW)
values('T', '테스트', 'k5_1_20240527154608370309416948700.png', 123, 'qwe', '003_팀장_및_팀원이함_05_20240527154608370309419014000.png');

select *
from tbl_product;

insert into tbl_product(productcodeno, productname, productimg, productimgBelow, price, productdetail)
values('P', '파인트', 'pint.png', 'pint_detail.png', 8000, '3가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimg, productimgBelow, price, productdetail)
values('Q', '쿼터', 'quarter.png', 'quarter_detail.png', 10000, '4가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimg, productimgBelow, price, productdetail)
values('F', '패밀리', 'family.png', 'family_detail.png', 15000, '5가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimg, productimgBelow, price, productdetail)
values('H', '하프갤런', 'halfgallon.png', 'halfgallon_detail.png', 20000, '6가지 맛 선택');

commit;

delete from tbl_product
where PRODUCTCODENO = 'T';
delete from tbl_product
where PRODUCTCODENO = 'Q';
delete from tbl_product
where PRODUCTCODENO = 'F';
delete from tbl_product
where PRODUCTCODENO = 'Y';

select *
from tbl_product;

commit;

desc tbl_product;

desc tbl_selectlist;

select * from user_tables;

-- 제약조건 삭제
--- 다시 넣어줘야함
ALTER TABLE tbl_selectlist DROP CONSTRAINT FK_fk_productcodeno;


ALTER TABLE tbl_selectlist
ADD CONSTRAINT FK_fk_productcodeno
FOREIGN KEY(fk_productcodeno) REFERENCES tbl_product(productcodeno);

commit;

select *
from tbl_selectlist;




select * from user_CONSTRAINTS;

rollback;

commit;

desc tbl_product;
select *
from tbl_product;
