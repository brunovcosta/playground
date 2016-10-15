#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>

int main(int argc, char *argv[]) {
	int socketFileDescriptor = socket(PF_INET, SOCK_STREAM, 0);
	while(1){
		if (argc < 2) {
			fprintf(stderr,"ERROR, no port provided\n");
			exit(1);
		}

		struct sockaddr_in serverAddress;
		bzero((char *) &serverAddress, sizeof(serverAddress));
		serverAddress.sin_family = AF_INET;
		serverAddress.sin_addr.s_addr = INADDR_ANY;

		int portNumber = atoi(argv[1]);
		serverAddress.sin_port = htons(portNumber);

		listen(socketFileDescriptor,5);

		struct sockaddr_in clientAddress;
		socklen_t clientLength = sizeof(clientAddress);

		int newSocketFileDescriptor = accept(socketFileDescriptor, (struct sockaddr *) &clientAddress, &clientLength);

		char buffer[256];
		bzero(buffer,256);
		int n = read(newSocketFileDescriptor,buffer,255);
		printf("%s",buffer);
		n = write(newSocketFileDescriptor,"Menssagem:\n\n",18);
	}
	return 0; 
}
