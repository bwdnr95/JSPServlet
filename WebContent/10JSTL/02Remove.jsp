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
	remove태그 : set태그를 통해 선언한 변수를 제거할때 사용하는 태그로
		영역에 저장된 속성을 제거한다. 따라서 로그아웃 시 사용할 수 있다.
	  -->
	<h2>remove 태그</h2>
	<!-- 동일한 속성명으로 page,request영역에 저장 -->
	<c:set var="pageVar" value="페이지영역" />
	<c:set var="pageVar" value="리퀘스트영역1번" scope="request"/>
	<c:set var="requestVar" value="리퀘스트영역2번" scope="request"/>
	<c:set var="sessionVar" value="세션영역" scope="session" />
	<c:set var="appVar" value="어플리케이션영역" scope="application" />
	
	
	<!--
	xxScope 내장객체를 사용하지 않으면 가장 좁은 영역의 변수를
	읽어온다. 변수명이 서로 다르다면 생략이 가능하다.
	  -->
	<h3>삭제전 출력하기</h3>
	
	<ul>
		<li>페이지 : ${pageVar }</li>
		<li>리퀘스트1 : ${requestScope.pageVar }</li>
		<li>리퀘스트2 :${requestVar }</li>
		<li>세션 :${sessionVar }</li>
		<li>어플리케이션 : ${appVar }</li>
	</ul>
	
	<!--
	속성명이 존재하지만, 영역설정이 잘못된 경우 아무것도 삭제되지
	않는다. 영역 혹은 변수명의 설정이 잘못되더라도 에러는 발생하지 않는다.
	  -->
	<h3>remove로 삭제하기</h3>
	<c:remove var="requestVar" scope="session" />
	
	<h3>영역이 다른 속성명 삭제 후 출력하기</h3>
	<ul>
		<li>페이지 : ${pageVar }</li>
		<li>리퀘스트1 : ${requestScope.pageVar }</li>
		<li>리퀘스트2 :${requestVar }</li>
		<li>세션 :${sessionVar }</li>
		<li>어플리케이션 : ${appVar }</li>
	</ul>
	<!--
	영역에 동일한 이름의 속성이 존재하는 경우에는 모든 영역의 속성이
	한꺼번에 삭제되므로 사용에 주의해야 한다.
	  -->
	<h3>remove로 삭제하기</h3>
	<c:remove var="pageVar" />
	
	<h3>스코프 미지정 후 같은 속성명 삭제 후 출력하기</h3>
	<ul>
		<li>페이지 : ${pageVar }</li>
		<li>리퀘스트1 : ${requestScope.pageVar }</li>
		<li>리퀘스트2 :${requestVar }</li>
		<li>세션 :${sessionVar }</li>
		<li>어플리케이션 : ${appVar }</li>
	</ul>
</body>
</html>