package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.BoardConfig;
import utils.BoardPage;

public class ListController extends HttpServlet { 
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//DAO객체 생성 (커넥션 풀 사용함)
		MVCBoardDAO dao = new MVCBoardDAO();
		Map<String, Object> map = new HashMap<String, Object>();

		//검색 파라미터 및 View로 전달할 여러가지 데이터 저장용 Map컬렉션 생성
		String searchField = req.getParameter("searchField");//검색할 필드명
		String searchWord = req.getParameter("searchWord");//검색어
		//검색 파라미터 추가 위한 변수
		if(searchWord!=null){
			//검색필드와 검색어를 Map에 추가한다.
			map.put("searchField",searchField);
			map.put("searchWord",searchWord);
		}

		int totalCount = dao.selectCount(map);
		/*페이지처리 start*/
		int pageSize = BoardConfig.page_per_size;//한페이지에 출력할 게시물의 수
		int blockPage = BoardConfig.page_per_block;//한 블럭당 출력할 페이지 수
		int totalPage = (int)Math.ceil((double)totalCount/pageSize);//전체 페이지 수 계산
		int pageNum = 1;//목록 첫 진입시에는 무조건 1페이지로 지정
		String pageTemp = req.getParameter("pageNum");
		//만약 파라미터로 전달된 페이지번호가 있다면
		if(pageTemp!=null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);//해당 번호로 페이지번호를 지정한다
			//목록을 페이지별로 구분하기 위해 between에 사용할 값 계산
		int start = (pageNum-1) * pageSize + 1;
		int end = pageNum * pageSize;
		//계산된 값은 Map컬렉션에 저장
		map.put("start", start);
		map.put("end", end);
		System.out.println(start+"="+end);
		/*페이지처리 end*/
		//목록에 실제 출력할 레코드를 얻어오기 위한 메소드 호출
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		//자원해제
		dao.close();
		
		String pagingImg = BoardPage.pagingImg(totalCount, pageSize, blockPage, pageNum, "../mvcboard/list.do");
		map.put("pagingImg", pagingImg);//페이지번호 문자열
		map.put("totalCount", totalCount);//게시물의 갯수
		map.put("pageSize", pageSize);//페이지수
		map.put("pageNum", pageNum);//현재 페이지 번호
		
		req.setAttribute("boardLists", boardLists);//페이지에 출력할 게시물
		req.setAttribute("map", map);//각종 파라미터
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
}
