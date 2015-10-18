#include <stdio.h>
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>


#define TAMANHO 9
#define NIL ((char *)0)

// Simula o tipo de dado boolean
enum boolean {
    true = 1, false = 0
};
typedef enum boolean bool;


// Estrutura com dados das tarefas a serem executadas
struct tarefa
{
    unsigned indice;
    unsigned short identificador; // 1 a 9
    char tipo;// se linha, coluna, quadro
    bool em_execucao;
    bool finalizada;
};

// variáveis globais
struct tarefa tarefas[27];
pthread_mutex_t mutex;
char *sudoku;

int char_to_int(char c)
{
    return (int) c - 48;
}

// Inicia as 27 tarefas para verificação do sudoku
void popula_tarefa(struct tarefa *tarefa, char tipo, unsigned short identificador, unsigned short indice)
{
    tarefa->indice = indice;
    tarefa->identificador = identificador;
    tarefa->tipo = tipo;
    tarefa->em_execucao = false;
    tarefa->finalizada = false;
}

void inicar_tarefas() {

    int i;
    for (i = 1; i <= 9; i++) {

        // Linhas
        unsigned short linha = i - 1; // 0 a 8
        popula_tarefa(&tarefas[linha], 'L', i, linha);

        // Colunas
        unsigned short coluna = linha + 9; // 9 a 17
        popula_tarefa(&tarefas[coluna], 'C', i, coluna);

        // Quadros
        unsigned short quadro = coluna + 9; // 18 a 26
        popula_tarefa(&tarefas[quadro], 'Q', i, quadro);

    }

}

void pega_coluna(int *numeros, unsigned short coluna) {

    int i;
    for (i = 0; i < TAMANHO; i++) {
        int indice = (i * TAMANHO) + (coluna - 1);
        numeros[i] = char_to_int(sudoku[indice]);
    }

}

void pega_linha(int *numeros, unsigned short linha) {

    int fator_linha[TAMANHO] = {0, 9, 18, 27, 36, 45, 54, 63, 72};

    // int i;
    // fator = (linha - 1) * TAMANHO
    // for(i=fator; i<(fator + TAMANHO); i++) {
    //    numeros[i]= char_to_int(sudoku[i]);
    //}
    int i;
    for (i = 0; i < TAMANHO; i++) {
        int indice = i + fator_linha[linha-1];
        numeros[i] = char_to_int(sudoku[indice]);
    }

}

void pega_quadro(int *numeros, unsigned short quadro)
{
    int fator_quadro[TAMANHO] = {0, 3, 6, 27, 30, 33, 54, 57, 60};

    int i;
    for (i = 0; i < TAMANHO; i++) {

        int l = (int) i / 3;

        int m;
        if (l == 0) {
            m = 0;
        } else if (l == 1) {
            m = 6;
        } else if (l == 2) {
            m = 12;
        }

        int indice = i + m + fator_quadro[quadro-1];
        numeros[i] = char_to_int(sudoku[indice]);

    }

}

bool verifica_numero_repetidos(int *numeros, int thread_id, char tipo[], int identificador) {

    int i, j;
    for (i = 0; i < TAMANHO; i++) {
        for (j = i + 1; j < TAMANHO; j++) {
            if (numeros[i] == numeros[j]) {

                printf("Thread ID: %d - Numero %d repetido no(a) %s %d\n",
                    thread_id, numeros[i], tipo, identificador);
            }
        }
    }

    return false;
}


void * trabalhador(void *arg)
{

    int thread_id = (intptr_t) arg + 1;

    int numeros[TAMANHO];

    while (true) {

        struct tarefa trabalho;

        trabalho.identificador = 0;

        // marca a tarefa como em progresso
        pthread_mutex_lock(&mutex);
        int i;
        for (i = 0; i < TAMANHO * 3; i++) {
            if (!tarefas[i].finalizada) {
                if (!tarefas[i].em_execucao) {
                    tarefas[i].em_execucao = true;
                    trabalho = tarefas[i];
                    //printf("Tarefa em execução %d\n", trabalho.indice + 1);
                    break;
                }
            }
        }
        pthread_mutex_unlock(&mutex);

        if (trabalho.identificador == 0) {
            printf("Finalizando a Thread %d\n", thread_id);
            break;
        }

        //printf("Thread %d iniciando tarefa %d\n", thread_id, trabalho.identificador);
        switch (trabalho.tipo) {

        case 'C':
            pega_coluna(numeros, trabalho.identificador);
            verifica_numero_repetidos(numeros, thread_id, "Coluna", trabalho.identificador);
            break;
        case 'L':
            pega_linha(numeros, trabalho.identificador);
            verifica_numero_repetidos(numeros, thread_id, "Linha", trabalho.identificador);
            break;
        case 'Q':

            pega_quadro(numeros, trabalho.identificador);
            verifica_numero_repetidos(numeros, thread_id, "Quadro", trabalho.identificador);
            break;
        }


        // Marca a tarefa como finalizada
        pthread_mutex_lock(&mutex);

        tarefas[trabalho.indice].em_execucao = false;
        tarefas[trabalho.indice].finalizada = true;

        pthread_mutex_unlock(&mutex);
    }

    pthread_exit(NULL);

}



int main(int argc, char * argv[]) {

    pthread_mutex_init(&mutex,  NULL);

    inicar_tarefas();

    sudoku = argv[2];

    int numero_threads = atoi(argv[1]);
    pthread_t threads[numero_threads];

    long indice;
    for (indice=0; indice<numero_threads; indice++) {
        pthread_create(&threads[indice], NULL, &trabalhador, (void *)indice);
    }

    for (indice=0; indice<numero_threads; indice++) {
      pthread_join(threads[indice], NULL);
    }

    pthread_exit(NULL);

    pthread_mutex_destroy(&mutex);


}

