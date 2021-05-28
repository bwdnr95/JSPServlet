package servlet;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/13Servlet/LifeCycle.do")
public class LifeCycle extends HttpServlet {
	
	/*
	  서블릿 수명주기에서 최초로 호출되는 메소드로
	  어노테이션을 사용해야 한다. init()메소드가 호출되기
	  전에 전처리를 위해 호출된다.
	 */
	
	@PostConstruct
	public void myPostabc() {
		System.out.println(("myPostabc() 호출"));
	}
	/*
	 서블릿 객체 생성 후 딱 한번만 호출되는 메소드
	 일반적으로 서블릿을 초기화 하는 역할을 한다
	  */
	@Override
	public void init() throws ServletException {
		System.out.println(("init() 호출"));
	}
	/*
	 클라이언트의 요청을 처리하기 위해 호출된다. 전송방식에 상관없이
	 호출되며 get 혹은 post에 따라 doGet(), doPost를 호출하는
	 역할을 한다.
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		System.out.println("service() 호출");
		super.service(req, resp);
	}
	//Get방식 호출
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet() 호출");
		req.getRequestDispatcher("/13Servlet/LifeCycle.jsp").forward(req, resp);
		
	}
	//Post방식의 요청에 대한 처리를 한다.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doPost() 호출");
		req.getRequestDispatcher("/13Servlet/LifeCycle.jsp").forward(req, resp);
	}
	/*
	 서블릿이 새롭게 컴파일 되거나, 서버가 종료될 때 호출된다.
	 이때 서블릿 객체는 메모리에서 소멸된다.
	 */
	@Override
	public void destroy() {
		System.out.println("destory()호출");
	}
	/*
	 destroy()메소드가 실행된 후에 호출된다.
	 */
	@PreDestroy
	public void myPreDestroy() {
		System.out.println("myPreDestroy() 호출");
	}
}
