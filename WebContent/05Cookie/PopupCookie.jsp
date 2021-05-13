<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
//오늘하루 열지않음을 체크한 경우 전송되는 폼값
String chkVal = request.getParameter("isToday");

if(chkVal!=null && chkVal.equals("1")){
	//쿠키를 생성한다. 쿠키명:PopupClose, 쿠키값 : off,유효시간 : 하루
	CookieManager.makeCookie(response,"PopupClose","off",86400);
	System.out.println("하루동안열지않음");
	out.println("하루동안열지않음");
}
%>