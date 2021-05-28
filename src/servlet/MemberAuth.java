package servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MemberDAO;
import model.MemberDTO;

public class MemberAuth extends HttpServlet {
	
	//DAO객체를 멤버변수로 선언하여 모든 메소드에서 사용한다.
	MemberDAO dao;
	
	/*
	 서블릿 수명주기 메소드에서 서블릿 객체 생성시 최초로 한번만
	 호출되는 메소드로, 여기서는 db연결을 담당한다.
	 */
	@Override
	public void init() throws ServletException {
		ServletContext application = this.getServletContext();
		String driver = application.getInitParameter("JDBCDriver");
		String connectUrl = application.getInitParameter("ConnectionURL");
		
		dao = new MemberDAO(driver,connectUrl);
	
	}
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//서블릿 초기화 파라미터를 얻어온다
		String admin_id = this.getInitParameter("admin_id");
		
		//View에서 전송한 파라미터를 얻어온다.
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		//DAO의 메소드를 통해 회원인증처리를 한다.
		MemberDTO memberDTO = dao.getMemberDTO(id,pass);
		//인증 처리 후 회원의 이름을 저장한다.
		String memberName = memberDTO.getName();
		if(memberName!=null) {
			//member테이블에 존재하는 회원인 경우..
			req.setAttribute("authMessage", memberName+"회원님 반갑습니다.");
		}
		else {
			//member테이블에 존재하지 않는 경우
			if(admin_id.equals(id)) {//서블릿 초기화 파라미터에 있는 아이디면
				req.setAttribute("authMessage", admin_id+" 최고관리자 입니다.");
			}
			else {//정보가 전혀 없는 경우
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
			}
			req.getRequestDispatcher("/13Servlet/MemberAuth.jsp").forward(req, resp);
		}
	}
	@Override
	public void destroy() {
		System.out.println("destroy() 호출됨");
		dao.close();
	}
}
