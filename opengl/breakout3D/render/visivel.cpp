#include<GL/gl.h>
#include<GL/glut.h>
#include"../vetor.cpp"
class Visivel{
	public:
		virtual void atualiza();
		virtual void desenha();
};
struct Paralelepipedo : public Visivel{
	Vetor centro;
	double lx,ly,lz;
	Paralelepipedo(double x,double y, double z,double lx,double ly,double lz){
		this->centro = Vetor(x,y,z);
		this->lx=lx;
		this->ly=ly;
		this->lz=lz;
	}
	void desenha(){
		glPushMatrix();
		glScaled(lx,ly,lz);
		glTranslated(centro.x,centro.y,centro.z);
		glutSolidCube(1);
		glPopMatrix();
	}
};
