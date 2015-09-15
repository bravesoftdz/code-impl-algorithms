#include <stdio.h>
#include <pthread.h>
#include <sys/types.h> 
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define THREADS 10

pthread_mutex_t mutex;	

FILE *fp;

int numero = 0;

void * worker(void *arg)
{
	
	int tempo = rand() % 20;

	int temp;

	int order = (int)arg;

	pthread_t thread_id = pthread_self(); 
	printf("Nova thread %d criada TID = %d\n", order, (unsigned int)thread_id);

	pthread_mutex_lock(&mutex);	

	temp = numero;
	temp++;
	printf("%d\n", tempo);
	printf("Thread %d\n", order);
	usleep(tempo * 100000);

	numero = temp;
	
 	/*
   	fp = fopen("test.txt", "w+");

   	if (!fp) {
	    printf("Error! opening file");
	    
   	}


   	fprintf(fp, "This is testing for fprintf...\n");
   	fputs("This is testing for fputs...\n", fp);
   	fclose(fp);

   	*/

	pthread_mutex_unlock(&mutex);	


	pthread_exit(NULL);
}


int main(int argc, char * argv[]) {
	printf("Iniciando o programa\n");

	pthread_mutex_init(&mutex,	NULL);	

	pthread_t thread[THREADS];

	long cont;
	for (cont=1; cont<=THREADS; cont++) {
		pthread_create(&thread[cont], NULL, &worker, (void *)cont);
	}

	for (cont=1; cont<=THREADS; cont++) {
		pthread_join(thread[cont], NULL);
	}
	

	printf("Finalizando o programa.\n");
	printf("Número %d\n", numero);
	pthread_exit(NULL);

	pthread_mutex_destroy(&mutex);	
}

