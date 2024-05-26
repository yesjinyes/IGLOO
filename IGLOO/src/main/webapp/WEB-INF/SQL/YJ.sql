show user;

select * from tab;

PURGE RECYCLEBIN;

select * from user_sequences;


-- ▶ tbl_store ◀
-- storeno 시퀀스 생성
create sequence seq_storeno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- tbl_store 테이블 insert
select *
from tbl_store;

insert into tbl_store(storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude)
values(seq_storeno.nextval, '이글루 부천점', 'www.igloo.bucheon.com', 'igloo_bucheon', '경기 부천시 원미구 석천로177번길 12', '031-111-1111', '37.50353', '126.7622');

insert into tbl_store(storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude)
values(seq_storeno.nextval, '이글루 부평점', 'www.igloo.bupyeong.com', 'igloo_bupyeong', '인천 부평구 경원대로1403번길 4', '032-222-2222', '37.49156', '126.7251');

insert into tbl_store(storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude)
values(seq_storeno.nextval, '이글루 별내점', 'www.igloo.byeollae.com', 'igloo_byeollae', '경기 구리시 산마루로 19 진영트윈타워주차장 A동', '031-333-3333', '37.63185', '127.1166');

insert into tbl_store(storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude)
values(seq_storeno.nextval, '이글루 홍대점', 'www.igloo.hongdae.com', 'igloo_hongdae', '서울 마포구 양화로6길 76 1층', '02-444-4444', '37.54837', '126.9182');

insert into tbl_store(storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude)
values(seq_storeno.nextval, '이글루 군포영학점', 'www.igloo.gunpoyh.com', 'igloo_gunpo', '경기 안양시 동안구 귀인로190번길 152 1층', '031-555-5555', '37.38410', '126.9612');

commit;



-- ▶ tbl_product ◀
-- tbl_product 테이블 insert
insert into tbl_product(productcodeno, productname, productimgTop, productimgBelow, price, productdetail)
values('P', '파인트', 'pint.png', 'pint_detail.png', 8000, '3가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimgTop, productimgBelow, price, productdetail)
values('Q', '쿼터', 'quarter.png', 'quarter_detail.png', 10000, '4가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimgTop, productimgBelow, price, productdetail)
values('F', '패밀리', 'family.png', 'family_detail.png', 15000, '5가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimgTop, productimgBelow, price, productdetail)
values('H', '하프갤런', 'halfgallon.png', 'halfgallon_detail.png', 20000, '6가지 맛 선택');

commit;



-- ▶ tbl_taste ◀
-- tasteno 시퀀스 생성
create sequence seq_tasteno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- tbl_taste 생성
create table tbl_taste
(tasteno number,
tastename varchar2(100),
tasteimg varchar2(100),
tasteexplain varchar2(1000), 
oncesupply varchar2(10), 
calory varchar2(10), 
sugar varchar2(10), 
protein varchar2(10), 
fat varchar2(10), 
natrium varchar2(10), 
allergy  varchar2(40),
constraint PK_tbl_taste_tasteno primary key(tasteno));


commit;
-- tbl_taste 테이블 insert
select *
from tbl_taste
order by tasteno asc;


delete from tbl_taste where tasteno = '30';

commit;
drop sequence seq_tasteno;

rollback;


-----------------------------------------------------------------------------------------------------
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'행복한 나라의 슈팅스타','행복한 나라의 슈팅스타.png', '딸기와 블루베리가 들어간 솜사탕 아이스크림에 톡톡 튀는 팝핑캔디로 입안 가득 즐거운 맛', '115','276','32','4','9','78','우유, 대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'에스프레소 위드 크림','에스프레소 위드 크림.png', '바닐라 아이스크림과 함께 즐기는 부드러운 에스프레소 한 잔', '115','205','24','5','7','73','우유, 대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'블루베리 잼','블루베리 잼.png', '이탈리안 디저트 파나코타와 상큼한 블루베리의 부드러운 만남', '115','226','24','4','6','65','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'디노 사우루스 젤리','디노 사우루스 젤리.png', '파인애플과 그린 애플 아이스크림에 알록달록 공룡젤리가 콩콩!', '115','162','29','3','1','18','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'단짠우유','단짠우유.png', '부드러운 우유 맛 아이스크림 속에 깊은 단 맛을 끌어내는 소금 아이스크림', '115','227','18','4','7','307','우유,대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(6,'마스카포네 마카롱','마스카포네 마카롱.png', '부드러운 마스카포네 아이스크림과 마카롱, 초콜릿의 달콤한 만남!', '115','266','23','6','8','86','우유,대두,계란,땅콩');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'망고 탱탱고','망고 탱탱고.png', '부드럽고 상큼한 열대과일, 입 안 가득 진한 망고 향이 가득!', '115','238','27','3','6','37','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'롤리롤리롤리팝','롤리롤리롤리팝.png', '바닐라향, 스트로베리, 블루베리 아이스크림에 색색의 롤리팝 캔디까지!', '115','249','23','4','8','68','우유,대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'딸바보 아빠','딸바보 아빠.png', '두가지 딸기 아이스크림과 바닐라향 아이스크림에 봉봉 프레첼이 쏘옥~!', '115','308','26','4','14','84','우유,대두,밀');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'엄마는 초코볼','엄마는 초코볼.png', '밀크 초콜릿, 다크 초콜릿, 화이트 무스에 달콤 바삭한 초코볼이 더해진 아이스크림', '115','296','23','5','11','114','우유,대두,밀');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'민초파','민초파.png', '쿨한 당신의 선택! 상쾌한 민트향에 초코칩까지!', '115','259','23','4','9','81','우유,대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'서울 치즈케이크','서울 치즈케이크.png', '부드럽게 즐기는 서울식 정통 치즈케이크 아이스크림', '115','295','23','6','10','102','우유,대두,밀');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'레인보우','레인보우.png', '상큼한 파인애플, 오렌지, 라즈베리가 만드는 일곱빛깔 무지개', '115','162','29','3','1','18','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'체리뿌셔죽일래','체리뿌셔죽일래.png', '체리과육이 탱글탱글 씹히는 체리 아이스크림', '115','239','28','3','7','48','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'슈팅톡톡','슈팅톡톡.png', '블루베리와 바닐라향에 입안에서 톡톡 터지는 캔디와 신나는 축제', '115','260','27','3','7','65','우유,대두,밀');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'오레오레오','오레오레오.png', '부드러운 바닐라향 아이스크림에, 달콤하고 진한 오레오 쿠키가 듬뿍!', '115','228','18','5','8','127','우유,대두,밀');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'스트로베리','스트로베리.png', '새콤상큼 딸기 과육이 듬뿍!', '115','228','24','3','7','69','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'이글루요거트','이글루요거트.png', '유산균이 살아 있는 오리지널 요거트 아이스크림', '115','198','26','5','4','67','우유,대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(19,'바람과 함께 날아가다','바람과 함께 날아가다.png', '블루베리와 딸기로 상큼함을 더한 치즈케이크 한 조각', '115','269','25','4','8','95','우유,대두,밀,계란');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'바달라','바달라.png', '부드럽고 깔끔한 바닐라 아이스크림', '115','246','21','4','8','74','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'초코칩 초콜릿','초코칩 초콜릿.png', '초콜릿 칩이 들어있는 진한 초콜릿 아이스크림', '115','318','27','5','12','96','우유,대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'에코티','에코티.png', '엄선된 녹차를 사용한 싱그러운 그린티 아이스크림', '115','245','20','5','8','73','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'피스타치오','피스타치오.png', '피스타치오와 아몬드가 만나 고소함이 두 배!', '115','302','27','7','8','72','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'찰리와 초콜릿 공장','찰리와 초콜릿 공장.png', '진하고 부드러운 정통 초콜릿 아이스크림', '115','274','24','5','8','85','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'자메이카 아몬드 훠지','자메이카 아몬드 훠지.png', '깊고 풍부한 자모카 아이스크림에 고소한 아몬드와 초콜릿 훠지 시럽이 들어있는 제품', '115','273','25','5','7','82','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'아몬드 뿜뿜','아몬드 뿜뿜.png', '입안 가득 즐거운 초콜릿, 아몬드로 더욱 달콤하게!', '115','312','26','5','8','94','우유,대두');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'사과 민트','사과 민트.png', '상큼한 청사과와 시원한 민트향이 기분까지 상쾌하게', '115','189','22','6','3','29','우유');
insert into tbl_taste(tasteno, tastename, tasteimg, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy) values(seq_tasteno.nextval,'쪼끄만한숲','쪼끄만한숲.png', '그린티와 초콜릿, 초코볼과 쿠키가 만난 아이스크림', '115','308','22','5','4','52','우유,대두');

select *
from tbl_taste;

commit;


---------------------------------------------------------------------------------------------------- 
-- ■■■ TEST ■■■ --
----------------------------------------------------------------------------------------------------
-- 제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명  

-- 컬럼 추가
ALTER TABLE [테이블명] ADD [컬럼명] [자료형]

-- 데이터 타입 변경
ALTER TABLE (테이블명) MODIFY (컬럼명) VARCHAR2(20);

-- 테이블 삭제
drop table 테이블명;

-- 테이블 데이터타입 조회
desc 테이블명;


----------------------------------------------------------------------------------------------------

select *
from tbl_product;

select * from user_sequences;

select productimgbelow
from tbl_product
where productcodeno = 'P';

commit;

drop table TBL_TASTE;
select * from user_constraints;

ALTER TABLE TBL_TASTESELECT ADD CONSTRAINT FK_FK_TASTENO FOREIGN KEY(fk_tasteno) REFERENCES tbl_taste(tasteno);

commit;
ALTER TABLE TBL_TASTE DROP CONSTRAINT PK_TBL_TASTE_TASTENO;

select *
from tbl_taste;

select productimgBelow
from tbl_product;

select *
from tbl_product;

select productimg, productimgBelow 
from tbl_product ;

select *
from tbl_member;

-------------------------------------------------------------------

select * from user_tables;

select *
from tbl_order;

select *
from tbl_orderdetail;

select * from user_sequences;

select *
from tbl_product;

select *
from tbl_order;

select productcodeno
from tbl_product;

desc tbl_order;
desc tbl_orderdetail;

select * from tbl_order;




insert into tbl_order(ordercode, fk_userid, totalprice) values('P' || '-' || to_char(sysdate, 'yyyymmdd') || '-' || lpad(seq_ordercode.nextval,6,'0'), 'yy6037', );









select *
from tbl_product
(
select *
from tbl_product
where productcodeno = 'P';
)P
JOIN tbl_orderdatail O
ON P.ordercode = O.fk_ordercode;









