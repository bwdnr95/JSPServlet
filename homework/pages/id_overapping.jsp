<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="homework.membershipDAO"%>
<%@page import="homework.membershipDTO"%>
<%
membershipDAO dao = new membershipDAO(application);
String id = request.getParameter("id");
int overapping = dao.overapping(id);
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Document</title>
<script type="text/javascript">
function idUse() {
	/*
	팝업창에서 재 입력한 아이디를 부모창으로 전달하기 위해
	opener속성을 사용한다.
	팝업창이 열릴때 부모쪽에서는 readonly속성이 부여되어 사용자는 수정할 수 없게되지만
	JS에서는 값을 수정할 수 있다.
	*/
	opener.document.registFrm.id.value = document.overlapFrm.retype_id.value;
	self.close();
}
</script>
</head>
<body>
	<h2>아이디 중복확인하기</h2>
	
	<!-- JSP의 request내장객체의 getParameter()를 통해 파라미터를 받아온다.  -->
	<%
	if(overapping==1){
		
	
	%>
	<h3>입력하신 아이디는 이미 존재합니다. : <%=request.getParameter("id") %></h3>
	
	<h3>아이디를 재 입력해주세요.</h3>
	<form name="overlapFrm">
		<input type="text" name="retype_id"  size="20"/>
		<input type="button" value="아이디 사용하기" onclick="idUse();">
	</form>
	<script>overlapFrm.retype_id.focus();</script>
	<%
	}
	else{
	%>
	
	<h3>사용 가능합니다. : <%=request.getParameter("id") %></h3>
	
	<form name="overlapFrm">
		<input type="text" name="retype_id" value="<%=id %>" size="20"/>
		<input type="button" value="아이디 사용하기" onclick="idUse();">
	</form>
	<%} %>
</body>
</html>