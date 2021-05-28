package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet {
	
	/*
	 서블릿의 수명주기 메소드 중 사용자의 요청을 받아서 get 혹은 post를
	 판단하여 분기하는 역할을 한다.
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idx = req.getParameter("idx");
		MVCBoardDAO dao = new MVCBoardDAO();
		dao.updateVisitCount(idx);//조회수증가
		MVCBoardDTO dto = dao.selectView(idx);//게시물조회
		dao.close();
		
		//내용에 대해서는 줄바꿈 처리를 한다. 엔터키를 <br>로 변경한다
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		req.setAttribute("dto", dto);
		req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
	}
}
