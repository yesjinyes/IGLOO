show user;

select * from tab;


select categoryno, categoryname
from tbl_faq_category;

select q_no, fk_userid, q_title, fk_categoryname, q_content, q_writeday
from tbl_faq_q;

SELECT *
FROM USER_CONSTRAINTS
where table_name = 'TBL_FAQ_Q';


alter table TBL_FAQ_Q
drop constraint FK_TBL_FAQ_Q_FK_CATEGORYNAME;

alter table tbl_faq_q
rename column fk_categoryname to fk_categoryno;

desc tbl_faq_q;

desc tbl_faq_category;

alter table tbl_faq_q
modify fk_categoryno number;

alter table tbl_faq_q
add constraint FK_tbl_faq_q_fk_categoryno foreign key(fk_categoryno) references tbl_faq_category(categoryno) on delete set null;

describe tbl_faq_q;

select *
from tbl_faq_category;

insert into tbl_faq_q(q_no, fk_userid, q_title, fk_categoryno, q_content) values (SEQ_FAQ_Q.nextval, 'leenr', '맛 품절 언제 풀리나요?', 1, '이글루 홍대점 서울 치즈 케이크 품절 언제 풀려요?');

commit;

create table tbl_faq_a
(a_no number,
 fk_q_no number,
 a_content varchar2(1000),
 a_writeday date default sysdate,
 constraint PK_tbl_faq_a_a_no primary key(a_no),
 constraint FK_tbl_faq_a_fk_q_no foreign key(fk_q_no) references tbl_faq_q(q_no) on delete cascade);

select q_no, fk_userid, q_title, fk_categoryno, q_content, to_char(q_writeday, 'yyyy-mm-dd HH24:mi:ss')
from tbl_faq_q;

create sequence seq_tbl_faq_a
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;
    
insert into tbl_faq_a(a_no, fk_q_no, a_content) values (seq_tbl_faq_a.nextval, 1, '안녕하세요? 저희 이글루에 관심 주셔서 감사드립니다.
지점의 제품 관련 문의는 지점 문의로 작성하셔야 합니다.
감사합니다.');
commit;


select q_no, q_title, fk_categoryno, q_content, to_char(q_writeday, 'yyyy-mm-dd HH24:mi:ss'), a_content, to_char(a_writeday, 'yyyy-mm-dd HH24:mi:ss')
from tbl_faq_q A join tbl_faq_a B
on A.q_no = B.fk_q_no
where fk_userid = 'leenr'
order by q_writeday desc;


select *
from tbl_faq_q;

insert into tbl_faq_q(q_no, fk_userid, q_title, fk_categoryno, q_content) values (SEQ_FAQ_Q.nextval, 'leenr', '지점이 전화를 안 받아요', 3, '이글루 홍대점 전화 왜 안 받나요ㅠㅠ?');
commit;
insert into tbl_faq_a(a_no, fk_q_no, a_content) values (seq_tbl_faq_a.nextval, 2, '안녕하세요? 저희 이글루에 관심 주셔서 감사드립니다. 확인 결과 이글루 홍대점은 현재 리뉴얼 중으로 5월 24일 이후부터 통화 연결이 가능합니다. 감사합니다.');
commit;
