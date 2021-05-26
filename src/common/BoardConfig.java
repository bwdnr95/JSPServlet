package common;

/*
 웹 어플리케이션 제작 시 설정값은 인터페이스형 상수를 활용하기도 한다.
 인터페이스에 정의된 상수는 public static final로 정의되므로
 객체 생성없이 클래스명으로 사용할 수 있기 때문이다
 */
public interface BoardConfig {
	//게시판 목록에서 한 페이지에 출력할 게시물의 갯수
	int page_per_size = 5;
	//한 블럭 당 출력할 페이지 번호의 갯수
	int page_per_block = 5;
}
