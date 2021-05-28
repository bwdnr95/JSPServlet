<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일첨부형 게시판</title> 
</head>
<body>
<h2>파일첨부형 게시판-내용보기(View)</h2>
<table border="1" width="90%">
    <colgroup>
   	 <col width="15%"/>
   	 <col width="35%"/>
   	 <col width="15%"/>
   	 <col width="*"/>
    </colgroup>
    <tr>
   	 <td>번호</td>
   	 <td>${dto.idx }</td>
   	 <td>작성자</td>
   	 <td>${dto.name }</td>
    </tr>
    <tr>
   	 <td>작성일</td>
   	 <td>${dto.postdate }</td>
   	 <td>조회수</td>
   	 <td>${dto.visitcount }</td>
    </tr>
    <tr>
   	 <td>제목</td>
   	 <td colspan="3">${dto.title }</td>
    </tr>
    <tr>
   	 <td>내용</td>
   	 <td colspan="3" height="100">${dto.content }</td>
    </tr>
    <tr>
   	 <td>첨부파일</td>
   	 <td>
   	 <!-- 첨부한 파일이 있을때만 다운로드 링크 활성화  -->
   	 <c:if test="${not empty dto.ofile }">
   		 ${dto.ofile }
   		 <a href="../mvcboard/download.do?ofile=${dto.ofile }&sfile=${dto.sfile }&idx=${dto.idx }">
   			 [다운로드]
   		 </a>   	 
   	 </c:if>   	 
   	 </td>
   	 <td>다운로드수</td>
   	 <td>${dto.downcount }</td>
    </tr>
    <tr>
    	<td colspan="4" align = "center">
    	<!--
    	비회원제 게시판의 경우 수정, 삭제를 위해 먼저 비밀번호 검증을
    	진행해야 한다. 따라서 동일한 요청명으로 진입하는 대신 mode 파라미터를
    	통해 수정/삭제를 구분하여 분기한다.
    	  -->
    		<button type="button" onclick="location.href='../mvcboard/pass.do?mode=edit&idx=${param.idx}';">
    			수정하기
    		</button>
    		<button type="button" onclick="location.href='../mvcboard/pass.do?mode=delete&idx=${param.idx}';">
    			삭제하기
    		</button>
    		<button type="button" onclick="location.href='../mvcboard/list.do';">
    			리스트바로가기
    		</button>
    	</td>
    </tr>
 </table>
 </body>
</html>
