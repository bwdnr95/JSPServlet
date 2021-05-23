<%@page import="utils.JSFunction"%>
<%@page import="homework.membershipDAO"%>
<%@page import="homework.membershipDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

request.setCharacterEncoding("UTF-8");
//폼값 받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String birth = request.getParameter("birth");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");
String addr3 = request.getParameter("addr3");
String ph_num1 = request.getParameter("ph_num1");
String ph_num2 = request.getParameter("ph_num2");
String ph_num3 = request.getParameter("ph_num3");
String email1 = request.getParameter("email1");
String email2 = request.getParameter("email2");
String ano_num1 = request.getParameter("ano_num1");
String ano_num2 = request.getParameter("ano_num2");
String ano_num3 = request.getParameter("ano_num3");
//폼값과 로그인 아이디를 저장하기 위한 DTO객체
membershipDTO dto = new membershipDTO();
dto.setId(id);
dto.setName(name);
dto.setPass(pass);
dto.setBirth(birth);
dto.setAddr1(addr1);
dto.setAddr2(addr2);
dto.setAddr3(addr3);
dto.setEmail1(email1);
dto.setEmail2(email2);
dto.setPh_num1(ph_num1);
dto.setPh_num2(ph_num2);
dto.setPh_num3(ph_num3);
dto.setAno_num1(ano_num1);
dto.setAno_num2(ano_num2);
dto.setAno_num3(ano_num3);

membershipDAO dao = new membershipDAO(application);




int registResult = dao.membershipRegist(dto);
dao.close();
if(registResult==1){
	response.sendRedirect("memberList.jsp");
}
else{
	JSFunction.alertBack("회원가입에에 실패하였습니다.",out);
}
%>
