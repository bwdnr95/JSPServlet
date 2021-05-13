<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//MemberDao객체를 생성한다.(생성과 동시에 DB에 연결된다.)
	MemberDAO dao = new MemberDAO();

	//사용자가 입력한 파라미터를 받아온다.
	String id= request.getParameter("user_id");
	String pw = request.getParameter("user_pwd");
	
	//DAO의 isMember()메소드를 호출한다. 이 때 파라미터를 같이 전달한다.
	boolean memberFlag = dao.isMember(id,pw);
	//반환값을 통해 회원 유무를 판단할 수 있다.
	if(memberFlag==true){
		System.out.println("회원입니다.");
		response.sendRedirect("../common/Welcome.jsp");
		
	}
	else{
		System.out.println("회원이 아닙니다.");
		
		String jsAlert = "<script>";
		jsAlert += "alert(회원이아닙니다.)";
		jsAlert+= "history.go(-1);";
		jsAlert += "</script>";
		
		out.println(jsAlert);
	}

	
%>
 