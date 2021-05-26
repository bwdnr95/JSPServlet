package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/*
서블릿 클래스 작성시
1. HttpServlet클래스를 상속한다.
2. 요청을 받을 doGet() 혹은 doPost() 메소드를 오버라이딩한다.
3. 2번의 메소드를 오버라이딩 시 요청을 받기 위한 request객체와 
	응답을 하기 위한 response객체가 매개변수로 정의된다.
*/
public class HelloServlet extends HttpServlet {

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		/*
		 request영역에 속성을 저장한다.
		 	:서블릿에서 request영역을 사용하기 위해 해당 메소드에는
		 	HttpServletRequest 타입의 매개변수가 있다. 사용자의 모든
		 	요청을 받을 수 있고, 또한 request내장객체의 모든 기능을
		 	사용할 수 있다.
		 */
		req.setAttribute("message", "Hello~Servlet..!!");
		/*
		 View에 해당하는 jsp페이지로 포워드한다. 그러면 request영역에 저장된 데이터가 공유되어 출력할 수 있다. 즉 서블릿은 영역을
		 이용해서 jsp쪽으로 데이터(객체)를 전달하게 된다.
		 */
		req.getRequestDispatcher("/13Servlet/HelloServlet.jsp").forward(req, resp);
	}
}
