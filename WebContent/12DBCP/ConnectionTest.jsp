<%@page import="common.ConnectionPool"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>데이터 베이스 커넥션 풀</h2>
	<%
	ConnectionPool cp = new ConnectionPool();
	cp.close();
	%>
</body>
</html>