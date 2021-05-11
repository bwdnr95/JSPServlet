<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%! 
   		//선언부 선언
		public int getBaesu(int a , int b, int c){
	   		//누적합을 저장할 변수
	   		int sum = 0;
	   		//a에서 b까지 반복
	   		for(int i=a; i<=b; i++){
	   			//증가하는 i를 c로 나누어 떨어지는 경우에만 누적해서 더한다.
	   			if(i%c==0){
	   				sum+=i;
	   			}
	   		}
	   		//결과를 반환한다.
	   		return sum;
   		}
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>선언부에서 메소드 정의</h2>
	<h3>스크립트렛에서 결과값 출력</h3>
	
	<%
		int hapResult = getBaesu(1,100,3);
		out.println("1~100사이의 3의배수의 합:"+hapResult);
	%>
	
	<h3>표현식에서 결과값 출력</h3>
	1~200사이의 숫자 중 5의 배수의 합은?
	<%=getBaesu(1,200,5) %>
</body>
</html>