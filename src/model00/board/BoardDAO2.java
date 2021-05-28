package model00.board;

import java.util.List;
import java.util.Map;
import java.util.Vector;


import common.ConnectionPool;

public class BoardDAO2 extends ConnectionPool {
	
	public BoardDAO2() {
		super();
	}
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch(Exception e) {
			System.out.println("Oracle 자원반납시 예외발생");
			e.printStackTrace();
		}
	}
	//게시물의 갯수를 카운트
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		//count() 그룹함수를 통해 쿼리문 작성
		String query ="SELECT COUNT(*) FROM mvcboard ";
		
		//검색 파라미터가 있는 경우라면 where절을 추가한다.
		if(map.get("searchWord")!=null) {
			query += " WHERE "+map.get("searchField")+" "
					+" LIKE '%"+ map.get("searchWord")+"%'";
		}
		try{
			//Statement객체를 생성
			stmt = con.createStatement();
			//쿼리문 실행 및 결과 반환
			rs=stmt.executeQuery(query);
			//결과를 읽기위해 커서 이동
			rs.next();
			//count(*)를 통한 쿼리의 결과는 무조건 정수이므로 getInt()로 읽어옴.
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("게시물 카운트 중 예외발생");
			e.printStackTrace();
		}
		return totalCount;
		
	}
	
	//게시판 글쓰기 처리
	public int insertWrite(BoardDTO2 dto) {
		int result =0;
		try {
			//인파라미터가 있는 insert 쿼리문 작성
			String query = "INSERT INTO mvcboard ("
						+ " num,title,id,visitcount,)"
						+" VALUES ("
						+" seq_board_num.NEXTVAL, ?, ?, ?, 0)";
			//prepare객체 생성 후 인파라미터 설정
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			//쿼리문 실행
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 입력중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	//게시물 조회하기
	public BoardDTO2 selectView(String num) {
		//조회한 하나의 레코드를 저장할 DTO객체 생성
		BoardDTO2 dto = new BoardDTO2();
		//회원테이블과 게시판 테이블을 조인하여 조회함. 회원이름을 가져오기 위함
		String query = "SELECT B.*, M.name " +
				" FROM member M INNER JOIN board B " +
				"	on M.id=B.id " +
				" WHERE num=?";
		try {
			psmt= con.prepareStatement(query);
			psmt.setString(1, num);
			rs=psmt.executeQuery();
			/*
			 매개변수로 전달된 일련번호를 통해 조회하므로
			 결과는 무조건 1개만 나오게 된다. 따라서 if문으로
			 반환된 결과가 있는지만 확인하면 된다.
			* */
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
				
			}
		}
		catch(Exception e) {
			System.out.println("게시물 상세보기 중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	//조회수 증가
	public void updateVisitCount(String num) {
		String query = "UPDATE board SET " +
				" visitcount = visitcount+1 " +
				" WHERE num=?";
		try {
			psmt= con.prepareStatement(query);
			psmt.setString(1, num);
			rs=psmt.executeQuery();
		}
		catch(Exception e) {
			System.out.println("게시물 조회수증가 중 예외발생");
			e.printStackTrace();
		}
		
	}
	//게시물 수정 처리
	public int updateEdit(BoardDTO2 dto) {
		int result = 0;
		try {
			String query = "UPDATE board SET "
					+ " title=?, content=? "
					+ " WHERE num=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNum());
			
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	public int deletePost(BoardDTO2 dto) {
		int result = 0;
		try {
			String query = "DELETE FROM board WHERE num=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getNum());
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 삭제 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	public List<BoardDTO2> selectListPage(Map<String,Object> map){
		List<BoardDTO2> bbs = new Vector<BoardDTO2>();

		String query = " "
				+" SELECT * FROM ( "
				+"  SELECT Tb.*,ROWNUM rNum FROM ( "
				+"       SELECT * FROM board ";
		if(map.get("searchWord")!=null) {
			query +=" WHERE " + map.get("searchField")+ " "
					+" LIKE '%"+ map.get("searchWord")+"%' ";
		}
		query +=" "
				+"      ORDER BY num DESC "
				+"     ) Tb "
				+" ) "
				+" WHERE rNum BETWEEN ? AND ?";
		System.out.println("페이지쿼리:"+query);
		
		try {
			psmt=con.prepareStatement(query);
			//between절의 start와 end값을 인파라미터 설정
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO2 dto = new BoardDTO2();
				
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
}
