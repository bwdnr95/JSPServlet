<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="utils.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//파일이 저장된 폴더의 물리적 경로를 얻어온다.
String saveDirectory = application.getRealPath("/Uploads");
//파라미터로 전달된 원볼파일명과 저장된 파일명을 얻어온다.
String savefilename = request.getParameter("sName");
String originalfilename = request.getParameter("oName");

try{
	//물리적경로와 저장된 파일명으로 File객체 생성
	File file = new File(saveDirectory , savefilename);
	//파일 내용을 읽어오기 위해 Input 스트림 생성
	InputStream iStream = new FileInputStream(file);
	
	//클라이언트가 사용하는 웹브라우저의 정보를 알아내기 위해 요청 헤더 얻어옴
	String client = request.getHeader("User-Agent");
	if(client.indexOf("WOW64")==-1){
		//익스플로러가 아닌 경우 파일명 인코딩
		originalfilename = 
				new String(originalfilename.getBytes("UTF-8"),"ISO-8859-1");
	}
	else{
		//익스플로러일때 파일명 인코딩
		originalfilename = 
				new String(originalfilename.getBytes("KSC5601"),"ISO-8859-1");
	}
	
	/*
	getBytes()메소드 : 
		String객체를 byte형의 배열로 반환해주는 메소드
	*/
	
	/*
	파일 다운로드를 위한 응답 헤더 설정을 한다.
	1.응답헤더 초기화
	2.브라우저가 인식하지 못하는 컨텐츠 타입을 설정함. 이를 통해
	웹브라우저는 파일 다운로드 창을 띄워주게 됨
	3.파일면 변경을 위한 응답헤더 설정
	*/
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition" , "attachment; filename=\"" + originalfilename + "\"");
	response.setHeader("Content-Length", ""+file.length() );
	
	/*
	새로운 출력스트림을 생성하기 위해 초기화 한다. JSP가 열린상태에서
	다운로드를 위해 또 다른 JSP를 열면 출려스트림이 중복으로 생성되어
	예외가 발생하게 된다.
	*/
	out.clear();
	
	
	//새로운 출력스트림을 생성해서 파일을 읽어온다.
	OutputStream oStream = response.getOutputStream();
	byte b[] = new byte[(int)file.length()];
	int readBuffer = 0;
	while((readBuffer = iStream.read(b)) >0 ){
		oStream.write(b, 0 , readBuffer);
	}
	//입출력 스트림을 닫아준다.
	iStream.close();
	oStream.close();
}
catch(FileNotFoundException e){
	JSFunction.alertBack("파일을 찾을 수 없습니다.",out);
}
catch(Exception e){
	JSFunction.alertBack("예외가 발생하였습니다..",out);
}

%>