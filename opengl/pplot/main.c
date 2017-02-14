#include<GL/gl.h>
#include<GL/glu.h>
#include<GL/glut.h>
#include<stdio.h>
#include<stdlib.h>
float x=0,y=0;
void desenha(){
	glClear(GL_COLOR_BUFFER_BIT);

	gluOrtho2D(-1,1,-1,1);

	glBegin(GL_LINES);
	glColor3f(1,0,0);
	glVertex2f(x,y);
	glColor3f(0,1,0);
	glVertex2f(-.9f,-.13f);
	glColor3f(0,0,1);
	glVertex2f(-.1f,-.4f);
	glEnd();

	glFlush();
}
void motion(int mouse_x,int mouse_y){
	x=+2.0*(mouse_x-glutGet(GLUT_WINDOW_WIDTH)/2.0)/glutGet(GLUT_WINDOW_WIDTH);
	y=-2.0*(mouse_y-glutGet(GLUT_WINDOW_HEIGHT)/2.0)/glutGet(GLUT_WINDOW_HEIGHT);
	desenha();
}
int main(int argc,char **argv){
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowSize(800,600);
	glutInitWindowPosition(400,400);
	glutCreateWindow("Nome de testes");
	glutDisplayFunc(desenha);
	glutPassiveMotionFunc(motion);
	glutMainLoop();

	return 0;
}
