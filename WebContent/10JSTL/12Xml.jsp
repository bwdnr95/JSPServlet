<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--
XML(eXtensible Markup Language)
-사전적 의미로는 확장이 가능한 마크업 언어라는 뜻
-HTML과 비슷하게 태그로 표현하지만, XML은 개발자가 직접
	태그를 정의할 수 있음
-HTML과 같이 보여주는 목적이 아닌, 데이터를 전달하는 것이
	주 목적임. 주로 서버간 통신에 사용됨.
	
파싱(Parsing)
-주어진 데이터를 분석하여, 원하는 데이터의 특정 패턴이나
	순서로 추출해서기술하는 것을 말한다.
-즉 쉽게 말해 XML이나 HTML 등으로 구성된 데이터를 분석해
	내가 원하는 부분만 추출하는 것을 말한다.
  -->
  
  	<!-- XML데이터를 set태그를 통해 변수로 저장함  -->
	<c:set var="booklist">
		<booklist>
			<book>
				<name>사피엔스</name>
				<author>유발 하라리</author>
				<price>19800</price>
			</book>
			<book>
				<name>총,균,쇠</name>
				<author>제러드 다이아몬드</author>
				<price>25200</price>
			</book>
		</booklist>
	</c:set>
	
	<!-- 해당 데이터를 파싱할 때 사용. XML데이터를 blist로 지정함  -->
	<x:parse xml="${booklist }" var="blist" />
	
	<h4>파싱 1</h4>
	
	<!--
	출력하고자 하는 XML의 노드에 접근하여 해당 엘리먼트를 출력함.
	XML의 노드에 접근할때 아래와 같이 경로형태로 접근하는 것을 XPath라고 함.
	book[1] => 첫번째 엘리먼트를 표시함. 배열처럼 0부터 시작하지 않음.
	  -->
	제목 : <x:out select="$blist/booklist/book[1]/name"/>
	<br />
	저자 : <x:out select="$blist/booklist/book[1]/author"/>
	<br />
	가격 : <x:out select="$blist/booklist/book[1]/price"/>
	
	<h4>파싱2</h4>
	<table border="1">
		<tr>
			<th>제목</th><th>저자</th><th>가격</th>
		</tr>
		
		<!--
		forEach 태그를 통해 선택한 노드의 갯수만큼 반복함.
		반복되는 엘리먼트는 var에 지정한 item에 저장됨.
		
		  -->
		<x:forEach select="$blist/booklist/book" var="item">
			<tr>
				<td> <x:out select="$item/name"/> </td>
				<td> <x:out select="$item/author"/> </td>
				<td>
					<!-- choose를 통해 조건식을 사용함. core와는 다르게
						select 속성을 사용한다.
					  -->
					<x:choose>
						<x:when select="$item/price >= 20000">
							2만원 이상 <br />
						</x:when>
						<x:otherwise>
							2만원 미만 <br />
						</x:otherwise>
					</x:choose>
				</td>
			</tr>
		</x:forEach>
	</table>
	
	<h4>파싱3</h4>
	<c:import url="./inc/BookList.xml" var="xmldata" charEncoding="UTF-8" />
	<x:parse xml="${xmldata }" var="xdate" />
	<table border="1">
		<x:forEach select="$xdate/booklist/book" var="item" >
		<tr>
			<td> <x:out select="$item/name" /> </td>
			<td> <x:out select="$item/author" /> </td>
			<td> <x:out select="$item/price" /> </td>
			<td>
				<x:if select="$item/name='총,균,쇠'">
					구매함
				</x:if>
			</td>
		</tr>
		</x:forEach>
	</table>
</body>
</html>