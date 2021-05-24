<%@page import="eltag.MyTagLib"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--  
	JSP파일에서 EL을 통해 메소드를 호출하기 위해 
	지시어를 통한 선언문을 먼저 기술해야한다. 
	prefix="접두어" uri="TLD파일의 위치"
-->
<%@ taglib prefix="my" uri="/WEB-INF/tlds/MyTagLib.tld" %>

<!--  
	web.xml에 등록한 uri의 별칭을 통해서도 지시어를 설정할 수 있다.
-->
<%--@ taglib prefix="my" uri="myTagLibTld" --%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyTagLib.jsp</title>
</head>
<body>
	<h3>Java코드로 메소드 호출하기</h3>
	<ul>
		<li>
			MyTagLib.isNumber("100") => <%=MyTagLib.isNumber("100") %>
		</li>
	</ul>
	
	<!--  
	접두어를 통해 메소드를 호출한다. 
	-->
	<h3>EL에서 자바클래스의 메소드 호출하기</h3>
	<ol>
		<li>
			my:isNumber("100") => ${my:isNumber("100") }
		</li>
		<li>
			my:isNumber("백20") => ${my:isNumber("백20") }
		</li>
	</ol>		
	
	<!--  
	별도의 tld파일에 등록절차 없이 사용가능함.
	-->
	<h3>영역에 저장한 후 메소드 호출하기</h3>
	<%
	MyTagLib myClass = new MyTagLib();
	pageContext.setAttribute("myClass", myClass);	
	%>
	100 => ${myClass.isNumber("100") } <br />
	삼백 => ${myClass.isNumber("삼백") }
	
	
	<!-- 이 경우 해당 클래스가 반드시 import 처리되야 한다.  -->
	<h3>클래스명을 통해 정적메소드 호출하기</h3>	
	100 => ${MyTagLib.isNumber("100") } <br />
	삼백 => ${MyTagLib.isNumber("삼백") }
		
</body>
</html>