<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String drv = application.getInitParameter("JDBCDriver");
String url = application.getInitParameter("ConnectionURL");
String id = application.getInitParameter("Oracleid");
String pass = application.getInitParameter("OraclePwd");

/* BoardDAO dao = new BoardDAO(drv,url); */
BoardDAO dao = new BoardDAO(application);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>