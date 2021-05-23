<%@page import="homework.membershipDAO"%>
<%@page import="homework.membershipDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//파라미터 받기
String id = request.getParameter("id");//일련번호
String searchField = request.getParameter("searchField");//검색필드
String searchWord = request.getParameter("searchWord");//검색어


String queryStr= "";
if(searchWord!=null){
	//검색 파라미터 추가하기
	queryStr = "searchField="+searchField+"&searchWord="+searchWord;
}
membershipDAO dao = new membershipDAO(application);

membershipDTO dto = dao.memberView(id);
dao.close();
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>회원제 게시판</title>
	<script>
	function isDelete(){
	   var c = confirm("정말로 삭제하시겠습니까?");
	   //alert("함수 전 디버깅");	
	   if(c){
		  // alert("함수첫번째디버깅");
	      var f = document.writeFrm;
	      f.method = "post";
	      f.action = "DeleteProcess.jsp";
	     // alert("함수마지막디버깅");
	      f.submit();
	   }
	}
	</script>
</head>
<body>
	<h2>회원제 게시판- 상세보기</h2>
	<!--
		회원제 게시판에서 게시물 삭제를 위해 상세보기에
		게시물의 일련번호를 hidden 입력상자로 삽입한다.
	  -->
	<form name="writeFrm">
	<input type="hidden" name="id" value="<%=id %>"/>
	<table border="1" width ="90%">
		<tr>
			<td>아이디</td>
			<td><%=dto.getId() %></td>
			<td>이름</td>
			<td><%=dto.getName() %></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><%=dto.getPass() %></td>
			<td>생년월일</td>
			<td><%=dto.getBirth() %></td>
		</tr>
		<tr>
			<td>우편번호</td>
			<td><%=dto.getAddr1() %></td>
			<td>전체주소</td>
			<td><%=dto.getAddr2() %> <%=dto.getAddr3() %></td>	
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=dto.getEmail1()%>@<%=dto.getEmail2() %></td>
			<td>휴대폰번호</td>
			<td><%=dto.getPh_num1() %>-<%=dto.getPh_num2() %>-<%=dto.getPh_num3() %></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><%=dto.getAno_num1()%>-<%=dto.getAno_num2() %>-<%=dto.getAno_num3() %></td>
			<td>회원가입일</td>
			<td><%=dto.getRegidate() %></td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<button type="button" onclick="location.href='memberList.jsp?<%=queryStr%>';">리스트바로가기</button>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>