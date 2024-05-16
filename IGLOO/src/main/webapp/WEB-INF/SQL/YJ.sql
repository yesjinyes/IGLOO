show user;

select * from tab;

select * from user_sequences;

-- ▶ tbl_taste ◀
-- tasteno 시퀀스 생성
create sequence seq_tasteno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- tbl_taste 테이블 insert
select *
from tbl_taste
order by tastno asc;

insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '행복한 나라의 슈팅스타','행복한 나라의 슈팅스타.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '에스프레소 위드 크림','에스프레소 위드 크림.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '블루베리 잼','블루베리 잼.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '디노 사우루스 젤리','디노 사우루스 젤리.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '단짠우유','단짠우유.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '마스카포네 마카롱','마스카포네 마카롱.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '망고 탱탱고','망고 탱탱고.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '롤리롤리롤리팝','롤리롤리롤리팝.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '딸바보 아빠','딸바보 아빠.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '엄마는 초코볼','엄마는 초코볼.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '민초파','민초파.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '서울 치즈케이크','서울 치즈케이크.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '레인보우','레인보우.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '체리뿌셔죽일래','체리뿌셔죽일래.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '슈팅톡톡','슈팅톡톡.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '오레오레오','오레오레오.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '스트로베리','스트로베리.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '이글루요거트','이글루요거트.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '바람과 함께 날아가다','바람과 함께 날아가다.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '바달라','바달라.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '초코칩 초콜릿','초코칩 초콜릿.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '에코티','에코티.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '피스타치오','피스타치오.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '찰리와 초콜릿 공장','찰리와 초콜릿 공장.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '자메이카 아몬드 훠지','자메이카 아몬드 훠지.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '아몬드 뿜뿜','아몬드 뿜뿜.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '사과 민트','사과 민트.png');
insert into tbl_taste(tasteno, tastename, tasteimg) values(seq_tasteno.nextval, '쪼끄만한숲','쪼끄만한숲.png');

commit;


-- ▶ tbl_taste ◀
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
insert into tbl_product(productcodeno, productname, productimg, price, productdetail)
values('P', '파인트', 'pint.png', 8000, '3가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimg, price, productdetail)
values('Q', '쿼터', 'quarter.png', 10000, '4가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimg, price, productdetail)
values('F', '패밀리', 'family.png', 15000, '5가지 맛 선택');

insert into tbl_product(productcodeno, productname, productimg, price, productdetail)
values('H', '하프갤런', 'halfgallon.png', 20000, '6가지 맛 선택');

commit;


-- ▶ tbl_ingredient ◀ 
-- tbl_ingredient 생성
create table tbl_ingredient
(ingredientno number,
fk_tasteno number,
tasteexplain varchar2(1000),
oncesupply varchar2(10),
calory varchar2(10),
sugar varchar2(10),
protein varchar2(10),
fat varchar2(10),
natrium varchar2(10),
allergy varchar2(20),
constraint PK_tbl_ingredient_ingredientno primary key(ingredientno),
constraint FK_tbl_ingredient_fk_tasteno foreign key(fk_tasteno) references tbl_taste(tasteno));

-- seq_ingredientno 시퀀스 생성
create sequence seq_ingredientno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- tbl_ingredient 테이블 insert
insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 1, '딸기와 블루베리가 들어간 솜사탕 아이스크림에 톡톡 튀는 팝핑캔디로 입안 가득 즐거운 맛', '115', '276',	'32', '4', '9', '78', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 2, '바닐라 아이스크림과 함께 즐기는 부드러운 에스프레소 한 잔', '115', '205', '24', '5', '7', '73', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 3, '이탈리안 디저트 파나코타와 상큼한 블루베리의 부드러운 만남', '115', '226', '24', '4', '6', '65', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 4, '파인애플 & 그린 애플 아이스크림에 알록달록 공룡젤리가 콩콩!', '115', '162'	, '29', '3', '1', '18', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 5, '부드러운 우유 맛 아이스크림 속에 깊은 단 맛을 끌어내는 소금 아이스크림', '115', '227', '18', '4', '7', '307', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 6, '부드러운 마스카포네 아이스크림과 마카롱, 초콜릿의 달콤한 만남!', '115', '266', '23', '6', '8', '86', '우유, 대두, 계란, 땅콩');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 7, '부드럽고 상큼한 열대과일, 입 안 가득 진한 망고 향이 가득!', '115', '238', '27', '3', '6', '37', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 8, '바닐라향, 스트로베리, 블루베리 아이스크림에 색색의 롤리팝 캔디까지!', '115', '249', '23', '4', '8', '68', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 9, '두가지 딸기 아이스크림과 바닐라향 아이스크림에 봉봉 프레첼이 쏘옥~!', '115', '308', '26', '4', '14', '84', '우유, 대두, 밀');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 10, '밀크 초콜릿, 다크 초콜릿, 화이트 무스에 달콤 바삭한 초코볼이 더해진 아이스크림', '115', '296', '23', '5', '11', '114', '우유, 대두, 밀');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 11, '쿨한 당신의 선택! 상쾌한 민트향에 초코칩까지!', '115', '259', '23', '4', '9', '81', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 12, '부드럽게 즐기는 서울식 정통 치즈케이크 아이스크림', '115', '295', '23', '6',	 '10', '102', '우유, 대두, 밀');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 13, '상큼한 파인애플, 오렌지, 라즈베리가 만드는 일곱빛깔 무지개', '115', '162'	, '29',	'3', '1', '18', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 14, '체리과육이 탱글탱글 씹히는 체리 아이스크림', '115', '239', '28', '3', '7', '48', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 15, '블루베리 & 바닐라향에 입안에서 톡톡 터지는 캔디와 신나는 축제', '115', '260',	'27', '3', '7',	'65', '우유, 대두, 밀');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 16, '부드러운 바닐라향 아이스크림에, 달콤하고 진한 오레오 쿠키가 듬뿍!', '115', '228',	'18', '5', '8',	'127', '우유, 대두, 밀');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 17, '새콤상큼 딸기 과육이 듬뿍!', '115', '228', '24',	'3', '7', '69', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 18, '유산균이 살아 있는 오리지널 요거트 아이스크림', '115', '198', '26',	'5', '4', '67', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 19, '블루베리와 딸기로 상큼함을 더한 치즈케이크 한 조각', '115', '269', '25', '4', '8', '95', '우유, 대두, 밀, 계란');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 20, '부드럽고 깔끔한 바닐라 아이스크림', '115', '246', '21', '4', '8', '74', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 21, '초콜릿 칩이 들어있는 진한 초콜릿 아이스크림', '115', '318', '27', '5', '12', '96', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 22, '엄선된 녹차를 사용한 싱그러운 그린티 아이스크림', '115', '245', '20', '5', '8', '73', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 23, '피스타치오와 아몬드가 만나 고소함이 두 배!', '115', '302', '27', '7', '8', '72', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 24, '진하고 부드러운 정통 초콜릿 아이스크림', '115', '274', '24', '5', '8',	'85', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 25, '깊고 풍부한 자모카 아이스크림에 고소한 아몬드와 초콜릿 훠지 시럽이 들어있는 제품', '115', '273', '25', '5', '7', '82', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 26, '입안 가득 즐거운 초콜릿, 아몬드로 더욱 달콤하게!', '115', '312', '26', '5',	'8', '94', '우유, 대두');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 27, '상큼한 청사과와 시원한 민트향이 기분까지 상쾌하게', '115', '189'	, '22', '6', '3', '29', '우유');

insert into tbl_ingredient(ingredientno, fk_tasteno, tasteexplain, oncesupply, calory, sugar, protein, fat, natrium, allergy)
values(seq_ingredientno.nextval, 28, '그린티와 초콜릿, 초코볼과 쿠키가 만난 아이스크림', '115', '308', '22', '5',	'4', '52', '우유, 대두');

select *
from tbl_ingredient;

commit;

