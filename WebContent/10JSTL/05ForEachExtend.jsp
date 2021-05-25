<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
	forEach태그의 두번째 문법 : 확장 for문 형태
		주로 배열이나 컬렉션에서 값을 순차적으로 접근하고 싶을때
		사용한다. varStatus에 지정된 값들 중 index속성은
		0부터 시작한다. 필수속성으로 items와 var가 있다.
  -->
	<h2>확장 for문 형태의 forEach태그</h2>
	<%
	String[] colors = {"red","green","blue","#573838"};
	%>
	
	<h3>JSP코드로 배열출력</h3>
	<% for(String c : colors){ %>
		<h4 style="color:<%=c%>;">JSP코드로 출력</h4>
	<%} %>
	
	<!--
	JSP의 스크립트렛에서 생성한 배열을 JSTL에서 사용하기위해
	set태그로 변수 선언한다. 즉 영역에 저장해야 JSTL에서 
	사용할 수 있다.
	  -->	
	<h3>JSTL 및 EL로 배열출력</h3>
	<c:set var="colors" value="<%=colors %>" />
	<c:forEach items="${colors }" var ="c">
		<h4 style="color:${c};">
			JSTL로 출력
		</h4>
	</c:forEach>
	
	<!--
	확장형 forEach태그의 varStatus 속성
	-index : 현재 루프내에서의 인덱스를 표시한다. 0부터 시작한다.
	-current : 현재 루프의 실제요소를 반환한다.
	-count : 실제 반복횟수를 반환한다. 1부터 시작한다.
	  -->
	<h3>varStatus속성 알아보기</h3>
	<c:forEach items="${colors }" var="c" varStatus="loopStatus">
		<h4>${loopStatus.count } 번째 반복</h4>
		<ul>
			<li>index : ${loopStatus.index }</li>
			<li>first : ${loopStatus.first }</li>
			<li>last : ${loopStatus.last }</li>
			<li>current : ${loopStatus.current }</li>
		</ul>
	</c:forEach>
	<h3>리스트 계열의 컬렉션</h3>
	
	<%
	//List컬렉션을 생성한 후 3개의 DTO객체를 저장한다.
	List<MemberDTO> lists = new Vector<MemberDTO>();
	lists.add(new MemberDTO("Hong","1111","홍씨",null));
	lists.add(new MemberDTO("Park","2222","박씨",null));
	lists.add(new MemberDTO("Sung","3333","성씨",null));
	%>
	<!--JSTL에서 사용하기 위해 영역에 저장  -->
	<c:set var="lists" value="<%=lists %>" />
	<h3>일반 for문 형태의 JSTL의 forEach태그</h3>
	<ul>
		<!-- index는 컬렉션크기-1 까지 존재함  -->
		<c:forEach begin="0" end="${lists.size()-1 }" var="i">
		<li>
			<!--index를 사용하므로 컬렉션변수에 []를 사용한다.  -->
			아이디:${lists[i].id },
			패스워드:${lists[i].pass },
			이름:${lists[i].name },
		</li>
		</c:forEach>
	</ul>
	<h3>확장 for문 형태의 JSTL의 forEach태그</h3>
	<ul>
		<!--확장형에서는 참조변수를 바로 사용할 수 있다.  -->
		<c:forEach items="${lists }" var="list">
			<li>
				아이디:${list.id },
				비밀번호:${list.pass },
				이름:${list.name },
			</li>
		</c:forEach>
	</ul>
	<h3>맵 계열 컬렉션 사용</h3>
	<%
	Map<String , MemberDTO> maps = new HashMap<String , MemberDTO>();
	//리스트의 객체를 인덱스로 얻어와서 맵에 저장함
	maps.put("first",lists.get(0));
	maps.put("second",lists.get(1));
	maps.put("third",lists.get(2));
	%>
	<c:set var="maps" value="<%=maps %>"/>
	<!--
		Key를 통해 객체에 접근하고 싶을떄 아래와 같이 사용함.
	  -->
	
	<h4>키값을 알고 있을 때 : EL변수 키값 혹은 EL변수["키값"]</h4>
	<ul>
		<li>
		아이디:${maps.first.id },
		비밀번호:${maps.first.pass },
		이름:${maps.first.name },
		</li>
		<li>
		아이디:${maps.second.id },
		비밀번호:${maps.second.pass },
		이름:${maps.second.name },
		</li>
		<li>
		아이디:${maps.third.id },
		비밀번호:${maps.third.pass },
		이름:${maps.third.name },
		</li>
	</ul>
	
	<%--
	루프내에서 객체를 전달할 변수 map을 통해 맵의 key와 value를
	알아낼 수 있다.
		key=> ${맵의이름.key}
		value=> ${맵의이름.value}
	 --%>
	<h4>키값을 모를때 : 확장 for문 사용</h4>
	<ul>
		<c:forEach items="${maps }" var="map">
		<li>
			<dl>
				<dt>key값 : ${map.key }</dt>
				<dd>Value값=>
						아이디:${map.value.id },
						비밀번호:${map.value.pass },
						이름:${map.value.name }
				</dd>
			</dl>
		</li>
		</c:forEach>
	</ul>
</body>
</html>