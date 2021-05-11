package common;

public class MyClass {

	public static void main(String[] args) {

		String str = "다이나믹 웹 프로젝트에서도 Java클래스를 만들 수 있다.";
		System.out.println(str);
		
	}
	public static int myFunc(int a, int b) {
		
		int sum =0;
		for(int i=a; i<=b; i++) {
			sum+= i;
		}
		return sum;
	}
}
