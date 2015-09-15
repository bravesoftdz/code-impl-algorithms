#include <stdio.h>
#include <pthread.h>
#include <sys/types.h> 
#include <unistd.h>


void * worker(void *arg)
{
	pthread_t thread_id = pthread_self(); 

	printf("ID Processo principal %d\n", getpid());
	printf("Nova thread criada TID = %d\n", (unsigned int)thread_id);

	pthread_exit(NULL);
}


int main() {
	printf("Iniciando o programa\n");

	pthread_t thread;

	pthread_create(&thread, NULL, &worker, NULL);
	pthread_join(thread, NULL);
	pthread_exit(NULL);
}


