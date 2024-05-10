package common.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Constructor;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FrontController
 */
@WebServlet(
	description = "사용자가 웹에서 *.ice 을 했을 경우 이 서블릿이 응답을 해주도록 한다.", 
	urlPatterns = { "*.ice" }, 
	initParams = { 
			@WebInitParam(name = "propertyConfig", value = "C:\\git\\IGLOO\\IGLOO\\src\\main\\webapp\\WEB-INF\\Command.properties", description = "*.ice 에 대한 클래스의 매핑파일")
})
public class FrontController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	private Map<String, Object> cmdMap = new HashMap<>();
	
	public void init(ServletConfig config) throws ServletException {
		
		FileInputStream fis = null;
		
		String props = config.getInitParameter("propertyConfig");
		
		try {
			
			fis = new FileInputStream(props);
			
			Properties pr = new Properties();
			
			pr.load(fis);	// Properties 클래스의 객체인 pr 에 로드
		
			Enumeration<Object> en = pr.keys();
			
			while(en.hasMoreElements()) {	// key 가 있으면
				
				String key = (String)en.nextElement();
				
				// System.out.println("~~~ 확인용 key => " + key);
				
				// System.out.println("~~~ 확인용 value => " + pr.getProperty(key));
				
				String className = pr.getProperty(key);
				
				if(className != null) {		// 공백이 있을 경우 대비
					
					className = className.trim();
					
					Class<?> cls = Class.forName(className);
					
					// 생성자를 만들 수 있는 객체
					Constructor<?> constrt = cls.getDeclaredConstructor();
					
					// 생성자 만들기
					Object obj = constrt.newInstance();	
					
					cmdMap.put(key, obj);	// url 을 key 로 해서 obj 를 넣어주기
					
				}	// end of if--------------
				
			}	// end of while(en.hasMoreElements())---------
			
		} catch (FileNotFoundException e) {
			System.out.println(">>> C:\\NCS\\workspace_jsp\\IGLOO\\src\\main\\webapp\\WEB-INF\\Command.properties 파일이 없습니다. <<<");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println(">>> 문자열로 명명되어진 클래스가 존재하지 않습니다. <<<");
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}	// end of try~catch--------------------
	}	// end of public void init(ServletConfig config) throws ServletException-----------

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// System.out.println("### 확인용 => 서블릿 FrontController 의 doGet 메소드가 실행됨.");
		
		String uri = request.getRequestURI();
		// System.out.println("~~~ 확인용 uri => " + uri);
		
		String key = uri.substring(request.getContextPath().length());
		
		// 다형성
		AbstractController action = (AbstractController) cmdMap.get(key);
		
		if(action == null) {
			System.out.println(">>> " + key + " 은 URI 패턴에 매핑된 클래스는 없습니다. <<<");
		}
		else {
			
			// InterCommand 인터페이스에서 만든 메소드
			try {
				action.execute(request, response);
				
				// set 해준 값들 get 하기
				boolean bool = action.isRedirect();	
				String viewPage = action.getViewPage();
				
				if(!bool) {		// false -> forward
					if(viewPage != null) {
						RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
						dispatcher.forward(request, response);
					}
				}
				else {		// true -> sendRedirect
					if(viewPage != null) {
						response.sendRedirect(viewPage);
					}
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}	// end of try~catch---------
		}
	}	// end of protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException---

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
