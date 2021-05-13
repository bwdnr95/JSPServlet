<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>페이지 이동 후 session영역의 속성읽기</h2>
	<%
	/*
	웹브라우저를 최초로 연 후 닫을때까지의 단위를 session이라고 한다.
	즉, 웹브라우저를 닫기 전까지는 session영역이 유지되므로 아래에서는
	데이터가 출력된다.
	*/
	ArrayList<String> lists =
		(ArrayList<String>)session.getAttribute("lists");
	for(String str : lists)
		out.print(str+"<br/>");
	
	/*
	웹브라우저를 완전히 닫은 후 해당 파일을 단독적으로 실행하면
	session영역에 저장된 속성이 없기때문에 500에러가 발생한다.
	*/
	%>
</body>
</html>