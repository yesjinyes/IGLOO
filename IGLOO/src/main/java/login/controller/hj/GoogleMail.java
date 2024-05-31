package login.controller.hj;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class GoogleMail {

	public void send_certification_code(String userid, String recipient, String certification_code) throws Exception { 
	      
	      // 1. 정보를 담기 위한 객체
	       Properties prop = new Properties(); 
	       
	       
	       // 2. SMTP(Simple Mail Transfer Protocoal) 서버의 계정 설정
	          //    Google Gmail 과 연결할 경우 Gmail 의 email 주소를 지정 
	       prop.put("mail.smtp.user", "jjoungjjoung99@gmail.com"); 
	             
	      
	       // 3. SMTP 서버 정보 설정
	       //    Google Gmail 인 경우  smtp.gmail.com
	       prop.put("mail.smtp.host", "smtp.gmail.com");
	            
	       
	       prop.put("mail.smtp.port", "465");
	       prop.put("mail.smtp.starttls.enable", "true");
	       prop.put("mail.smtp.auth", "true");
	       prop.put("mail.smtp.debug", "true");
	       prop.put("mail.smtp.socketFactory.port", "465");
	       prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	       prop.put("mail.smtp.socketFactory.fallback", "false");
	       
	       prop.put("mail.smtp.ssl.enable", "true");
	       prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");
	       prop.put("mail.smtp.ssl.protocols", "TLSv1.2"); // MAC 에서도 이메일 보내기 가능하도록 한것임. 또한 만약에 SMTP 서버를 google 대신 naver 를 사용하려면 이것을 해주어야 함.
	         
	      
	        // 혹시나 465 포트에 연결할 수 없다는 에러메시지가 나오면 아래의 3개를 넣어주면 해결된다.
	       	prop.put("mail.smtp.starttls.enable", "true");
	        prop.put("mail.smtp.starttls.required", "true");
	        prop.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    
	       
	       Authenticator smtpAuth = new MySMTPAuthenticator();
	       Session ses = Session.getInstance(prop, smtpAuth);
	          
	       // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
	       ses.setDebug(true);
	               
	       // 메일의 내용을 담기 위한 객체생성
	       MimeMessage msg = new MimeMessage(ses);

	       // 제목 설정
	       String subject = "IGLOO 비밀번호를 찾기 인증코드 발송";
	       msg.setSubject(subject);
	               
	       // 보내는 사람의 메일주소
	       String sender = "jjoungjjoung99@gmail.com";
	       Address fromAddr = new InternetAddress(sender);
	       msg.setFrom(fromAddr);
	               
	       // 받는 사람의 메일주소
	       Address toAddr = new InternetAddress(recipient);
	       msg.addRecipient(Message.RecipientType.TO, toAddr);
	               
	       String content = "";
	       
	       content = "<div> "
	       		+ "            <table cellpadding='0' cellspacing='0' border='0' width='620' style='border:1px solid #dde1e5;background-color:#ffffff;'> "
	       		+ "                <tbody><tr><td style='padding-left:59px;'> "
	       		+ "                        <table cellpadding='0' cellspacing='0' border='0' style='width:500px;padding-top:60px;'> "
	       		+ "                            <tbody><tr><td><a href='http://localhost:9090/IGLOO' target='_blank' rel='noreferrer noopener'><img src='https://github.com/Lee-Narae/IGLOO/blob/main/IGLOO/src/main/webapp/images/igloo_logo.png?raw=true' width='200' height='50' border='0' alt='IGLOO' loading='lazy'></a></td></tr> "
	       		+ "                            <tr><td style='padding-top:25px;font:bold 32px;color:#17191d;letter-spacing: -1.5px;'>이글루 이메일 인증 안내</td></tr> "
	       		+ "                            <tr><td style='padding:20px 0 30px;font:14px;color:#4a4e57;letter-spacing: -0.7px;line-height: 1.71;'> "
	       		+ "                                    안녕하세요. <strong style='color:#17191d;word-break:break-all;word-wrap:break-word;'>"+ userid +"</strong> 고객님<br> "
	       		+ "                                    <strong style='color:#17191d;'>'비밀번호 찾기'</strong>를 위해 이메일 인증을 진행합니다.<br> "
	       		+ "                                    아래 발급된 이메일 인증번호를 복사하거나 직접 입력하여 인증을 완료해주세요.<br> "
	       		+ "                                </td></tr> "
	       		+ "                        </tbody></table> "
	       		+ "                        <table cellpadding='0' cellspacing='0' border='0' width='500' style='font-size:14px;color:#4a4e57;border-top:1px solid #dddddd;border-bottom:1px solid #dddddd;' summary='인증번호를 안내해드립니다.'> "
	       		+ "                            <tbody><tr><td style='width:95px;padding:19px 0 17px 10px;font:bold 14px;vertical-align: top;line-height: 1.71;letter-spacing: -0.7px;'>인증번호</td><td style='padding:17px 10px 17px 0;font:bold 16px;text-align:left;line-height: 1.71;letter-spacing: -0.7px;color:#0077ff;letter-spacing: 3.2px;'> "
	       		+ 									certification_code
	       		+ "                                </td></tr> "
	       		+ "                        </tbody></table> "
	       		+ "                         "
	       		+ "                <tr><td style='padding:24px 0;font:11px;text-align:left;background-color:#efeff1;color:#9fa1a7;text-align:center;line-height: 1.45;letter-spacing: -0.55px;'> "
	       		+ "                        <p style='margin:0;padding:0 0 10px;font:10px;'>본 메일은 발신전용 입니다. 궁금하신 사항은  <a href='http://localhost:9090/IGLOO/help/help.ice' target='_blank' style='text-decoration: underline;color:#0077ff;' rel='noreferrer noopener'>고객센터</a>로 문의해주세요.</p> "
	       		+ "                        <span><span>사&nbsp;업&nbsp;자&nbsp;&nbsp;등&nbsp;록&nbsp;&nbsp;번&nbsp;호</span> │ 303-81-09535</span> "
	       		+ "                        <br> "
	       		+ "			<span><span>정&nbsp;&nbsp;&nbsp;&nbsp;보</span> │ IGLOO(주) 대표이사 서영학</span> "
	       		+ "            <br> "
	       		+ "			<span><span>주&nbsp;&nbsp;&nbsp;&nbsp;소</span> │ 서울 마포구 월드컵북로 21 풍성빌딩 2, 3, 4층</span> "
	       		+ "            <br> "
	       		+ "			<span><span>T&nbsp;&nbsp;e&nbsp;&nbsp;l</span> │ 02-336-8546</span> "
	       		+ "            <br> "
	       		+ "                        Copyright&nbsp;&copy;&nbsp;IGLOO Korea Corporation All Rights Reserved. "
	       		+ "                    </td></tr> "
	       		+ "            </tbody></table> "
	       		+ "        </div>";
	       
	       // 메시지 본문의 내용과 형식, 캐릭터 셋 설정
	       msg.setContent(content, "text/html;charset=UTF-8");
	       // span 태그 대신 table 태그시 이쁘게 된다.        
	       
	       // 메일 발송하기
	       Transport.send(msg);
	       
	   }// end of public void send_certification_code(String recipient, String certification_code) throws Exception--------
	
}
