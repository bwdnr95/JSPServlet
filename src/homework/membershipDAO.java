package homework;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import utils.JSFunction;

public class membershipDAO {
	
	//DAO의 기본 멤버변수
	Connection con;//DB연결
	Statement stmt;//정적쿼리전송 및 실행
	PreparedStatement psmt;//동적 쿼리전송 및 실행
	ResultSet rs;//select결과 반환
	
	
	/*
	 인자생성자1 : JSP에서 web.xml에 등록된 컨텍스트 초기화 파라미터를
	 	가져와서 생성자 호출시 파라미터로 전달하여 DB에 연결한다.
	 */
	public membershipDAO(String driver, String url) {
		try {
			
			Class.forName(driver);
			
			String id = "kosmo";
			String pass = "1234";
			
			 con = DriverManager.getConnection(url,id,pass);
			System.out.println("Oracle 연결성공");
		}
		catch(Exception e) {
			System.out.println("Oracle 연결시 예외발생");
			e.printStackTrace();
		}
		
	}
	/*
	 인자생성자2 : JSP에서 인수로 전달했던 초기화 파라미터를
	 	생성자내에서 가져오기 위해 JSP에서는 application내장객체를
	 	매개변수로 전달한다. 그러면 메소드 내에서 web.xml을
	 	접근할 수 있다.
	 */
	public membershipDAO(ServletContext application) {
		try {
			String drv = application.getInitParameter("JDBCDriver");
			String url = application.getInitParameter("ConnectionURL");
			String id = application.getInitParameter("OracleId");
			String pass = application.getInitParameter("OraclePwd");
			
			
			Class.forName(drv);
			 con = DriverManager.getConnection(url,id,pass);
			System.out.println("JDBC 연결성공");
		}
		catch(Exception e) {
			System.out.println("JDBC 연결시 예외발생");
			e.printStackTrace();
		}
		
	}
	/*
	 데이터베이스 연결을 해제할때 사용하는 메소드.
	 한정된 자원을 사용하므로 사용을 마쳤다면 반드시
	 연결을 해제해야 한다.
	 */
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
		String query ="SELECT COUNT(*) FROM membership ";
		
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
	
	public int membershipRegist(membershipDTO dto) {
		int result =0;
		try {
			//인파라미터가 있는 insert 쿼리문 작성
			String query = "INSERT INTO membership ("
						+ " id,pass,name,birth,addr1,addr2,addr3,email1,email2,ph_num1,ph_num2, "
						+ " ph_num3,ano_num1,ano_num2,ano_num3) "
						+" VALUES ("
						+" ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )";
			//prepare객체 생성 후 인파라미터 설정
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getBirth());
			psmt.setString(5, dto.getAddr1());
			psmt.setString(6, dto.getAddr2());
			psmt.setString(7, dto.getAddr3());
			psmt.setString(8, dto.getEmail1());
			psmt.setString(9, dto.getEmail2());
			psmt.setString(10, dto.getPh_num1());
			psmt.setString(11, dto.getPh_num2());
			psmt.setString(12, dto.getPh_num3());
			psmt.setString(13, dto.getAno_num1());
			psmt.setString(14, dto.getAno_num2());
			psmt.setString(15, dto.getAno_num3());
			//쿼리문 실행
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("회원정보 입력중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	public membershipDTO memberView(String id) {
		
		membershipDTO dto = new membershipDTO();
		
		String query = "SELECT * " +
				" FROM membership " +
				" WHERE id=?";
		try {
			psmt= con.prepareStatement(query);
			psmt.setString(1, id);
			rs=psmt.executeQuery();
			/*
			 매개변수로 전달된 일련번호를 통해 조회하므로
			 결과는 무조건 1개만 나오게 된다. 따라서 if문으로
			 반환된 결과가 있는지만 확인하면 된다.
			* */
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setAddr1(rs.getString("addr1"));
				dto.setAddr2(rs.getString("addr2"));
				dto.setAddr3(rs.getString("addr3"));
				dto.setBirth(rs.getString("birth"));
				dto.setEmail1(rs.getString("email1"));
				dto.setEmail2(rs.getString("email2"));
				dto.setPh_num1(rs.getString("Ph_num1"));
				dto.setPh_num2(rs.getString("Ph_num2"));
				dto.setPh_num3(rs.getString("Ph_num3"));
				dto.setAno_num1(rs.getString("Ano_num1"));
				dto.setAno_num2(rs.getString("Ano_num2"));
				dto.setAno_num3(rs.getString("Ano_num3"));
				dto.setRegidate(rs.getDate("regidate"));
			}
		}
		catch(Exception e) {
			System.out.println("회원정보 상세보기 중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	//회원정보 수정 처리
	/*
	 * public int updateEdit(membershipDTO dto) { int result = 0; try { String query
	 * = "UPDATE board SET " + " title=?, content=? " + " WHERE id=?"; psmt =
	 * con.prepareStatement(query); psmt.setString(1, dto.getTitle());
	 * psmt.setString(2, dto.getContent()); psmt.setString(3, dto.getNum());
	 * 
	 * result = psmt.executeUpdate(); } catch(Exception e) {
	 * System.out.println("게시물 수정 중 예외 발생"); e.printStackTrace(); } return result; }
	 */
	//회원 삭제처리
	public int deletePost(membershipDTO dto) {
		int result = 0;
		try {
			String query = "DELETE FROM board WHERE id=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 삭제 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//회원 목록 출력시 페이지 처리
	public List<membershipDTO> selectListPage(Map<String,Object> map){
		List<membershipDTO> bbs = new Vector<membershipDTO>();
		String query = " "
				+" SELECT * FROM ( "
				+"  SELECT ROWNUM rNum, id,name,ph_num1,ph_num2,ph_num3,email1,email2,regidate FROM ( "
				+"  SELECT * FROM membership ";
		if(map.get("searchWord")!=null) {
			query +=" WHERE " + map.get("searchField")+ " "
					+" LIKE '%"+ map.get("searchWord")+"%' ";
		}
		query +=" ORDER BY id DESC ) "
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
				membershipDTO dto = new membershipDTO();
				
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPh_num1(rs.getString("Ph_num1"));
				dto.setPh_num2(rs.getString("Ph_num2"));
				dto.setPh_num3(rs.getString("Ph_num3"));
				dto.setEmail1(rs.getString("Email1"));
				dto.setEmail2(rs.getString("Email2"));
				dto.setRegidate(rs.getDate("regidate"));
				
				bbs.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
	public int overapping(String id) {
		int result = 0;
		String query = " "
				+ "SELECT id FROM membership "
				+ " WHERE id= ? ";
		System.out.println("페이지쿼리:"+query);
		try {
			psmt=con.prepareStatement(query);
			//between절의 start와 end값을 인파라미터 설정
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
}
