#include <stdio.h>
#include <pthread.h>
#include <sys/types.h> 
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>

#define SEED 35791246
#define THREADS 10

volatile long double pi_valores[THREADS];

void * worker(void *arg)
{


  double x,y;
  double z;
  
  int indice = (int)arg;
  int posicao = indice + 1;

  int count=0;
  
  x = (double)rand()/RAND_MAX;
  y = (double)rand()/RAND_MAX;
  z = x*x+y*y;
  
  if (z<=1) count++;
  
  pi_valores[indice]=(double)count/indice*4;

  pthread_exit(NULL);
}


int main(int argc, char * argv[]) {
 
  pthread_t thread[THREADS];

  long indice;
  for (indice=0; indice<THREADS; indice++) {
      pthread_create(&thread[indice], NULL, &worker, (void *)indice);
  }

  for (indice=0; indice<THREADS; indice++) {
    pthread_join(thread[indice], NULL);
  }

  long double pi = 0.0;
  for (indice=0; indice<THREADS; indice++) {
    pi += pi_valores[indice];
  }

  printf("Valor do PI calculado %32.30Lf \n", pi);
  printf("Valor do PI 3.141592653589793238462643383279...\n");


  pthread_exit(NULL);
}

