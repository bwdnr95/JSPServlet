<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!--
	catch태그
	-EL이나 JSP에서 예외가 발생했을때 처리를 위해 사용된다.
	-에러 내용을 원하는 위치에 출력할 수 있다.
	-JSTL문법 오류는 catch되지 않는다.	
	  -->
	<h2>catch 태그</h2>
	<c:set var="fnum" value="100" />
	<c:set var="snum" value="0" />
	
	
	<h3>에러가 안나는 경우 : 에러내용이 저장 안됨</h3>
	<!--
		Java에서 정수를 0으로 나누면 예외가 발생하지만, EL에서는
		예외가 발생하지 않고, infinity로 출력된다. 즉, 이 경우에는
		변수에 아무런 내용도 저장되지 않는다.
	  -->
	
	<h4>catch태그 밖에서 실행</h4>
	fnum/ snum : ${fnum/snum }
	<br />
	<h4>catch태그 안에서 실행</h4>
	<c:catch var="errorMessage">
		fnum / snum : ${fnum / snum }
	</c:catch>
	에러내용 : ${errorMessage }
	
	<!--
	아래 문장처럼 에러가 발생되는 경우에는 페이지에서 실행할 수 없다.
	이경우 500에러가 발생하기 때문에  var에 지정한 변수에 에러내용이
	저장된다.
	 -->
	<h3>에러가 나는 경우 : 원하는 위치에 에러내용 표시</h3>
	\${"백" + 100} <- 실행시 500에러 발생됨.
	
	<br />
	<c:catch var="errorMessage">
		${"백" + 100 }
	</c:catch>
	에러내용 : ${errorMessage }
	
	<h4>Java코드에서의 예외</h4>
	<c:catch var="errorMessage">
		<%
		int result= 100/0;
		%>
	</c:catch>
	에러내용 : ${errorMessage }
</body>
</html>