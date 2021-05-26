<%@page import="fileupload.MyfileDAO"%>
<%@page import="fileupload.MyfileDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//파일이 저장될 디렉토리의 물리적경로(절대경로)를 얻어온다.
String saveDirectory = application.getRealPath("/Uploads");
//전송될 파일의 최대용량을 지정한다. 단, 파일이 3개라면
//3개를 합친 용량을 설정해야 한다.
int maxPostSize = 1024 * 1000;

/*
만약 제한 용량을 초과한다면 아래와 같은 예외가 발생하게 된다.
java.io.IOException : Posted content length of 2401886 exceeds limits 
*/
//인코딩 방식 설정
String encoding = "UTF-8";

try{
	/*
	위에서 준비한 객체들을 기반으로 MultipartRequest객체를 생성한다.
	해당 객체가 정상적으로 생성되면 파일은 서버로 업로드된다.
	만약 예외가 발생한다면 최대용량을 초과했거나, 디렉토리 경로가
	잘몬된 경우가 대부분이다.
	*/
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
	
	//서버에 전송완료된 파일명을 가져온다. (원본파일명)
	String fileName = mr.getFilesystemName("chumFile");
	//현재날짜와 시간을 통해 새로운 파일명을 생성한다.
	String nowTime = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	//서버에 저장된 파일명에서 확장자를 가져오기 위해 마지막.의 위치를 찾는다.
	int idx = fileName.lastIndexOf(".");
	//새로운 파일명과 파일의 확장자를 합쳐 저장될 파일명을 만든다.(저장될파일명)
	String newFileName = nowTime + fileName.substring(idx , fileName.length());
	
	//각각의 파일의 파일객체를 생성한 후..
	File oldFile = new File(saveDirectory+File.separator+fileName);
	File newFile = new File(saveDirectory+File.separator+newFileName);
	//파일명을 변경한다.
	oldFile.renameTo(newFile);
	
	/*
	파일을 제외한 나머지 폼값을 받아온다. 단, 이때 request객체를 통해서가 아니라
	MultipartRequest 객체를 통해 받아와야한다.
	*/
	String name = mr.getParameter("name");
	String title = mr.getParameter("title");
	String[] cateArray = mr.getParameterValues("cate");
	StringBuffer cateBuf = new StringBuffer();
	if(cateArray==null){
		cateBuf.append("선택없음");
	}
	else{
		//체크박스를 통해 선택한 항목을 콤마를 통해 구분해서 저장.
		for(String s : cateArray){
			cateBuf.append(s + ", ");
		}
	}
	//DTO객체 생성 및 폼값 저장
	MyfileDTO dto = new MyfileDTO();
	dto.setName(name);
	dto.setTitle(title);
	dto.setCate(cateBuf.toString());
	dto.setOfile(fileName);//원본 파일명
	dto.setSfile(newFileName);//저장된 파일명
	//DAO객체 생성 및 입력 처리
	MyfileDAO dao = new MyfileDAO(application);
	dao.myfileInsert(dto);
	dao.close();
	
	response.sendRedirect("FileList.jsp");
}
catch(Exception e){
	e.printStackTrace();
	//업로드에 실패한 경우 request영역에 속성 저장 후 포워드
	request.setAttribute("errorMessage", "파일업로드오류");
	request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
}
%>
