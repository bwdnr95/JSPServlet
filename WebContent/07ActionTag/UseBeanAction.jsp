<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UseBeanAction.jsp</title>
</head>
<body>
	<h2>useBean 액션태그</h2>
	
	<h3>useBean 액션태그로 좁은의미의 자바빈 객체 생성하기</h3>

	<%-- 
	아래 액션태그를 통해 빈을 생성한것을 JAVA코드로 표현하면 이와같다. 
	
	//1.MemberDTO클래스를 임포트한다. 
	import model.MemberDTO;
	//2.request영역에 저장된 member속성을 읽어온다. 
	MemberDTO memberDTO = (MemberDTO)request.getAttribute("member");
	//3.만약 객체가 null값이면...
	if(memberDTO==null){
		//4.객체를 새롭게 생성하여 request영역에 저장한다. 
		memberDTO = new MemberDTO();
		request.setAttribute("member", memberDTO);
	}
	--%>
	<!--  
		id속성 : 자바빈의 참조변수(속성명)
		class속성 : 패키지를 포함한 전체경로
		scope속성 : 자바빈을 저장할 영역명
	-->
	<jsp:useBean id="member" class="model.MemberDTO" scope="request" />	
	 

	
	<!--  
		useBean의 id속성과 setProperty의 name속성값이 서로 연결되어
		빈을 지정하게되고, setter()를 통해 값이 설정된다. 
		즉, DTO클래스에 setter()가 없으면 액션태그에서 오류가 발생한다.
	-->
	<h3>setProperty 액션태그로 자바빈 객체 속성지정하기</h3>
	<jsp:setProperty property="id" name="member" value="KIM" />
	<jsp:setProperty property="pass" name="member" value="1234" />
	<jsp:setProperty property="name" name="member" value="김희선" />
		

	<!--  
		자바빈의 getter()를 통해 값을 얻어온 후 출력한다. 
	-->
	<h3>getProperty 액션태그로 자바빈 객체 속성읽기</h3>
	<ul>
		<li>아이디 : 
			<jsp:getProperty property="id" name="member" />
		</li>		
		<li>패스워드 : 
			<jsp:getProperty property="pass" name="member"/>		
		</li>		
		<li>이름 : 
			<jsp:getProperty property="name" name="member"/>
		</li>
	</ul>

	<jsp:forward page="UseBeanActionForward.jsp"></jsp:forward>

</body>
</html>