package defaultPackage;

public class TestAnother {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ValueObject vo = new ValueObject();
		System.out.println(vo.a);
		vo = modifier(vo);
		System.out.println(vo.a);
	}
	public static ValueObject modifier(ValueObject vo ) {
		vo.a = 1 ;
		return vo;
	}

}
