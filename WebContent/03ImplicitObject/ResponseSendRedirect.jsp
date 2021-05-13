<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//폼값 받기
	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");
	
	//대소문자 구분없이 아이디/패스워드 일치여부 확인
	if(id.equalsIgnoreCase("kosmo") && pwd.equalsIgnoreCase("1234")){
		//JS의 location.href와 동일하게 해당 경로로 이동한다.
		response.sendRedirect("../common/Welcome.jsp");
	}
	else{
	%>
		<script>
			alert("아이디와 패스워드가 일치하지 않습니다.");
			history.go(-1);
		</script>
	<%
		/*
		JS코드와 JSP코드가 동일한 실행 블럭내에 존재하는 경우 JSP코드가
		우선순위가 높으므로 JS코드는 무시된다. 즉 이와같은 경우 JS코드는
		실행되지 않고 아래 JSP코드만 실행되게 된다.
		*/
		//response.sendRedirect("./ResponseMain.jsp");
	
		/*
		JS코드를 실행하려면 JSP코드는 주석 처리 해야한다.
		*/
	}
	%>
</body>
</html>