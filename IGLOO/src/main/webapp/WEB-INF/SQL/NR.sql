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
from tbl_faq_q A left join tbl_faq_a B
on A.q_no = B.fk_q_no
where fk_userid = 'leenr'
order by q_writeday desc;


select *
from tbl_faq_q;

insert into tbl_faq_q(q_no, fk_userid, q_title, fk_categoryno, q_content) values (SEQ_FAQ_Q.nextval, 'leenr', '지점이 전화를 안 받아요', 3, '이글루 홍대점 전화 왜 안 받나요ㅠㅠ?');
commit;
insert into tbl_faq_a(a_no, fk_q_no, a_content) values (seq_tbl_faq_a.nextval, 2, '안녕하세요? 저희 이글루에 관심 주셔서 감사드립니다. 확인 결과 이글루 홍대점은 현재 리뉴얼 중으로 5월 24일 이후부터 통화 연결이 가능합니다. 감사합니다.');
commit;

select *
from tbl_member;


create table tbl_faqlist -- 자주하는 질문 테이블(고정, 더 추가될 일 없음)
(faqno number,
f_category varchar2(50),
f_title varchar2(200),
f_content varchar2(1000),
constraint PK_tbl_faqlist_faqno primary key(faqno));

select faqno, f_category, f_title, f_content
from tbl_faqlist
where f_category = '제품';

create sequence seq_tbl_faqlist
    start with 1
    increment by 1
    nomaxvalue
    nominvalue
    nocycle
    nocache;

insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '와플콘 전용매장은 무엇인가요?', '배스킨라빈스는 고객님들께 참신한 미식경험을 선사히기 위해, 프리미엄 직제조 와플콘 전용매장을 운영중에 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '벨지안 와플콘이 무엇인가요?', '진한 버터 풍미와 브라운 슈가 시럽의 달콤함까지 더해져 아이스크림과 완벽한 맛의 조화를 이루는 벨기에 리에주(Liege) 지역의 정통 스타일 와플 맛을 그대로 구현한 와플콘입니다.<br>매일 매장에서 갓 구운 고소한 와플과 아이스크림을 함께 즐겨보세요.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '맛보기 서비스', '아이스크림 구매 선택에 도움을 드리고자 고객 요청 시 맛보기 스푼이 제공되며,<br>인당 최대 3회까지 서비스 가능합니다. (진열 Tub 제품에 한함)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '이글루에 가면 30가지 아이스크림이 있나요?', '이글루의 의미는, 한 달 내내 매일 새로운 아이스크림을 즐길 수 있다는 의미입니다.<br>점포를 방문하시면 24~32종류의 다양한 아이스크림을 맛볼 수 있으며, 매월 새로운 flavor를 제공해 드리기 위해 오늘도 열심히 제품 개발에 힘쓰고 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림의 사이즈 별 중량은 어떻게 되나요?', '● 포장 가능한 제품 : 저울로 중량 측정 후 판매 (용기 포함 중량)<br>- 파인트 336g<br>- 쿼터 643g<br>- 패밀리 989g<br>- 하프갤론 1237g<br><br>● 포장불가 제품 : 스쿱으로 둥글게 떠서 제공<br>- 싱글레귤러 : 아이스크림 1 스쿱 / 115g<br>- 싱글킹: 아이스크림 1 스쿱 / 145g<br>- 더블주니어 : 아이스크림 2 스쿱 / 150g<br>- 더블레귤러: 아이스크림 2 스쿱 / 230g');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림의 포장 시간과 규정을 알 수 있을까요?', '드라이아이스(보냉제) 포장 기준 : 최대 30분 가능, 보냉백 (유상 500원) 구매 시 최대 1시간까지 가능합니다.<br><br>[포장 불가 제품]<br>- 싱글레귤러, 싱글킹, 더블주니어, 더블레귤러, 키즈토이컵<br><br>[포장 가능 제품]<br>- 핸드팩 · 기프트팩 · 레디팩 · 케이크류, 디저트류의 경우 9,000원 이상 구매시 포장 가능합니다.<br>- 쇼핑백은 유상판매 (200원) 되고 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림의 유통기한은 어떻게 되나요?', '아이스크림은 냉동 제품으로 유통기한이 없으나 배스킨라빈스는 신선한 제품 공급을 위해 자체적인 유통기한을 설정하여 관리하고 있습니다.<br>배스킨라빈스 제품의 유통기한은 제조일로부터 1년입니다.<br>축산물의 표시기준 2007-23호에 의거 제조 연, 월을 표기 해야 하나 자사는 제조 연, 월, 일까지 표시하고 있으며,<br>생산이력 추적관리를 위해 생산 Lot 표시를 2005년부터 시행하고 있습니다.<br>제조 일자는 아이스크림 텁이나 아이스크림 케이크 상자를 통해 확인 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림이 녹았는데, 다시 얼려 먹어도 되나요?', '아이스크림을 더욱 부드럽게 만들기 위해 제조 시 공기를 넣어 급속냉동을 합니다.<br>한 번 녹은 아이스크림은 공기가 빠지기 때문에 부피가 줄고, 아이스크림 특유의 부드러움이 없어져 배스킨라빈스 제품 고유의 풍미를 즐기기는 어렵습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림을 냉동고에 오래 보관했는데 먹어도 괜찮은가요?', '배스킨라빈스 점포에서 아이스크림을 보관하는 온도는 영하 18℃ 이하입니다.<br>가정에서는 냉동실에 보관하여도 잦은 개폐로 온도 유지가 어려운 부분이 있습니다.<br>아이스크림이 변질되지는 않지만 녹았다 얼었다를 반복하면서 아이스크림 고유의 맛과 부드러움을 느낄 수 없으니 빠른 시일 내에 드시는 것이 좋습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림 색깔이 진해 보이는데 어떤 색소를 사용하나요?', '배스킨라빈스 아이스크림은 색상이 화려하고 다양하지만 100% 천연색소를 사용하고 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림 케이크의 보관은 어떻게 하나요?', '구매 시 포장된 드라이아이스를 제거하고, 냉동고에 보관하시면 됩니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림은 꼭 블루스푼으로 먹어야 하나요?', '네, 고객님. 가급적 점포에서 제공된 핑크스푼을 이용해서 드시는 것을 권해드립니다.<br><br>가정에서 사용하는 티스푼이나 도시락스푼을 이용할 경우 손잡이 뒷면이 파손되는 경우가 발생할 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '아이스크림 케이크에 꽂은 생일초를 제거할 때 은박지가 케이크 속에 남아있네요?', '네, 고객님.<br>아이스크림은 냉동제품으로 생일초를 꽂은 후 초를 제거할 때 케이크 속에 은박지가 남아있을 수 있으니<br>생일초의 은박지까지 완전히 제거된 것을 확인 후 드실 것을 권해드립니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '블루스푼은 무상 제공인가요?', '배스킨라빈스는 2022년 7월 15일 부터 일회용품 사용을 줄이고자, 아이스크림 제품별 스푼 최대 제공 수량을 정하게 되었습니다.<br>최대수량 외 추가 요청시 개당 50원 유상판매 됩니다. (단, 파손/하자 스푼은 무상 교환)<br><br>●핑크스푼 무상 교환 기준<br><br>-싱글레귤러, 싱글킹, 미니레디팩, 카페31 : 1개<br>-더블주니어, 더블레귤러 : 2개<br>-파인트, 레디팩 : 3개<br>-쿼터, 아빠왔다팩, 빙수 : 4개<br>-패밀리, 미니케이크 : 5개<br>-하프갤론, 버라이어티팩 : 6개');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '제품', '구매한 제품은 교환(환불)이 가능한가요?', '아이스크림, 케이크, 음료 등 제품 특성상 재판매가 어려워 교환(환불)이 불가합니다.<br>식품이 아닌 경우에도 개봉하거나 포장지 훼손, 오염 및 재판매가 불가한 경우 교환(환불)이 불가합니다.<br>다만, 품질 이상, 이물 혼입 등은 소비자분쟁해결기준에 따라 제품 교환 또는 구입가 환불이 가능합니다.');


insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '누적 포인트 확인은 어디서 가능한가요?', '1) 점포문의 : 해피포인트 가맹점에서 확인 가능 (배스킨라빈스, 던킨도너츠, 파리크라상, 파리바게뜨, 파스쿠찌, 타마티, 리나스, 빚은, 잠바주스, 사누끼보레 등)<br><br>2) 해피포인트 카드 홈페이지 : 로그인 → 나의 해피포인트 → 나의 포인트 조회 → 적립 사용 내역 확인<br><br>3) 해피포인트 카드 고객센터 080-320-1234 (본인 확인 후 상담 가능)<br><br>4) 해피포인트 카드 모바일앱');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 카드의 회원주소 변경 및 수정은 어떻게 하나요?', '① 해피포인트 카드 홈페이지 (http://www.happypointcard.com) 로그인 → 나의 해피포인트 → 개인정보 조회/수정<br><br>② 해피포인트 카드 고객센터 : 080-320-1234 본인 확인 후 변경');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 카드의 적립포인트가 구매금액의 5%가 되지 않습니다.', '1. 회원가입 시 추가기재 사항 중 적립금 기부에 동의하신 분들에 한해서 적립금의 10%를 공익사업에 기부하고 있습니다.<br><br>[ 적립금 기부 여부 변경 ]<br>① 해피포인트 카드 홈페이지 로그인 → 나의 해피포인트 → 나의 포인트 조회 → 기부 포인트<br>② 해피포인트 카드 고객센터 : 080-320-1234 본인확인 후 변경<br><br>2. 모바일교환권 사용, 제휴할인 및 이벤트 참여 시 0.1% 적립');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 카드 신규 발급 시 구매금액은 포인트 적립이 불가능한가요?', '해피포인트 카드 신규 발급 시 구매한 금액도 적립이 가능합니다.(1,000원 이상 구매시)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 카드 분실이나 마그네틱 손상 시 재발급은 어떻게 하나요?', '해피포인트 카드 홈페이지, 고객센터, 모바일 웹을 통해 재발급이 가능합니다. (모바일 APP은 불가)<br><br>① 해피포인트 카드 홈페이지 로그인 ▶마이페이지▶MY카드▶카드 재발급 신청<br><br>② 해피포인트 카드 고객센터 : 080-320-1234 - 본인 확인 후 재발급 가능');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '현금과 누적포인트를 동시에 사용할 수 있나요?', '적립된 포인트와 현금의 동시사용이 가능합니다. 예) 제품 8,000원 구매하고, 적립된 포인트가 5,000점인 경우 5,000포인트 사용 + 3,000원 현금(또는 기타 결재수단) 추가 지불 가능 (추가 지불 금액에 대해서는 포인트 적립이 가능합니다)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '상품권으로 제품 구매 시 해피포인트 적립이 되나요?', '① 지류상품권 일반결제 시 해피포인트 5%적립<br>② 모바일교환권 결제 시 해피포인트 0.1%적립<br>(상품권 자체를 구매 시 해피포인트 적립 불가)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '변경된 신규 약관에 의한 포인트 실효(소멸)는 언제 되는 것인가요?', '[해피포인트카드 약관]<br><br>적립된 포인트의 유효기간은 적립일로부터 36개월입니다. 적립된 포인트는 유효기간 내에 사용하지 않은 경우, 해당 소멸일자 영업종료시간에 자동 소멸됩니다. 단, 회원의 자격은 계속 유지됩니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 카드 발급은 어떻게 하나요?', '해피포인트 카드 모바일 애플리케이션을 통해 발급 (해피포인트 APP)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 카드가 여러 장인데 포인트는 어떻게 관리되나요?', '해피포인트 카드는 회원정보 기준으로 모든 포인트가 통합 관리됩니다. (회원으로 가입하시면 제휴카드, 모바일카드, 마그네틱카드 모두 자동으로 포인트 통합)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피쿠폰 사용 및 이벤트 참여 시에도 해피포인트 적립이 가능한가요?', '해피쿠폰 사용 및 이벤트 참여 시에는 해피포인트 0.1% 적립할 수 있습니다. (일부 할인쿠폰은 제외, 쿠폰 내 유의사항 참조)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 앱 또는 카드를 소지하지 않은 경우 적립이 가능한가요?', '카드를 소지하지 않은 경우 해피포인트 앱 또는 해피포인트 카드 발급 시 등록한 휴대전화 번호로 적립할 수 있습니다.<br>단, 해피포인트 카드에 등록된 휴대전화 번호가 없거나, 등록된 번호와 일치하지 않을 경우 적립이 불가 합니다.<br>해피포인트 카드 고객센터를 통해 본인 확인 후 전화번호 확인이 가능합니다.<br><br>[ 해피포인트 카드 고객센터 ]<br>- 수신자부담 전화 : 080-320-1234<br>- 상담시간 : 09:00~19:00 (월~금)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '해피포인트 앱 또는 카드는 어떻게 사용하나요?(적립 및 사용)', '해피포인트는 전국 6,000여 개의 해피포인트 가맹점(배스킨라빈스, 던킨도너츠, 파리크라상, 파리바게뜨 등)에서 1,000원 이상 구매 시 구매금액의 1~5% 적립할 수 있습니다.<br><br>적립된 해피포인트가 100점 이상 시 10점 단위로 사용 가능합니다. (10점 = 10원)<br><br>- 사용브랜드 : SPC 계열 해피포인트 가맹점 (배스킨라빈스, 던킨도너츠, 파리크라상, 파리바게뜨, 파스쿠찌, 라그릴리아, 리나스, 빚은, 잠바주스 등)<br><br>- 각종 제휴사 혜택은 해피포인트 홈페이지(제휴 ▶ 제휴사 서비스)에서 확인 가능<br><br>* 신용카드와 결합한 해피포인트 제휴카드(신용, 체크카드)<br>:포인트 적립 및 각 제휴카드 고유의 기능(카드 기능에 따라 결제 및 충전)이 포함됩니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '포인트', '재발급 신청 시 카드번호를 모르면 안 되나요?', '해피포인트 카드에 고객님의 정보가 등록된 경우 전화번호, 주민등록번호 등의 고객정보 확인 후 카드 재발급이 가능하며, 기존 포인트는 유지됩니다.<br>고객님의 정보가 등록되지 않은 경우 . 카드정보 확인이 불가하며 포인트 이관 또한 불가합니다.');


insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '[홈페이지 관련] 탈퇴 후 재가입은 가능한가요?', '신규가입과 동일하게 회원가입 절차를 통해 가능합니다.<br>배스킨라빈스 홈페이지 (http://www.baskinrobbins.co.kr/) 접속 후 JOIN ▶ 해피포인트 가입 클릭');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '[홈페이지 관련] 회원탈퇴는 어디서 하나요?', '배스킨라빈스 홈페이지 (http://www.baskinrobbins.co.kr/) 로그인하여,<br>MY PAGE 클릭 → 회원탈퇴 → 아이디, 비밀번호 등록 후 탈퇴 진행');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '홈페이지 회원으로 가입하면 어떤 이점이 있나요?', '등록된 메일주소를 통해 이벤트 및 신제품에 대한 정보를 정기적으로 받아 보실 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '할인이나 제휴 되는 카드는 없나요?', '저희 배스킨라빈스는 해피포인트 적립 카드가 있습니다.<br>구매 금액의 5%가 적립되고 전국의 배스킨라빈스 점포에서 사용 가능합니다. (일부 점포 제외)<br><br>사용 브랜드 : 배스킨라빈스, 던킨도너츠, 파리크라상, 파리바게뜨, 파스쿠찌, 타마티, 리나스, 빚은, 잠바주스, 등<br>해피포인트 가맹점에서 사용 (브랜드에 따라 2%~5% 적립 가능)<br><br>※기타 제휴할인 확인은 홈페이지 내 [EVENT] ->[진행중이벤트]에서 확인이 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '행사문자메시지를 받고 싶지 않은데 어떻게 해야 하나요?', '① 배스킨라빈스 홈페이지 (http://www.baskinrobbins.co.kr/) 로그인하여, MY PAGE 클릭 → 회원정보수정 → 수신 및 마케팅 활용 동의 → 동의/동의 안 함 설정<br><br>② 문자수신거부 신청 : 080-850-8231 ▶1번 (핸드폰으로만 수신 거부신청이 가능하며, 해피포인트 전 브랜드의 문자수신이 거부됩니다)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '해피포인트 앱은 어떻게 사용하나요? 다운로드 받나요?', '① 휴대폰 앱스토어 (APP STORE), 플레이스토어 (PLAY STORE)에서 ‘해피포인트 카드’ 검색하여 설치합니다.<br><br>② 해피포인트 카드 홈페이지와 동일한 아이디, 비밀번호로 로그인합니다. 해피마켓, 해피오더, 스마일페이 등의 편리한 서비스와 각종 이벤트 혜택을 경험할 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '회원', '쿠폰을 해피앱으로 받았는데, 어떻게 확인하나요?', '해피포인트 앱 열기 – 마이페이지 – MY 쿠폰');

insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '가격 인상 후 모바일 교환권 사용 시 해피포인트는 어떻게 적립되나요?', '가격 조정 이전 구매된 교환권은 사용 시 인상 전 교환권 가격(액면가)의 0.1%가 적립됩니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '가격 인상 후 단종된 제품의 모바일 교환권은 어떻게 사용하나요?', '단종 제품 모바일 교환권은 인상 전 판매가 기준 다른 제품으로 교환하여 구매 진행 가능합니다.<br>[예시] 찰떡콩떡 블라스트(Regular) – 단종 제품, 인상전 가격인 4,800원으로 제품 교환 가능');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모든 제품의 가격이 인상되었나요?', '아이스크림, 디저트, 아이스크림 음료류 가격만 인상되었으며 커피 및 아이스크림 케이크 제품은 변동되지 않습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권 합산 사용 가능한가요?', '정가에 구매한 교환권에 한해 최대 3개까지 합산 사용이 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '기존 모바일 교환권 사용은 어떻게 하나요?', '기존 모바일 교환권은 그대로 사용하실 수 있으며, 동일 제품에 대해서는 추가 금액 없이 교환 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '고객 불만처리 프로세스', '불편을 드려 죄송합니다.<br>불편한 사항이나 문의사항이 있으신 경우 전화나 홈페이지 1:1문의를 통해 접수해주시면 신속히 응대 해 드리도록 하겠습니다.<br><br>●고객 불만처리 프로세스<br>1.고객소리 접수 > 2.고객상담 > 3.현업부서 전달 > 4.원인규명 > 5.개선대책 > 6.개선 및 반영<br><br>●고객 불만 접수채널<br>1. 전화 및 인터넷, 점포 등 다양한 채널을 통해 접수<br>2. 통합시스템에 일괄 접수, 관할 부서 / 담당자에게 통보<br>3. 공정거래 위원회 고시 소비자분쟁 해결 기준에 의거하여 처리<br><br>●접수 전화 080-555-3131 ( 09:00~17:00 주말 · 공휴일 휴무 / 수신자부담)<br>●인터넷 http://www.igloo.co.kr');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '이글루 교육시스템에 대해 알고 싶어요.', '이글루를 운영하려면 2주간 진행되는 오픈 교육을 수료하셔야 가능하며, 점포 운영 중에도 정기적인 서비스, 위생, 제법, 기본소양 교육이 진행됩니다.<br>또한, 온라인 교육센터가 마련되어 시간과 공간에 제약을 받지 않고 언제든지 교육을 받을 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '이글루 상품권의 사용처와 교환방법은?', '1. 상품권은 현금과 동일하게 사용할 수 있으며, 이글루와 던킨도너츠 전 점포에서 사용 가능합니다.<br><br>2. 상품권은 현금과 교환되지 않습니다.<br><br>3. 권면금액의 80% 이상 사용한 경우 잔액에 대하여 현금으로 돌려받을 수 있습니다.<br><br>4. 상품권의 유효기간은 발행일로부터 5년입니다.<br><br>5. 상품권에 발행자의 기명날인이 없거나 고유번호가 훼손된 경우 사용이 불가합니다.<br><br>6. 상품권 사용 시 사용 금액에 한하여 해피포인트 적립이 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '미성년자도 아르바이트를 할 수 있나요?', '만 18세 미만인 연소자는 친권자 동의서와 연소자 증명서(가족관계증명서)가 있어야 근무할 수 있습니다.<br>또한 15세 미만(중학교에 재학 중인 18세 미만)은 원칙적으로 일을 할 수 없으며 고용노동부장관이 발급한 취직인허증을 발급 받은 경우에만 근무 할 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '점포 운영시간이 궁금합니다.', '이글루 점포운영시간은 10:00~23:00입니다.<br>마트, 백화점, 휴게소, 역사 등의 특수상권 점포 및 일부점포 운영시간이 상이합니다.<br><br>이글루 홈페이지에서 점포별 운영시간을 확인하실 수 있습니다.<br>(http://www.igloo.co.kr/)접속 후, DELIVERY/STORE ▶ 매장 찾기 클릭)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '직원 채용', '수시 채용으로 인원을 선발하고 있습니다. (점포의 경우 지점별 수시 채용 진행)<br>해당부서에 결원이나 충원 필요 시 홈페이지나 인터넷 구인광고 사이트에 광고를 통해 모집, 선발합니다. http://www.igloo.co.kr/ ▶ 홈페이지 하단 채용문의 클릭)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '점포 개설(창업) 문의를 하고 싶습니다.', '점포 개설문의는 지역별 전문담당자를 통해서 상담할 수 있습니다.<br>이글루 홈페이지에서 자세한 내용을 확인하실 수 있습니다.<br>(http://www.igloo.co.kr/ ▶ 홈페이지 하단 점포개설문의 ▶ 상담 안내)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '이벤트는 모든 매장에서 동일하게 진행되나요?', '이글루 진행하는 이벤트는 크게 2가지 형태로 주요 이벤트와 LSM(Local Store Marketing)가 있습니다.<br>주요 이벤트는 전국 매장에서 동일하게 진행되며 (일부 점포 제외 : 이벤트 미 진행 점포는 홈페이지에 별도 표기)<br>LSM은 지역 특성에 맞게 진행하는 마케팅 방법으로 일부(해당) 점포에서 진행됩니다.<br><br>주요 이벤트는 이글루 공식 홈페이지, 페이스북, 인스타그램 등을 통해 자세한 내용을 확인할 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '현금영수증 발행이 가능한가요?', '모바일교환권 또는 현금 결제 시 현금영수증카드, 전화번호, 사업자 번호 등으로 발급 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '영수증에 나와 있는 CCM 인증 기업은 무엇인가요?', 'CCM은 Consumer Centered Management의 약자로 소비자 중심경영을 의미합니다. 제품의 생산에서부터 마케팅, 물류, 판매 등의 모든 활동에 있어 소비자 중심경영을 실천하는 기업에 인증하는 제도입니다. (주관 : 공정거래위원회, 운영 : 한국소비자원) 이글루는 프랜차이즈 업계 최초로 CCM 인증을 받았으며 항상 소비자 중심경영 실천을 위해 노력하고 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권 사용은 어떻게 하나요?', '문자 또는 선물함에 저장된 모바일교환권 이미지를 점포 근무자에게 보여주세요.<br>승인 후 제품으로 교환해 드립니다.<br>※ 캡쳐 및 복사된 모바일교환권은 승인, 교환이 제한 될 수 있으니, 반드시 원본 모바일교환권을 제시해 주시기 바랍니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권 물품형과 금액형은 어떤 차이가 있죠?', '- 모바일교환권(물품형) : 교환할 제품이 기재되어 있으며, 해당 제품으로 교환 가능<br>- 모바일교환권(금액형) : 금액이 표기되어 있어 해당 금액만큼 제품 교환 가능 (잔액확인 및 잔액관리 가능여부는 발행처로 확인필요)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권으로 이벤트에 참여 가능한가요?', '- 모바일교환권으로 이벤트 참여가 가능합니다. 단, 할인하여 구매한 교환권이나 이벤트를 통해 증정받은 교환권의 경우 참여가 불가합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권 유효기간 연장은 어떻게 하나요?', '1. 선물함의 모바일교환권을 열어, 하단 [유효기간 연장] 버튼을 클릭<br>2. 모바일교환권 구매처로 연락하여 연장 진행<br>- 해피콘 : 1599-2799<br>- 기프티쇼 : 1588-6474<br>- 기프티콘 : 1800-0133<br>- 카카오톡 : 1544-2431<br>- 해피마켓 : 1577-8450');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권(물품형)으로 타제품 교환이 가능한가요?', '모바일교환권(물품형) 해당 제품이 없거나 단종일 경우에 타제품 교환이 가능합니다.<br>타 제품 교환 시 차액 환불이 되지 않으므로 기재된 금액만큼의 제품으로 교환하셔야 합니다.<br><br>타 제품 교환을 원하지 않는 경우 구매처를 통해 환불요청을 하시면 환불이 가능합니다.<br><br>[ 구매처별 고객센터 ]<br>- 해피콘 : 1599-2799<br>- 기프티쇼 : 1588-6474<br>- 기프티콘 : 1800-0133<br>- 카카오톡 : 1544-2431<br>- 해피마켓 : 1577-8450');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '이글루 상품권은 어떤 종류가 있고, 어떻게 구매할 수 있나요?', '1. 유선 구매<br><br>- 전 화 : 010-6472-1808<br><br>- 종 류 : 비알코리아 상품권 10,000원 / 5,000원권<br><br>- 사용처 : 이글루, 던킨도너츠 점포 (공항 및 특수점포 일부 제외)<br><br><br><br>2. 방문 상품권 구매<br><br>- 전 화 : 02-2276-6187<br><br>- 위 치 : 서울 서초구 남부순환로 2620 (양재동, 강남피타워) 11층<br><br>- 종 류 : SPC 통합 상품권 10,000원 / 5,000원권<br><br>- 사용처 : 이글루, 던킨도너츠, 파리바게뜨 외 (공항 및 특수점포 일부 제외)');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '상품권 유효기간은 얼마 동안인가요?', '상품권의 유효기간은 발행일로부터 5년입니다.<br><br>상품권 후면 하단에 발행일자를 확인하실 수 있습니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '모바일교환권으로 배달/픽업 예약주문도 가능한가요?', '해피오더 채널에서 배달/픽업 주문 후 모바일교환권 결제가 가능합니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '현금영수증 자진발급이 가능한가요?', '현금영수증 자진발급은 불가합니다.<br><br>국세청 홈페이지 www.nts.go.kr 또는 유선번호 126로 문의 부탁드립니다.');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '현점포 위치나 연락처는 어떻게 알 수 있나요?', '① 이글루 홈페이지 ▶ STORE ▶ 오프라인 매장찾기<br>② 포털사이트 ▶ 점포명 또는 지역 + 이글루 검색');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '', '');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '', '');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '', '');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '', '');
insert into tbl_faqlist(faqno, f_category, f_title, f_content) values(seq_tbl_faqlist.nextval, '기타', '', '');

select *
from tbl_faqlist;

delete from tbl_faqlist
where faqno between 41 and 43;

commit;
rollback;

select storeno, storename, storepage, storeimg, storeaddress, storetel, latitude, longitude
from tbl_store
where storename like '%부평%' or storeaddress like '%부평%';


select *
from tab;

desc tbl_faq_q;

select *
from tbl_faq_q;

delete from tbl_faq_q where q_no = 11;

commit;

select * from user_sequences;



