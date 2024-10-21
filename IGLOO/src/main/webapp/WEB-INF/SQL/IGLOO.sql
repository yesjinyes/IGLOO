---- **** MyMVC 다이내믹웹프로젝트 에서 작업한 것 **** ----

-- 오라클 계정 생성을 위해서는 SYS 또는 SYSTEM 으로 연결하여 작업을 해야 합니다. [SYS 시작] --
show user;
-- USER이(가) "SYS"입니다.

-- 오라클 계정 생성시 계정명 앞에 c## 붙이지 않고 생성하도록 하겠습니다.
alter session set "_ORACLE_SCRIPT"=true;
-- Session이(가) 변경되었습니다.

-- 오라클 계정명은 SEMI_ORAUSER1 이고 암호는 gclass 인 사용자 계정을 생성합니다.
create user SEMI_ORAUSER1 identified by gclass default tablespace users; 
-- User SEMI_ORAUSER1(가) 생성되었습니다.

-- 위에서 생성되어진 SEMI_ORAUSER1 이라는 오라클 일반사용자 계정에게 오라클 서버에 접속이 되어지고,
-- 테이블 생성 등등을 할 수 있도록 여러가지 권한을 부여해주겠습니다.
grant connect, resource, create view, unlimited tablespace to SEMI_ORAUSER1;
-- Grant을(를) 성공했습니다.

select * from all_users;

--------------------------------------------------------------------------------

show user;
-- USER이(가) "SEMI_ORAUSER1"입니다.

create table tbl_main_image
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_image primary key(imgno)
);
-- Table TBL_MAIN_IMAGE이(가) 생성되었습니다.

create sequence seq_main_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_MAIN_IMAGE이(가) 생성되었습니다.

insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, 'main_photo1.png');  
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, 'main_photo2.png'); 
-- insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '이미지파일명.png'); 

commit;

--------------------------------------------------------------------------------
create table tbl_member
(userid             varchar2(40)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,postcode           varchar2(5)              -- 우편번호
,address            varchar2(200)            -- 주소
,detailaddress      varchar2(200)            -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,gender             varchar2(1)              -- 성별   남자:1  / 여자:2
,birthday           varchar2(10)             -- 생년월일   
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,idle               number(1) default 0 not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중 
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_idle check( idle in(0,1) )
);
-- Table TBL_MEMBER이(가) 생성되었습니다.

select * from tab;

create table tbl_loginhistory
(historyno  number,
fk_userid   varchar2(40),
logindate   date,
clientip    varchar2(20),
constraint PK_tbl_loginhistory_historyno primary key(historyno),
constraint FK_tbl_loginhistory_fk_userid foreign key(fk_userid) references tbl_member(userid));



create table tbl_review
(reviewno   number,
fk_userid   varchar(40),
fk_ordercode varchar2(50),
reviewcontent varchar2(1000),
writeday date default sysdate,
constraint PK_tbl_review_reviewno primary key(reviewno),
constraint FK_tbl_review_fk_userid foreign key(fk_userid) references tbl_member(userid),
constraint FK_tbl_review_fk_ordercode foreign key(fk_ordercode) references tbl_order(ordercode));

create table tbl_order
(ordercode varchar2(50),
fk_userid varchar2(40),
totalprice number,
orderdate date default sysdate,
constraint PK_tbl_order_ordercode primary key(ordercode),
constraint FK_tbl_order_fk_userid foreign key(fk_userid) references tbl_member(userid));


create table tbl_product
(productcodeno varchar2(5),
productname varchar2(100),
productimg varchar2(100),
price number,
productdetail varchar2(1000),
constraint PK_tbl_product_productcodeno primary key(productcodeno));

create table tbl_selectlist
(selectno number,
fk_productcodeno varchar2(40),
fk_userid varchar2(40),
constraint PK_tbl_selectlist_selectno primary key(selectno),
constraint FK_fk_productcodeno foreign key(fk_productcodeno) references tbl_product(productcodeno),
constraint FK_tbl_selectlist_fk_userid foreign key(fk_userid) references tbl_member(userid));


create table tbl_taste
(tasteno number,
tastename varchar2(100),
tasteimg varchar2(100),
constraint PK_tbl_taste_tasteno primary key(tasteno));

create table tbl_tasteselect
(tasteselectno number,
fk_selectno number,
fk_tasteno number,
constraint PK_tasteselectno primary key(tasteselectno),
constraint FK_fk_selectno foreign key(fk_selectno) references tbl_selectlist(selectno),
constraint FK_fk_tasteno foreign key(fk_tasteno) references tbl_taste(tasteno));


create table tbl_cart
(cartno number,
fk_userid varchar2(40),
count number,
fk_selectno number,
constraint PK_tbl_cart_cartno primary key(cartno),
constraint FK_tbl_cart_fk_userid foreign key(fk_userid) references tbl_member(userid),
constraint FK_tbl_cart_fk_selectno foreign key(fk_selectno) references tbl_selectlist(selectno));

create table tbl_orderdetail
(orderdetailno number,
fk_ordercode varchar2(50),
ordercount number,
fk_selectno number,
orderprice number,
pickupstatus number(1),
pickuptime varchar2(100),
constraint PK_orderdetailno primary key(orderdetailno),
constraint FK_fk_ordercode foreign key(fk_ordercode) references tbl_order(ordercode),
constraint FK_fk_selectno_2 foreign key(fk_selectno) references tbl_selectlist(selectno),
constraint CK_pickupstatus check(pickupstatus in(1,2,3)));


create table tbl_store
(storeno number,
storename varchar2(50),
storepage varchar2(200),
storeimg varchar2(100),
storeaddress varchar2(500),
storetel varchar2(100),
latitude nvarchar2(100),
longitude nvarchar2(100),
constraint PK_tbl_store_storeno primary key(storeno));

/*
select *
from tbl_product;

insert into tbl_product(productcodeno, productname, productimg, price, productdetail, productimgbelow)
values('U', '테스트', 'pint.png', 8000,'3가지 맛 선택', 'pint_detail.png');

delete from tbl_product
where productcodeno in ('T','G','Y','U');

commit;

desc tbl_product;
*/



-------- **** 매장찾기(카카오지도) 테이블 생성하기 **** ----------
create table tbl_map 
(storeID       varchar2(20) not null   --  매장id
,storeName     varchar2(100) not null  --  매장명
,storeUrl      varchar2(200)            -- 매장 홈페이지(URL)주소
,storeImg      varchar2(200) not null   -- 매장소개 이미지파일명  
,storeAddress  varchar2(200) not null   -- 매장주소 및 매장전화번호
,lat           number not null          -- 위도
,lng           number not null          -- 경도 
,zindex        number not null          -- zindex 
,constraint PK_tbl_map primary key(storeID)
,constraint UQ_tbl_map_zindex unique(zindex)
);
-- Table TBL_MAP이(가) 생성되었습니다.

create sequence seq_tbl_map_zindex
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;
-- Sequence SEQ_TBL_MAP_ZINDEX이(가) 생성되었습니다.

insert into tbl_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store1','롯데백화점 본점','https://place.map.kakao.com/7858517','lotte02.png','서울 중구 을지로 30 (T)02-771-2500',37.56511284953554,126.98187860455485,1);

insert into tbl_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store2','신세계백화점 본점','https://place.map.kakao.com/7969138','shinsegae.png','서울 중구 소공로 63 (T)1588-1234',37.56091181255155,126.98098265772731,2);

insert into tbl_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store3','미래에셋센터원빌딩','https://place.map.kakao.com/13057692','miraeeset.png','서울 중구 을지로5길 26 (T)02-6030-0100',37.567386065415086,126.98512381778167,3);

insert into tbl_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store4','현대백화점신촌점','https://place.map.kakao.com/21695719','hyundai01.png','서울 서대문구 신촌로 83 현대백화점신촌점 (T)02-3145-2233',37.556005,126.935699,4);

insert into tbl_map(storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex)
values('store5','쌍용강북교육센터','https://place.map.kakao.com/16530319','sist01.jpg','서울 마포구 월드컵북로 21 풍성빌딩 2~4층 (T)02-336-8546',37.556583,126.919557,5);

commit; 

select storeID, storeName, storeUrl, storeImg, storeAddress, lat, lng, zindex
from tbl_map
order by zindex asc;


select * from user_tables;

select * from tbl_selectlist;

select * from tbl_cart;



