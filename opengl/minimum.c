#include<GL/gl.h>
#include<GL/glut.h>
void desenha(){
	glClear(GL_COLOR_BUFFER_BIT);
	glBegin(GL_TRIANGLES);
		glColor3f(1,0,0);
		glVertex2f(-.5f,-.7f);
		glColor3f(0,1,0);
		glVertex2f(-.9f,-.13f);
		glColor3f(0,0,1);
		glVertex2f(-.1f,-.4f);
	glEnd();
	glFlush();
}
int main(int argc,char **argv){
	glutInit(&argc,argv);
	glutCreateWindow("Menor aplicação possível :D");
	glutDisplayFunc(desenha);
	glutMainLoop();

	return 0;
}
