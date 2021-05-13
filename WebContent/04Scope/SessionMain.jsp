<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    /*
    List컬렉션을 session영역에 저장함.
    */
    ArrayList<String> lists = new ArrayList();
    lists.add("리스트");
    lists.add("컬렉션");
    session.setAttribute("lists",lists);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
	<a> 태그를 통한 페이지 이동은 새로운 페이지에 대한 요청을 하는것으로
	JS의 location.href 혹은 response.sendRedirect()와 동일하다.
  -->
	<h2>페이지 이동 후 session영역의 속성읽기</h2>
	<a href="SessionLocation.jsp">SessionLocation.jsp바로가기</a>
</body>
</html>