package utils;

import javax.servlet.jsp.JspWriter;

public class JSFunction {
	
	//JS를 통해 경고창을 띄우고 페이지 이동한다.
	public static void alertLocation(String msg, String url, JspWriter out) {
		try {
			String str = ""
					+"<script>"
					+" alert('"+msg+"'); "
					+" location.href='"+url+"'"
					+"</script>";
			out.println(str);
		}
		catch(Exception e) {
			
		}
	}
	//경고창을 띄우고 뒤로 이동한다.
	public static void alertBack(String msg, JspWriter out) {
		try {
			String str = ""
					+ "<script>"
					+ "	alert('"+msg+"'); "
					+ " history.back();"
					+ "</script>";
			out.println(str);//history.go(-1)을 사용해도 된다.
		}
		catch(Exception e) {}
	}
}
