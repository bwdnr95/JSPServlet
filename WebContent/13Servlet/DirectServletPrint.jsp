<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DirectServletPrint.jsp</title>
</head>
<body>
	<h2>web.xml에서 매핑후 SErvlet에서 직접 출력하기</h2>
	<!--
	요청명을 아래와 같이 결정한 후 post방식으로 요청한다.
	서블릿에는 post방식의 요청을 받을 수 있는 doPost() 메소드가
	오버라이딩 되어 있어야 한다.
	  -->
	<form action="../13Servlet/DirectServletPrint.do" method="post">
		<input type="submit" value="바로가기" />
	</form>
</body>
</html>