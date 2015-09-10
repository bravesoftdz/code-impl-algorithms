#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>

int main(int argc, char **argv)
{

	pid_t pid = fork();
    printf("Novo processo criado\n");
	
	return 0;
}
