<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>상단메뉴</h2>
	<table border="1" width="90%">
		<tr>
			<td>
			<!--로그인 여부를 판단하기 위해 session영역의 속성을 사용한다.  -->
				<%if(session.getAttribute("USER_ID")==null){ %>
					<a href="../06Session/Login.jsp">로그인</a>
				<% }else{ %>
					<a href="../06Session/Logout.jsp">로그아웃</a>
				<%} %>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="../homework/memberRegistForm.jsp">회원가입하기</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="../08Board/List.jsp">회원제게시판2[PageO]</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="../DataRoom/DataList">자료실(Model2)</a>
					
			</td>
		</tr>
	
	</table>
</body>
</html>