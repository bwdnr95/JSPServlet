<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	//한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");
	
	/*
	전송방식에 상관없이 getParameter()로 폼값을 받을 수 있다.
	만약 값이 입력되지 않았다면 길이가 0인 String객체를 반환하고
	파라미터명이 틀린경우에는 null을 반환한다.
	*/
	String id = request.getParameter("id");
	//입력한 이름을 받은 후
	String name = request.getParameter("name");
	if(!(name==null||name.equals(""))){
		//폼값이 있다면 브라우저에 출력하고
		out.println("이름:" + name);
	}
	else {
		//전송된 이름이 없다면 아래와 같이 JS를 브라우저에 출력한다
		
		//스크립트릿 내부에 JS를 작성할때는 out.println()을 사용한다.
		/* out.println("<script>");
		out.println("alert('이름을 입력하세요.');");
		out.println("history.back();");
		out.println("</script>"); */
	%>	
	<!-- 위와 같은 방법은 불편하므로 스크립트릿을 분리한 후 HTML영역을
	만들어 JS를 기술한다.  -->
		<script>
		alert('이름을 입력하세요');
		history.back();
		
		</script>
		
	<%	
	}
	/*
	radio는 항목이 여러개이나, 선택가능한 항목이 1개이기 때문에
	getParameter()를 통해 폼값을 받을 수 있다.
	*/
	String sexStr = request.getParameter("sex");
	
	/*
	checkbox는 2개 이상의 항목을 선택할 수 있으므로 getParameterValues()
	를 사용해야 한다. 항목 중 체크된 것만 서버로 전송되고, 파라미터명이 틀리거나
	값이 전송되지 않으면 null을 반환한다.
	*/
	String[] favo = request.getParameterValues("favorite");
	String favStr = "";
	
	if(favo !=null){
		for(int i=0; i<favo.length ; i++){
			/*
			전송된 항목을 하나의 문자열로 연결하여 저장한다.
			문자열의 마지막 부분에 , 를 제거하기 위해 if문을
			통해 처리한다.
			*/
			if(i==favo.length-1){
				favStr += favo[i];
			}
			else{
				favStr += favo[i]+",";
			}
		}
	}
	/*
	textarea를 통해 입력받은 값은 엔터키가 포함되어 있으므로
	출력시에는 특수기호를 <br/>로 변환 후 출력해야 한다.
	*/
	String self_intro = request.getParameter("self_intro").replace("\r\n","<br/>");
	
	/*
	getParameterNames() : 폼값의 이름을 한꺼번에 받아올때 사용하는
		메소드로 반환타입은 Enumeration 형이다.
	hasMoreElements() : 객체에 남은 폼값의 이름이 있는지 확인한다.
	nextElement() : 받은 폼값 중 다음 폼값의 이름을 반환한다.
	*/
	Enumeration names = request.getParameterNames();

	while(names.hasMoreElements()){
		//폼의 name속성을 하나씩 읽어서 String형으로 반환한다.
		String paramName = (String)names.nextElement();
		//읽어온 내용을 콘솔에 출력한다.
		System.out.println("파라미터명:"+paramName);
		
		if(paramName.equals("sex") || paramName.equals("favorite")){
			//체크박스와 라디오는 getParameterValues()를 통해 읽어온다.
			System.out.println("getParameterValues()로 읽기");
			out.println("파라미터명을 getParameterValues()로 얻어서 값 출력함<br/>");
		}
		else{
			//그외 나머지는 getParameter()로 읽어온다.
			System.out.println("getParameter()로 읽기");
			out.println("파라미터명을 메소드로 얻어서 값출력 :");
			out.println(request.getParameter(paramName)+"<br/>");
		}
	}


	%>
	<ul>
		<li>이름 : <%=name %></li>
		<li>아이디 : <%=id %></li>
		<li>성별 : <%=sexStr %></li>
		<li>관심사항 : <%=favStr %></li>
		<li>자기소개 : <%=self_intro %></li>
	</ul>


	
</body>
</html>