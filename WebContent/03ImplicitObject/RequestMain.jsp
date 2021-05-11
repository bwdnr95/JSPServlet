<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>전송방식(Post,Get) 테스트</h2>
	<!--
	Get방식에는 다음 3가지 형태의 전송방식이 있다.
	1. <a href=''를 사용하는 방법
	2.JS의 location.href=''를 사용하는방법
	3.<form method='get'을 사용하는 방법
	  -->
	<h3>Get방식 전송</h3>
	<a href="RequestInfo.jsp?paramNum=123&paramEng=Hello&paramHan=안녕">Get방식</a>
	
	<h3>Post방식 전송</h3>
	<form action="RequestInfo.jsp" method="post">
		문자열입력 : <input type="text" name="paramHan" />
		<input type="submit" value="Post방식" />
	</form>
	
	<h2>파라미터 및 값 전달</h2>
	<%
	/*
	한글을 정송하는 경우 서버 환경에 따라 깨질 수 있으므로
	인코딩 후 전달하는 것이 안전하다.
	*/
	String encodeName = URLEncoder.encode("홍길동","UTF-8");
	%>
	<a href="RequestParameter.jsp?name=<%=encodeName%>
		&id=hong&sex=man&favorite=&self_intro=">Get방식</a>
		
	<br />
	<br />
	<script>
		function checkForm(f){
			//폼값에 대한 검증은 아이디만 처리하고 있음
			if(f.id.value==""){
				alert("아이디를 입력해주세요.");
				f.id.focus();
				return false;
			}
		}
	</script>
	<form method="post" name="regFrm" action="RequestParameter.jsp" onsubmit ="return checkForm(this)">
		이름 : <input type="text" name="name" value="홍길동"/>
		<br />
		아이디 : <input type="text" name= "id" value="" />
		<br />
		관심사항 : 
		<input type="checkbox" name="favorite" value="sport" checked="checked"/>스포츠
		<input type="checkbox" name="favorite" value="economic"/>경제
		<input type="checkbox" name="favorite" value="politics" checked="checked"/>정치
		<br />
		성별 :
			<input type="radio" name="sex" value="man" />남자
			<input type="radio" name="sex" value="woman" checked="checked" />여자
		<br />
		자기소개 :
		<textarea name="self_intro"  cols="30" rows="10">나는 부유한 집안에서 태어나서...</textarea>
		<br />
			<input type="submit" value="POST방식"/>
	</form>
	
	<h2>HTTP 요청헤더 정보읽기</h2>
	<a href="RequestHeader.jsp">바로가기</a>
	<!-- 
		해당링크를 통해 접속하면 referer 헤더값을
		확인할 수 있다.
	 -->
</body>
</html>