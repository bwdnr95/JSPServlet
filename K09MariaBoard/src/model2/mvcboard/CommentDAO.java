package model2.mvcboard;

import java.util.List;
import java.util.Vector;

import common.ConnectionPool;

public class CommentDAO extends ConnectionPool {
	
	
	public CommentDAO() {
		super();
	}
	public int commentInsert(CommentDTO dto) {
		int result = 0;
		try { 
			String query = "INSERT INTO mycomments ( "
					+" board_idx, name, pass, comments) "
					+" VALUES ( "
					+" ?, ?, ?, ?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getBoard_idx());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getPass());
			psmt.setString(4, dto.getComments());
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("댓글 입력 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	//mvcboard의 일련번호를 매개변수로 받아 해당 댓글을 조회하는 메소드
	public List<CommentDTO> commentSelectList(String board_idx){
		List<CommentDTO> comments = new Vector<CommentDTO>();
		//댓글 작성일을 시:분 까지 출력하기 위해 to_char() 함수를 추가
		String query = " SELECT idx, board_idx, name, pass, comments, "
				+" date_format(postdate,'%y-%m-%d-%h-%i-%s') "
				+" FROM mycomments "
				+" WHERE board_idx=? "
				+" ORDER BY idx DESC";
		
			try {
				psmt = con.prepareStatement(query);
				psmt.setString(1, board_idx);
				rs = psmt.executeQuery();
				while(rs.next()) {
					CommentDTO dto = new CommentDTO();
					
					dto.setIdx(rs.getString(1));
					dto.setBoard_idx(rs.getString(2));
					dto.setName(rs.getString(3));
					dto.setPass(rs.getString(4));
					dto.setComments(rs.getString(5).replaceAll("\r\n", "<br/>"));
					dto.setPostdate(rs.getString(6));
					
					comments.add(dto);
				}
			}
			catch(Exception e) {
				System.out.println("댓글 조회 중 예외발생");
				e.printStackTrace();
			}
			return comments;
	}
	public CommentDTO commentSearch(String idx) {
		CommentDTO dto = new CommentDTO();
		String query = " SELECT idx, board_idx, name, pass, comments "
				+" FROM mycomments "
				+" WHERE idx=? ";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1,idx);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setBoard_idx(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setPass(rs.getString(4));
				dto.setComments(rs.getString(5));
			}
		}
		catch(Exception e) {
			System.out.println("댓글 수정을 위한 조회 중 에러발생");
			e.printStackTrace();
		}
		return dto;
	}
	public int passwordCheck(String idx, String pass) {
		int result = 0;
		String query = " SELECT count(*) "
				+" FROM mycomments "
				+" WHERE idx=? "
				+" AND pass=?";
				
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("댓글 수정을 위한 조회 중 에러발생");
			e.printStackTrace();
		}
		return result;
	}
	public void updateComments(String idx,String comments) {
		String query = "UPDATE mycomments SET "
				+ " comments=? , postdate=now() "
				+ " WHERE idx=?";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, comments);
			psmt.setString(2, idx);
			psmt.executeQuery();
		}
		catch(Exception e) {
			System.out.println("댓글 수정 중 에러 발생");
			e.printStackTrace();
		}
	}
	public int deleteComments(String idx,String pass) {
		int result=0;
		String query = "DELETE FROM mycomments WHERE idx=? AND pass=? ";
		try {
			psmt=con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.setString(2, pass);
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("댓글 삭제 중 에러 발생");
			e.printStackTrace();
		}
		return result;
	}
}
