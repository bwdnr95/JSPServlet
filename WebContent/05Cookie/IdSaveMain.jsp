
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    //체크박스 체크용 변수
    String cookieCheck = "";
    String loginId = CookieManager.readCookie(request,"loginId");
    if(!loginId.equals("")){
    	cookieCheck = "checked";
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>로그인 페이지</h2>
	<form action="IdSaveProcess.jsp" method="post">
	<!--
		생성된 쿠키가 있따면 저장된 아이디를 입력하고, 체크박스에
		checked 속성을 부여한다.
	  -->
	아이디 : <input type="text" name ="user_id" value="<%=loginId%>"/>
	<br />
	<label>
			<input type="checkbox" name="save_check" value="Y"
				<%=cookieCheck %> tabindex="3" /> 아이디저장하기
		</label>
	패스워드 : <input type="text"  name ="user_pw"/>
	<br />
	<input type="submit" value="로그인하기"/>
	</form>
</body>
</html>