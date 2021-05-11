<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%--
    include 지시어 : 공통으로 사용할 JSP파일을 생성한 후
    	현재문서에 포함시킬때 사용한다. 각각의 JSP파일 상단에는
    	반드시 page지시어가 삽입되어야 한다.
    	단, 하나의 JSP파일에서 page지시어가 중복선언되면 안된다.
     --%>
<%@ include file = "IncludePage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/div_layout.css" />
</head>
<body>
	<div class="AllWrap">
		<div class="header">
			<%@ include file="../common/Top.jsp" %>
		</div>
		<div class="body">
			<div class="left_menu">
				<%@ include file="../common/Left.jsp" %>
			</div>
			<div class="contents">
				<h2>오늘의 날짜: <%=todayStr %></h2>
				<br /><br />
				
				신문기사를 삽입하세요
				
				<br /><br />
			</div>
		</div>
		<div class="copyright">
			<%@ include file="../common/Copyright.jsp" %>
		</div>
	</div>
</body>
</html>