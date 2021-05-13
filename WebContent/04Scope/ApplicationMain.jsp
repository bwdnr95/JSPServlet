<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Vector"%>
<%@page import="model.MemberDTO"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    /*
    application영역에 속성 저장하기
    -어플리케이션 영역에 저장된 속성은 모든 JSP(Servlet)에서 공유된다
    -링크를 통해 새로운 페이지로 이동하거나, 포워드,인쿨루드 등 모든
    페이지에서 영역이 공유된다. 이런 페이지들은 하나의 웹 어플리케이션
    내에 존재하기 때문이다.
    */
    
    //현재날짜 가져오기
    java.util.Date myUtilDate = new java.util.Date();
    System.out.println("myUtilDate="+myUtilDate);
    //util패키지의 날짜를 sql패키지의 날짜로 변경한 후 출력
    java.sql.Date mySqlDate = new Date(myUtilDate.getTime());
    System.out.println("mySqlDate="+mySqlDate);
    
    //DTO객체 생성
    MemberDTO first = new MemberDTO("kim","1111","김길동",mySqlDate);
    MemberDTO second = new MemberDTO("park","2222","박길동",null);
    MemberDTO third = new MemberDTO("lee","3333","이길동",null);
    
    //List 계열의 컬렉션 생성 후 DTO객체를 저장한다.
    List<MemberDTO> lists = new Vector<MemberDTO>();
    
    /*
    //여기서 생성한 3개의 컬렉션은 모두 동일한 방식으로 사용할 수 있다.
    ArrayList<MemberDTO> lists = new ArrayList<MemberDTO>();
    LinkedList<MemberDTO> lists = new LinkedList<MemberDTO>();
    
    */
    
    lists.add(first);
    lists.add(second);
    lists.add(third);
    
    //Map계열의 컬렉션 생성 후 DTO객체 저장
    Map<String,MemberDTO> maps = new HashMap<String,MemberDTO>();
    maps.put("member1",first);
    maps.put("member2",second);
    maps.put("member3",third);
    
    //application 영역에 리스트와 맵 컬렉션 저장
    application.setAttribute("lists",lists);
    application.setAttribute("maps",maps);
    
    //페이지영역,리퀘스트영역에 각각 속성 저장
    pageContext.setAttribute("pageMember",first);
    request.setAttribute("requestMember",first);
    
    
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>어플리케이션 영역의 공유</h2>
	
	<!--
		a태그를 통한 링크는 새로운 페이지에 대한 요청이므로
		page,request 영역은 공유되지 않는다.
	  -->
	<h3>사용자 클릭에 의한 이동</h3>
	<a href="ApplicationResult.jsp">사용자 클릭</a>
	
	<!--
		포워드의 경우 page영역은 공유되지 않지만, request영역은
		공유된다.
	  -->
	<h3>포워드 페이지 전달하기</h3>
	
	<%
	 request.getRequestDispatcher("ApplicationResult.jsp").forward(request, response);
	
	/*
	//포워드는 두가지 방법을 사용할 수 있다.
	RequestDispatcher dis = request.getRequestDispatcher("ApplicationResult.jsp");
	dis.forward(request,response); */
	%>
	
	<!--
		외부파일 인클루드 : include지시어를 통해 페이지를 삽입하면
			같은 페이지로 간주되므로 page,request영역이 둘다 공유되게 된다.
	  -->
	<%@ include file = "ApplicationInclude.jsp" %>
</body>
</html>