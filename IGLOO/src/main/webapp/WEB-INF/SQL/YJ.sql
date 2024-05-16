show user;

select * from tab;


SELECT * FROM USER_CONSTRAINTS;
select * from user_sequences;

-- tasteno 시퀀스 생성
create sequence seq_tasteno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



select *
from tbl_taste
order by tastno asc;

commit;

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


