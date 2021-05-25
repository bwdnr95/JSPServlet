<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>숫자 포맷 설정</h4>
	<c:set var="number1" value="12345" />
	
	<!--
		groupingUsed의 디폴트 값이 true이므로 세자리마다 콤마 출력됨
	  -->
	콤마O :<fmt:formatNumber value="${number1 }" /> <br />
	
	<!--
		false로 지정하면 콤마 생략됨
	  -->
	
	콤마X :<fmt:formatNumber value="${number1 }"  groupingUsed="false" /> <br />
	
	
	<!--
		type이 currency인 경우 현지 통화기호로 출력됨.
		var속성 지정시 즉시 출력되지 않고, 원하는 위치에 출력할 수 있음.
		currencySymbol 속성값으로 통화기호를 변경할 수 있음.
	  -->
	<fmt:formatNumber value="${number1 }" type="currency" var = "printNum1" />
	통화기호(원화로표시):${printNum1 } <br />
	
	<fmt:formatNumber value="${number1 }" type="currency" currencySymbol="$" var = "printNum1" />
	통화기호(달러로표시):${printNum1 } <br />
	
	<!--
		value 속성값을 % 단위로 변환해서 출력한다.
	  -->
	<fmt:formatNumber value="0.03" type="percent" var="printNum2" />
	퍼센트:${printNum2 }
	
	<h4>문자열을 숫자로 변경</h4>
	<c:set var="number2" value="6,789.01" />
	
	<!--
		pattern속성으로 패턴을 지정하여 소수점까지 출력함
	  -->
	<fmt:parseNumber value="${number2 }" pattern="00,000.00" var = "printNum3" />

	소수점까지 : ${printNum3 } <br />
	
	<!--
		integerOnly 속성으로 정수 부분만 출력함.
	  -->
	<fmt:parseNumber value="${number2 }" integerOnly="true" var = "printNum4" />
	정수부분만:${printNum4 }
	
	
	<h4>자바코드로 1000단위 콤마 표시하기</h4>
	<%
	/*
		NumberFormat 클래스는 싱글턴 패턴으로 제작된 클래스로
		new 연산자를 통해 객체를 생성할 수 없는 대표적인 클래스이다.
		getInstance()를 통해 이미 생성된 static 형태의 객체를
		반환받아 사용해야 한다.
	*/
	
	String moneyStr = pageContext.getAttribute("number1").toString();
	int money = Integer.parseInt(moneyStr);
	NumberFormat nf = NumberFormat.getInstance();
	String commaMoney = nf.format(money);
	out.println(commaMoney);
	%>
</body>
</html>