#include <stdio.h>
#include <pthread.h>
#include <stdint.h>

#define TAMANHO 9

// variáveis globais
unsigned char buf0[81] = {0}; // vetor de bytes para armazenar os resultados da etapa 1
unsigned char buf1[54] = {0}; // vetor de bytes para armazenar os resultados da etapa 2
unsigned char buf2[27] = {0}; // vetor de bytes para armazenar os resultados da etapa 3
unsigned char done0[81] = {0}; // vetor que indica que resultados da etapa 1 foram salvos
unsigned char done1[54] = {0}; // vetor que indica que resultados da etapa 2 foram salvos
unsigned char *sudoku;
int errado = 0; // flag certo/errado
int numero_threads; 

int char_to_int(char c) 
{
    return (int) c - 48;
}

void * work(void *arg_) {
    int arg = (intptr_t) arg_;
    int argi = arg;
    int aux;
    // Etapa 1 
    // Busca um numero N do diagrama e salva o byte 0x01<<(N-1) em um vetor buf.
    while (arg < 81) {  
        buf0[arg] = 0x01 << char_to_int(sudoku[arg])-1;
        done0[arg] = 1; // Sinaliza que byte foi salvo
        arg = arg + numero_threads;
    }
    arg = argi;
    // Mata threads em excesso ao fim da etapa 1
    if (arg > 53) {
        pthread_exit(NULL);
    }
    // Etapa 2
    // Faz o XOR bit-a-bit entre grupos de 3 bytes do vetor buf, correspondentes
    // aos 1/3s de linha e coluna, e salva os resultados no vetor buf2.
    while (arg < 54) {
        if (arg < 27) { // 1/3s de linha (esq p dir, cima p baixo)
            aux = 3*arg;
            // Verifica se todos os 3 bytes necessarios bytes estao prontos, 
            // e entrega o processador em caso negativo.
            while (!(done0[aux] && done0[aux+1] && done0[aux+2])) {
                sched_yield();
            }
               buf1[arg] = buf0[aux] ^ buf0[aux+1] ^ buf0[aux+2];
               done1[arg] = 1; // Sinaliza que 1/3 de linha/coluna foi computado
        } 
        else { // 1/3s de coluna (esq p dir, cima p baixo)
            if (arg <= 35) { // primeira linha de 1/3s de coluna
                while (!(done0[arg-27] && done0[arg-18] && done0[arg-9])) {
                    sched_yield();
                }
                buf1[arg] = buf0[arg-27] ^ buf0[arg-18] ^ buf0[arg-9];
                done1[arg] = 1;
            }
            if (arg > 35 && arg <= 44) { // segunda linha de 1/3s de coluna
                while (!(done0[arg-9] && done0[arg] && done0[arg+9])) {
                    sched_yield();
                }
                buf1[arg] = buf0[arg-9] ^ buf0[arg] ^ buf0[arg+9];
                done1[arg] = 1;
            }
            if (arg > 44) { // terceira linha de 1/3s de coluna
                while (!(done0[arg+9] && done0[arg+18] && done0[arg+27])) {
                    sched_yield();
                }
                buf1[arg] = buf0[arg+9] ^ buf0[arg+18] ^ buf0[arg+27];
                done1[arg] = 1;
            }
        }
        arg = arg + numero_threads;
    }
    // Mata threads em excesso ao fim da etapa 2
    arg = argi;
    if (arg > 27) {
        pthread_exit(NULL);
    }
    // Etapa 3
    // Faz o XOR bit-a-bit entre grupos de 3 bytes do vetor buf2;
    // correspondendo as linhas, colunas e regioes do diagrama;
    // e compara o resultado com 0xFF (1111 1111). Qualquer valor
    // diferente desse significa um erro.
    while (arg < 27) {
        if (arg < 9) { // linhas (cima p baixo)
            aux = 3*arg;
            while (!(done1[aux] && done1[aux+1] && done1[aux+2])) {
                    sched_yield();
                }
            buf2[arg] = buf1[aux] ^ buf1[aux+1] ^ buf1[aux+2];
        }
        if (arg >= 9 && arg < 18) { // colunas (esq p dir)
            while (!(done1[arg+18] && done1[arg+27] && done1[arg+36])) {
                    sched_yield();
                }
            buf2[arg] = buf1[arg+18] ^ buf1[arg+27] ^ buf1[arg+36];
        }
        if (arg >= 18) { // regioes (esq p dir, cima p baixo)
            aux = 3*arg;
            while (!(done1[aux-27] && done1[aux-26] && done1[aux-25])) {
                    sched_yield();
                }
            buf2[arg] = buf1[aux-27] ^ buf1[aux-26] ^ buf1[aux-25];
        }
        // comparacao
        if (buf2[arg] != 0xFF) {
            if (arg < 9) {
                printf("Thread %d encontrou erro na linha %d!\n", argi, arg+1);
                errado++;
            }
            if (arg >=9 && arg < 18) {
                printf("Thread %d encontrou erro na coluna %d!\n", argi, arg-8);
                errado++;
            }
            if (arg >= 18) {
                printf("Thread %d encontrou erro na regiao %d!\n", argi, arg-17);
                errado++;
            }
        }
        arg = arg + numero_threads;
        if (arg > 26) {
            pthread_exit(NULL);
        }
    } 
}

int main(int argc, char * argv[]) {
    int i, j;
    numero_threads = atoi(argv[1]);
    sudoku = argv[2];
    // Limite superior para o numero de threads
    if (numero_threads > 81) {
        printf("\nThreads em excesso para tarefa, utilizando apenas 81.\n");
        numero_threads = 81;
    } 
    else {
    printf("\nUtilizando %d threads.\n", numero_threads);
    }   
    // cria vetor threads com o numero de threads a serem criadas.
    pthread_t threads[numero_threads]; 
    // loop de execucao das tarefas
    printf("\nDiagrama fornecido:\n\n");
    for (i = 0; i < 9; i++) {
        for (j = 0; j < 9; j++) {
            printf("%u ", char_to_int(sudoku[9*i+j]));
        }
        printf("\n");
    }
    printf("\n");
    for (i = 0; i < numero_threads; i++) {
        pthread_create(&threads[i], NULL, &work, (void *) (intptr_t) i);
    }
    for (i = 0; i < numero_threads; i++) {
        pthread_join(threads[i], NULL);
    } 
    // variavel errado inicializada em 0 e incrementada ao se achar qualquer erro.
    // errado == 0 significa ausencia de erros.
    if (errado) {
        printf("\nSolucao incorreta!\n\n");
    } else {
        printf("\nSolucao correta!\n\n");
    }
    pthread_exit(NULL);
}