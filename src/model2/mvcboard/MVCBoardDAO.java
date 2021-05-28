package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.ConnectionPool;
import model1.board.BoardDTO;

public class MVCBoardDAO extends ConnectionPool {

   public MVCBoardDAO() {
      super();
   }
   //게시물의 갯수 카운트
   public int selectCount(Map<String, Object> map) {
      int totalCount = 0;
      String query = "SELECT COUNT(*) FROM mvcboard";
      if(map.get("searchWord")!=null) {
         query += " WHERE "+ map.get("searchField") +" "
               + " LIKE '%"+ map.get("searchWord") +"%' ";
      }
      try {
         stmt = con.createStatement();
         rs = stmt.executeQuery(query);
         rs.next();
         totalCount = rs.getInt(1);
      } catch (Exception e) {
         System.out.println("게시물 카운트중 예외발생");
         e.printStackTrace();
      }
      return totalCount;
   }
   public List<MVCBoardDTO> selectListPage(Map<String, Object> map){
      List<MVCBoardDTO> bbs = new Vector<MVCBoardDTO>();
      
      String query = " "
            +" SELECT * FROM ( "
            +"    SELECT Tb.*, ROWNUM rNum FROM ( "
            +"   SELECT * FROM mvcboard ";
      if(map.get("searchWord")!=null) {
         query += " WHERE "+ map.get("searchField")+" "
               +"  LIKE '%"+ map.get("searchWord")+"%' ";
      }
      query += " "
            +"   ORDER BY idx DESC "
            +"  )Tb "
            +") "
            +"WHERE rNum BETWEEN ? AND ? ";
      try {
         psmt = con.prepareStatement(query);
         psmt.setString(1, map.get("start").toString());
         psmt.setString(2, map.get("end").toString());
         rs = psmt.executeQuery();
         while(rs.next()) {
            MVCBoardDTO dto = new MVCBoardDTO();
            dto.setIdx(rs.getString(1));
            dto.setName(rs.getString(2));
            dto.setTitle(rs.getNString(3));
            dto.setContent(rs.getString(4));
            dto.setPostdate(rs.getDate(5));
            dto.setOfile(rs.getString(6));
            dto.setSfile(rs.getString(7));
            dto.setDowncount(rs.getString(8));
            dto.setPass(rs.getString(9));
            dto.setVisitcount(rs.getString(10));
            
            bbs.add(dto);
         }
      } catch (Exception e) {
         System.out.println("게시물 조회중 예외 발생");
         e.printStackTrace();
      }
      return bbs;
   }
   public int insertWrite(MVCBoardDTO dto) {
		int result =0;
		try {
			String query = "INSERT INTO mvcboard ("
						+ " idx,name,title,content,ofile,sfile,pass)"
						+" VALUES ("
						+" seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, ?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 입력중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
   public MVCBoardDTO selectView(String idx) {
	   MVCBoardDTO dto = new MVCBoardDTO();
	   String query = "SELECT * FROM mvcboard WHERE idx=?";
	   try {
		   psmt = con.prepareStatement(query);
		   psmt.setString(1, idx);
		   rs = psmt.executeQuery();
		   if(rs.next()) {
			   dto.setIdx(rs.getString(1));
			   dto.setName(rs.getString(2));
			   dto.setTitle(rs.getString(3));
			   dto.setContent(rs.getString(4));
			   dto.setPostdate(rs.getDate(5));
			   dto.setOfile(rs.getString(6));
			   dto.setSfile(rs.getString(7));
			   dto.setDowncount(rs.getString(8));
			   dto.setPass(rs.getString(9));
			   dto.setVisitcount(rs.getString(10));
		   }
	   }
	   catch(Exception e) {
		   System.out.println("게시물 상세보기 중 예외발생");
		   e.printStackTrace();
	   }
	   return dto;
   }
   public void updateVisitCount(String idx) {
	      String query = "UPDATE mvcboard SET "
	            + " visitcount=visitcount+1 "
	            + " WHERE idx=?";
	      try {
	         psmt = con.prepareStatement(query);
	         psmt.setString(1, idx);
	         psmt.executeQuery();
	         
	      } catch (Exception e) {
	         System.out.println("방문자수 증가에러 발생");
	         e.printStackTrace();
	      }
   }
    public boolean confirmPassword(String idx, String pass) {
	      boolean result = false;
	      //일련번호와 패스워드가 일치하는 게시물이 있는지 확인
	      String query = " SELECT COUNT(*) FROM mvcboard "
	            + " WHERE idx=? AND pass=? ";
	      try {
		        psmt = con.prepareStatement(query);
		        psmt.setString(1, idx);
		        psmt.setString(2, pass);
		        rs = psmt.executeQuery();
		         
		        rs.next();
		         //삼항연산자 사용해서 결정
		        if(rs.getInt(1)==1) {
		        	result = true;
		        }
	         } 
	         catch (Exception e) {
	         //검증에 실패하면 false 처리 해줘야함
	         result = false;
	         System.out.println("패스워드 검증 에러발생");
	         e.printStackTrace();
	      }
	      
	      return result;
    }
    //수정처리
    public int updatePost(MVCBoardDTO dto) {
    	int result = 0;
    	try {
    		//비회원제 게시판이므로 패스워드까지 where절에 추가함.
    		String query = "UPDATE mvcboard SET "
    				+ " title=?, name=?, content=?, ofile=?, sfile=? "
    				+ " WHERE idx=? and pass=? ";
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, dto.getTitle());
    		psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			psmt.setString(7, dto.getPass());
			result = psmt.executeUpdate();
    	}
    	catch(Exception e) {
    		System.out.println("게시물 수정 중 예외발생");
    		e.printStackTrace();
    	}
    	return result;
    }
    public int deletePost(String idx) {
        int result = 0;
        try {
           //비밀번호 검증 후 즉시 삭제하므로 비밀번호는 제외한다.
           String query = "DELETE FROM mvcboard WHERE idx=?";
           psmt = con.prepareStatement(query);
           psmt.setString(1, idx);
           result = psmt.executeUpdate();
        }
        catch(Exception e) {
           System.out.println("게시물 삭제중 예외발생");
           e.printStackTrace();
        }
        return result;
     }
    public void downCountPlus(String idx) {
        String query = "UPDATE mvcboard SET "
	            + " downcount=downcount+1 "
	            + " WHERE idx=?";
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);
            psmt.executeQuery();
	         
	      	} 
         catch (Exception e) {
	         
        }
    }
}
