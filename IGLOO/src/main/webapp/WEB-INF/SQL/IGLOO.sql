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


