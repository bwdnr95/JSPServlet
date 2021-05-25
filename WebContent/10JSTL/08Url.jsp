<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
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
	url태그
	-URL을 생성할 때 사용한다.
	-절대경로로 생성시에는 컨텍스트 루트를 제외해야 한다.
	-var속성을 미지정시에는 해당 위치에 즉시 URL이 출력된다.
	-param태그로 지정한 값은 쿼리스트링으로 연결된다.
	  -->
	<h3>var속성 미지정</h3>
	<c:url value="/10JSTL/inc/ImportPage.jsp">
		<c:param name="user_id" value="gasan"/>
		<c:param name="user_pw">Digital</c:param>
	</c:url>
	<h3>var속성 지정</h3>
	<c:url value="/10JSTL/inc/ImportPage.jsp" var="url">
		<c:param name="user_id" value="World"></c:param>
		<c:param name="user_pw" >메르디앙2차</c:param>
	</c:url>
	<h3>var속성 지정 후 원하는 위치에  url설정</h3>
	
	<a href="${url }">ImportPage.jsp바로가기 ></a>
	
	<h3>HTML태그에 직접 JSTL로 절대경로 지정하기</h3>
	<a href="<c:url value='/10JSTL/inc/ImportPage.jsp?user_id=Lee&user_pw=7777' />">
		ImportPage.jsp바로가기
	</a>
	
	<h3>DB응용하기</h3>
	<c:url value="/10JSTL/inc/ImportPage.jsp" var="makeUrl">
	
	<%
	String id = request.getParameter("id");
	
	String paramId="", paramPass="", paramName="" ;
	
	if(id!=null){
		MemberDAO dao = new MemberDAO();
		Map<String, String> maps = dao.getMemberMap(id);
		paramId = maps.get("id");
		paramName = maps.get("name");
		paramPass = maps.get("pass");
	
	%>
	<c:param name="user_id" value="<%=paramId %>" />
	<c:param name="user_pass" value="<%=paramPass %>" />
	<c:param name="user_name" value="<%=paramName %>" />
	<%
	}
	%>
	</c:url>
	DB연동한Url : ${makeUrl }
</body>
</html>