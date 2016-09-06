public class Main{
	static{
		System.loadLibrary("teste");
	}
	private native void funcloka();
	public static void main(String[] args){
		new Main().funcloka();
	}
}
