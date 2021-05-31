<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function commentValidate(f){
	if(f.pass.value==""){
		alert("비밀번호를 입력하세요");
		f.pass.focus();
		return false;
	}
} 
</script>
</head>
<body>
<form name="commentFrm" method="post" action="./commentDeleteAction.comm" onsubmit="return commentValidate(this);">
	<input type="hidden" name="board_idx" value= ${map.board_idx } />
	<input type="hidden" name="idx" value= ${map.idx } />
	<table border="1" width="90%">
	<colgroup>
		<col width="30%"/>
		<col width="40%"/>
		<col width="*"/>
	</colgroup>
	<tr>
		<td>작성자 : <input type="text" name="name" size="10" value= ${map.name} readonly="readonly" style="background-color: gray;"/></td>
		<td colspan="2">비밀번호 : <input type="password" name="pass" size="10"  /></td>
	</tr>
	<tr>
		<td colspan="2">
			<textarea name="comments" style="width:100%;height:70px; background-color: gray;" readonly="readonly" >${map.comments }</textarea>
		</td>
		<td><input type="submit" value="삭제하기" style="width:80px;height:77px;" /></td>
	</tr>
</table>
 </form>
</body>
</html>