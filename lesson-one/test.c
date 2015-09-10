#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>

int main(int argc, char **argv) { 
	fork();
	fork();
	fork();
  printf("Novo processo!\n);
return 0; }