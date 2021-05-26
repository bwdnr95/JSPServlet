package servlet;

import java.io.IOException;
import java.io.PrintWriter;

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
public class DirectServletPrint extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		/*
		 사용자의 요청을 처리한 후 View(jsp파일)없이 서블릿에서 직접
		 내용을 출력하고자 할때는 아래와 같이 컨텐츠 타입을 설정한 후 
		 PrintWriter객체를 통해 내용을 출력하면 된다.
		 */
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		
		writer.println("<html>");
		writer.println("<head><title>DirectServletPrint</title></head>");
		writer.println("<body>");
		writer.println("<h2>Servlet에서 직접 출력합니다.</h2>");
		writer.println("<p>jsp로 포워드 하지 않습니다.</p>");
		writer.println("</body>");
		writer.println("</html>");
		writer.close();
	}
}
