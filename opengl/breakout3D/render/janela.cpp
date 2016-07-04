#include<GL/gl.h>
#include<GL/glut.h>
#include<string>
#include<vector>
#include<iostream>
#include"visivel.cpp"
using namespace std;
struct novoTipo{
	GLenum tipo;
	int posicao;
};
class Janela{
	private:
		string nome;
		int largura;
		int altura;
		vector<Visivel*> filhos;
	public:
		Janela(string,int,int);
		void inicia();
		static void atualiza();
		static void desenha();
		int getLargura();
		int getAltura();
		void addObjeto(Visivel*);
};
Janela *janela;
Janela::Janela(string nome,int largura,int altura){
	this->largura=largura;
	this->altura=altura;
}
void Janela::inicia(){
	int arg;
	glutInit(&arg,NULL);
	glutCreateWindow(nome.c_str());
	glutReshapeWindow(largura,altura);
	janela = this;
	glutDisplayFunc(desenha);
	glutIdleFunc(Janela::atualiza);
	glutMainLoop();
}
void Janela::atualiza(){
	for(int i=0;i<janela->filhos.size();i++){
		janela->filhos[i]->atualiza();
	}
}
void Janela::desenha(){
	glClear(GL_COLOR_BUFFER_BIT);

	for(int i=0;i<janela->filhos.size();i++){
		janela->filhos[i]->desenha();
	}

	glFlush();
}
int Janela::getLargura(){
	return largura;
}
int Janela::getAltura(){
	return altura;
}
void Janela::addObjeto(Visivel *obj){
	filhos.push_back(obj);
}
