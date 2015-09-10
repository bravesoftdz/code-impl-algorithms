#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>


int main(void)
{

	if (fork()) {
		
	} else {
		if(fork()) {;
			
		} else {
			printf("Processo %d filho de %d \n", getpid(), getppid());
		}
		printf("Processo %d filho de %d \n", getpid(), getppid());
	}


	return 0;
}

