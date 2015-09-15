/* Exemplo de um programa que recebe mensagens atraves de uma fila de mensagens.  */          
/* As facilidades de comunicacao sao providenciadas pela biblioteca ipc.h.        */  
/* A funcao int msgget(key_t key, int msgflg) retorna o identificador da fila     */
/* de mensagens associado  ao valor da chave argumento.                           */
/* msgflag sao os bits indicando as permissoes de acesso a fila.                  */
/* A funcao  ssize_t msgrcv(int msqid, struct msgbuf *msgp, size_t msgsz,         */    
/* long msgtyp, int msgflg) le uma mensagem da fila de mensagens especificada por */
/* msqid no buffer msgbuf apontado pelo argumento msgp removendo-a da fila.       */
/* O argumento msgsz especifica o tamanho maximo de bytes para o campo mtext da   */
/* estrutura apontada pelo argumento msgp. O argumento  msgtyp  especifica o tipo */
/* de mensagem esperada.                                                          */
/* Para compilar no Linux, gcc receiver.c -o receiver.exe                           */
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <stdio.h>
#include <stdlib.h> 

#define TAMMSG     128


typedef struct msgbuf {     // Estrutura de uma mensagem
  long    tipoMsg;          // Poderia estar em um arquivo .h 
  char    textoMsg[TAMMSG]; // para ser comum para todos processos
} CaixaMsg;

void main(){
  int idMsg;
  key_t idFilaMsg;
  CaixaMsg  CaixaEntrada;

  idFilaMsg = 1234;          // Identificador da fila de mensagens
  if ((idMsg = msgget(idFilaMsg, 0666)) < 0) {
    printf("Erro: nao conseguiu acessar fila de mensagens");
    exit(1);
  }

  if (msgrcv(idMsg, &CaixaEntrada, TAMMSG, 1, 0) < 0) { // Tenta receber mensagem
    printf("Erro: nao conseguiu receber mensagem"); 
    exit(1);
  }
  else
    printf("Mensagem: %s\n", CaixaEntrada.textoMsg);
}

