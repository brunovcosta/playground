#include"render/janela.cpp"
int main(){
	Janela *janela = new Janela("Breackout 3D!",640,480);
	Paralelepipedo *p = new Paralelepipedo(.5,.5,.5,.25,.25,.25);
	janela->addObjeto(p);
	janela->inicia();
}
