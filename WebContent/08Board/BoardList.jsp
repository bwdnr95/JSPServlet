<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String drv = application.getInitParameter("JDBCDriver");
String url = application.getInitParameter("ConnectionURL");
BoardDAO dao = new BoardDAO(drv,url);
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