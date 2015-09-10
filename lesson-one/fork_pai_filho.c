#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>

// Referências
// http://timmurphy.org/2014/04/26/using-fork-in-cc-a-minimum-working-example/
// http://www.csl.mtu.edu/cs4411.ck/www/NOTES/process/fork/create.html

void ExecutaProcessoFilho(void);
void ExecutaProcessoPai(void);

int main(int argc, char **argv)
{

	pid_t pid_fork = fork();
	
	printf("PID do fork %d\n", pid_fork);

	if (pid_fork >= 0) {

		if (pid_fork == 0) {
			ExecutaProcessoFilho();
		} else {
			ExecutaProcessoPai();
		}
	} else {
		printf("Keep calm o fork não foi criado \n");
		return 1;
	}

	return 0;
}

void ExecutaProcessoPai(void) {
	printf("...executando processo pai \n");

}


void ExecutaProcessoFilho(void) {
	printf("...executando processo filho\n");
}