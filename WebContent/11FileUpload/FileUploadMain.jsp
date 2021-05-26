<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head><title>FileUpload</title></head>
<script>
    function checkForm(frm){   	 
   	 if(frm.name.value==""){
   		 alert("작성자를 입력하세요");
   		 frm.name.focus();
   		 return false;
   	 }
   	 if(frm.title.value==""){
   		 alert("제목을 입력하세요");
   		 frm.title.focus();
   		 return false;
   	 }
   	 if(frm.chumFile.value==""){
   		 alert("첨부파일은 필수 입력입니다.");
   		 return false;
   	 }
    }
</script>
<body>
    <h3>파일업로드</h3>
    <!--
    	파일업로드 실패시 리퀘스트 영역에 저장할 에러메세지출력
      -->
    <span style="color:red;">${errorMessage }</span>
    <!--
    	파일 전송을 위해서는 method는 post, enctype은 multipart/form-data로 설정해야 한다.
    	만약 get방식으로 설정하면 파일명만 텍스트 형식으로 전송되게 된다.
      -->
    <form name="fileFrm" method="post" enctype="multipart/form-data" action="UploadProcess.jsp"
   	 onsubmit="return checkForm(this);" >
   	 작성자 : <input type="text" name="name" value="머스트해브" /><br />
   	 제목 : <input type="text" name="title" /><br />
   	 카테고리(선택사항) :
   		 <input type="checkbox" name="cate" value="사진" checked />사진
   		 <input type="checkbox" name="cate" value="과제" />과제
   		 <input type="checkbox" name="cate" value="워드" />워드
   		 <input type="checkbox" name="cate" value="음원" />음원 <br />
   	 첨부파일 : <input type="file" name="chumFile" /> <br />   	 
   	 <input type="submit" value="전송하기" />
    </form>    
</body>
</html>
