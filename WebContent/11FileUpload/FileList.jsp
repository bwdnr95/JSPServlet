<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="fileupload.MyfileDAO"%>
<%@page import="fileupload.MyfileDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>DB에 등록된 파일리스트 보기</h2>
	<a href="FileUploadMain.jsp">파일등록하기</a>
	<%
	MyfileDTO dto = new MyfileDTO();
	MyfileDAO dao = new MyfileDAO(application);
	//파일리스트에 출력할
	List<MyfileDTO> fileLists = dao.myFileList();
	dao.close();
	%>
	<table border="1">
		<tr>
			<th>No</th><th>작성자</th><th>제목</th><th>카테고리</th>
			<th>원본파일명</th><th>저장된파일명</th><th>작성일</th><th></th>
		</tr>
		<% for(MyfileDTO f : fileLists){ %>
		<tr>
			<td><%=f.getIdx() %></td>
			<td><%=f.getName() %></td>
			<td><%=f.getTitle() %></td>
			<td><%=f.getCate() %></td>
			<td><%=f.getOfile() %></td>
			<td><%=f.getSfile() %></td>
			<td><%=f.getPostdate() %></td>
			<!--
			oName : DB에 저장된 원본 파일명
			sName : 저장된 파일명
			파일명이 한글인 경우 꺠짐 현상이 발생할 수 있어
			파라미터로 전달하기 전 인코딩 처리를 한다.
			  -->
			<td><a href="Download.jsp?oName=<%=URLEncoder.encode(f.getOfile(),"UTF-8")%>&sName=<%=URLEncoder.encode(f.getSfile(),"UTF-8")%>">[다운로드]</a></td>
		</tr>
		<% } %>
	</table>
</body>
</html>