/*
    This algorithm was written by Henrique Lorenzetti <henriquellanger@gmail.com>
*/

#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <stdint.h>

#define TAMANHO 9

// variáveis globais
unsigned char buf[81]; // vetor de bytes para armazenar os resultados da etapa 1
unsigned char buf1[54] = {0}; // vetor de bytes para armazenar os resultados da etapa 2
unsigned char buf2[27] = {0}; // vetor de bytes para armazenar os resultados da etapa 3
unsigned char *sudoku;
int errado = 0; // flag certo/errado
int batch[3];

int char_to_int(char c)
{
    return (int) c - 48;
}

// Pega um numero N do diagrama e salva o byte 0x01<<(N-1) em um vetor buf.
void * step1(void *arg_) {

    int arg = (intptr_t) arg_;
    while (1) {
        buf[arg] = buf[arg] << char_to_int(sudoku[arg])-1;
        arg = arg + batch[0];
        if (arg > 80) {
            pthread_exit(NULL);
        }
    }
}

// Faz o XOR bit-a-bit entre grupos de 3 bytes do vetor buf,
// correspondendo aos 1/3s de linha e coluna, e salva o resultado no vetor buf2.
void * step2(void *arg_) {

    int arg = (intptr_t) arg_;
    while (1) {
        if (arg < 27) { // 1/3s de linha (esq p dir, cima p baixo)
           buf1[arg] = buf[3*arg] ^ buf[3*arg+1] ^ buf[3*arg+2];
        }
        else { // 1/3s de coluna (esq p dir, cima p baixo)
            if (arg <= 35) { // primeira linha de 1/3s de coluna
                buf1[arg] = buf[arg-27] ^ buf[arg-18] ^ buf[arg-9];
            }
            if (arg > 35 && arg <= 44) { // segunda linha de 1/3s de coluna
                buf1[arg] = buf[arg-9] ^ buf[arg] ^ buf[arg+9];
            }
            if (arg > 44) { // terceira linha de 1/3s de coluna
                buf1[arg] = buf[arg+9] ^ buf[arg+18] ^ buf[arg+27];
            }
        }
        arg = arg + batch[1];
        if (arg > 53) {
            pthread_exit(NULL);
        }
    }
}

// Faz o XOR bit-a-bit entre grupos de 3 bytes do vetor buf2;
// correspondendo as linhas, colunas e quadros do diagrama;
// e compara o resultado com 0xFF (1111 1111). Qualquer valor
// diferente desse significa um erro.
void * step3(void *arg_) {

    int arg = (intptr_t) arg_;
    while (1) {
        if (arg < 9) { // linhas (cima p baixo)
            buf2[arg] = buf1[3*arg] ^ buf1[3*arg+1] ^ buf1[3*arg+2];
        }
        if (arg >= 9 && arg < 18) { // colunas (esq p dir)
            buf2[arg] = buf1[arg+18] ^ buf1[arg+27] ^ buf1[arg+36];
        }
        if (arg >= 18) { // quadros (esq p dir, cima p baixo)
            buf2[arg] = buf1[3*(arg-9)] ^ buf1[3*(arg-9)+1] ^ buf1[3*(arg-9)+2];
        }
        // comparacao
        if (buf2[arg] != 0xFF) {
            if (arg < 9) {
                printf("Erro na linha %d (Thread %d)\n", arg + 1, arg + 1);
                errado++;
            }
            if (arg >=9 && arg < 18) {
                printf("Erro na coluna %d (Thread %d)\n", arg-9 + 1, arg + 1);
                errado++;
            }
            if (arg >= 18) {
                printf("Erro no quadro %d (Thread %d)\n", arg-18 + 1, arg + 1);
                errado++;
            }
        }
        arg = arg + batch[2];
        if (arg > 26) {
            pthread_exit(NULL);
        }
    }
}
int main(int argc, char * argv[]) {
    int i;
    // Carrega o vetor buf com 0x01
    for (i = 0; i < 81; i++) {
        buf[i] = 0x01;
    }
    int step; // indice das tarefas
    int numJobs[3] = {81, 54, 27}; // numero maximo de tarefas permitidas em cada etapa
    void* job[3] = {&step1, &step2, &step3}; // endereco das funcoes das 3 etapas
    int numero_threads = atoi(argv[1]);
    sudoku = argv[2];
    // numero de threads a serem alocadas por vez em cada tarefa
    for (i = 0; i < 3; i++) {
        batch[i] = numero_threads;
        if (batch[i] > numJobs[i]) {
            batch[i] = numJobs[i];
        }
    }
    // cria vetor threads com o numero de threads a serem criadas na etapa 1 (maior)
    pthread_t threads[batch[0]];
    // loop de execucao das tarefas
    for (step = 0; step < 3; step++) {
        for (i = 0; i < batch[step]; i++) {
            pthread_create(&threads[i], NULL, job[step], (void *) (intptr_t) i);
        }
        for (i=0; i < batch[step]; i++) {
            pthread_join(threads[i], NULL);
        }
    }
    // variavel errado inicializada em 0 e incrementada ao se achar qualquer erro.
    // errado == 0 significa ausencia de erros.
    if (!errado) {
        printf("certo!\n");
    }
    pthread_exit(NULL);

}

