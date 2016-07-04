#include<cmath>
struct Vetor{
	double x,y,z;
	Vetor(void);
	Vetor(double x,double y,double z);
	double operator|(Vetor outro);//distância
	Vetor operator-(Vetor outro);
	Vetor operator-();
	Vetor operator+(Vetor outro);
	Vetor operator+();
	Vetor operator*(double fator);
	Vetor operator^(Vetor outro);//produto vetorial
	double operator*(Vetor outro);//produto escalar
	double operator!();//norma
	Vetor operator~();//versor
};
Vetor::Vetor(void){
	this->x=0;
	this->y=0;
	this->z=0;
}
Vetor::Vetor(double x,double y,double z){
	this->x=x;
	this->y=y;
	this->z=z;
}
double Vetor::operator|(Vetor outro){
	double dx=this->x-outro.x;
	double dy=this->y-outro.y;
	double dz=this->z-outro.z;
	return sqrt(dx*dx+dy*dy+dz*dz);
}
Vetor Vetor::operator-(Vetor outro){
	return Vetor(this->x-outro.x,this->y-outro.y,this->z-outro.z);
}
Vetor Vetor::operator-(){
	return Vetor(-this->x,-this->y,-this->z);
}
Vetor Vetor::operator+(Vetor outro){
	return Vetor(this->x+outro.x,this->y+outro.y,this->z+outro.z);
}
Vetor Vetor::operator+(){
	return Vetor(*this);
}
Vetor Vetor::operator*(double fator){
	return Vetor(fator*this->x,fator*this->y,fator*this->z);
}
Vetor operator*(int fator,Vetor v){
	return Vetor(fator*v.x,fator*v.y,fator*v.z);
}
Vetor Vetor::operator^(Vetor outro){
	/* |  i  j  k |
	 * | px py pz |
	 * | qx qy qz |
	 */
	double x = this->y*outro.z-this->z*outro.y;
	double y = this->z*outro.x-this->x*outro.z;
	double z = this->x*outro.y-this->y*outro.x;
	return Vetor(x,y,x);
}
double Vetor::operator*(Vetor outro){
	double x=this->x*outro.x;
	double y=this->x*outro.y;
	double z=this->x*outro.z;
	return x+y+z;
}
double Vetor::operator!(){
	double xx=this->x*this->x;
	double yy=this->y*this->y;
	double zz=this->z*this->z;
	return sqrt(xx+yy+zz);
}
Vetor Vetor::operator~(){
	double x=this->x;
	double y=this->y;
	double z=this->z;
	double norma = this->operator!();
	return Vetor(x/norma,y/norma,z/norma);
}
