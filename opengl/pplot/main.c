#include<GL/gl.h>
#include<GL/glu.h>
#include<GL/glut.h>
#include<stdio.h>
#include<stdlib.h>
char* console(char* cmd){
	FILE* stream;
	stream = popen(cmd,"r");
	if(stream==NULL){
		printf("Erro\n");
		exit(1);
	}
	fseek(stream,0L,SEEK_END);
	int filesize = ftell(stream);
	char* output=(char*)malloc(filesize+1);
	size_t size=fread(output,1,size,stream);
	output[size]=0;
	return output;
}
void desenha(){
	glClear(GL_COLOR_BUFFER_BIT);

	//glLoadIdentity();
	//gluOrtho2D(-2,2,-2,2);

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
void mouse(int button,int state,int x,int y){
	printf("button:%d\n",button);
	printf("state:%d\n",state);
	printf("(x,y):(%d,%d)\n",x,y);
}
int main(int argc,char **argv){
	printf("%s\n",console("/bin/ls /"));
	glutInit(&argc,argv);
	glutInitDisplayMode(GLUT_SINGLE|GLUT_RGB);
	glutInitWindowSize(800,600);
	glutInitWindowPosition(400,400);
	glutCreateWindow("Nome de testes");
	glutDisplayFunc(desenha);
	glutMouseFunc(mouse);
	glutMainLoop();

	return 0;
}
