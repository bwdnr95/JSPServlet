<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
pageContext.setAttribute("pageVar", "페이지영역이다");
request.setAttribute("requestVar", "리퀘스트영역이다");
%>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForwardAction.jsp</title>
</head>
<body>
	<h2>액션태그를 이용한 포워딩</h2>	
	<%
	/*
	1.sendRedirect()로 페이지이동
	-새로운 페이지에 대한 요청이므로 page, request영역 모두
	공유되지 않는다.
	-웹브라우저의 Url표시줄에는 마지막으로 요청된 페이지명이 
	보여진다. 
	-절대경로로 지정할 경우 컨택스트 루트명을 포함한 경로로 지정해야한다.
	*/
	/*response.sendRedirect(request.getContextPath()
			+"/07ActionTag/ForwardActionResult.jsp");*/  //정상적으로 이동됨.
	
	/*
	//컨택스트 루트 경로를 제외하면 이동시 404에러가 발생하게된다. 
	response.sendRedirect("/07ActionTag/ForwardActionResult.jsp");
	*/
	
	
	
	/*
	2.포워드(자바코드를 사용한 예제)
	-포워드 된 페이지에서는 request영역이 공유된다. 
	-URL창에는 최초 요청한 페이지의 경로가 보여지므로 사용자는
	페이지 이동을 알지 못한다. 
	-절대경로로 지정할경우 Context root(컨택스트 루트)를 제외한 
	경로로 지정한다.
	*/
	/*request.getRequestDispatcher("/07ActionTag/ForwardActionResult.jsp")
		.forward(request, response);*/
	%>
	
	<!--  
	3.포워드(액션태그를 사용한 예제)
	-액션태그에 page속성만 지정하면 되므로 표현이 간결하다.
	-나머지 특성은 모두 동일하다.
	-->	
	<jsp:forward page="/07ActionTag/ForwardActionResult.jsp" />
</body>
</html>





