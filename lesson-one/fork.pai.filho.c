#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>

void executar_processo_pai(int pid_filho);
void executar_processo_filho(void);

int main(int argc, char **argv)
{
	pid_t pid;

	if (pid = fork()) {

		executar_processo_pai(pid);
	    if (pid = fork()) {

	        executar_processo_pai(pid);
	        if (pid = fork()) {
	        	executar_processo_pai(pid);
	    	} else {
	    		executar_processo_filho();
	    	}
	    } else {
	    	executar_processo_filho();
	    }
	} else {
		executar_processo_filho();
	}

	return 0;
}

void executar_processo_pai(int pid_filho) {
	printf("Processo pai %d criou o processo filho %d \n", getpid(), pid_filho);
}

void executar_processo_filho(void) {
	printf("“Processo filho %d \n", getpid() );

}