<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
포워드된 페이지나 인클루드된 페이지로 파라미터를 전달하는 경우
한글이 포함되어있다면, 반드시 포워드 시키는 최초페이지에서
인코딩을 설정해야한다. 
*/
request.setCharacterEncoding("UTF-8");
request.setAttribute("member", new MemberDTO("Sung","9999","성춘향",null));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ParamAction.jsp</title>
</head>
<body>
	<h2>인클루드 되는 페이지로 파라미터 전달하기</h2>
	
 	<!--  
 		아래와 같이 설정하면 쿼리스트링 형태로 파라미터가 전송된다.
 		(아래와 같이 시작과 종료태그가 있는 경우에는 사이에 HTML
 		주석을 사용할 수 없다. 에러발생됨.)
 	-->
	<jsp:include page="ParamActionIncludeResult.jsp">
		<jsp:param value="이몽룡" name="name" />
		<jsp:param value="Lee" name="id" />
	</jsp:include>
	

	<%
	String pageURL = "ParamActionForwardResult.jsp?query=반갑습니다";
	String paramValue = "KOSMO";
	
	/*
		request영역에 저장된 객체는 forward된 페이지까지 영역이
		공유되므로, 영역을 통해 데이터를 전달할 수 있다. 
		차후 서블릿에서 활용되는 방식이다. 
	*/
	request.setAttribute("member", new MemberDTO("Lee","7777","이몽룡",null));
	%>
	<jsp:forward page="<%=pageURL %>">
		<jsp:param value="한국소프트웨어인재개발원" name="name"/>
		<jsp:param value="<%=paramValue %>" name="id" />
	</jsp:forward>
		
</body>
</html>


