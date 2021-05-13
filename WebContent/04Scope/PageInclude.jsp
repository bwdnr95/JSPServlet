<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PageInclude.jsp</title>
</head>
<body>	
	<!--  
	해당 페이지 자체만으로 보면 아래 변수들이 선언되지 않았으므로
	에러가 발생하지만, include되어 포함되면 문제없는 코드가 된다. 
	-->
	<h2>포함된(include) 페이지 입니다. </h2>
	<ul>
		<li>Integer타입 : <%=pageContext.getAttribute("pageNumber") %></li>
		<li>String타입 : <%=pageContext.getAttribute("pageString") %></li>
		<li>Date타입 : <%=dateString %></li>
		<li>MemberDTO타입1 : <%=m1Str %></li>
		<li>MemberDTO타입2 : 아이디:<%=m2.getId() %>,
							비번:<%=m2.getPass() %>,
							이름:<%=m2.getName() %>,
							가입일:<%=m2.getRegidate() %></li>
	</ul>
</body>
</html>







