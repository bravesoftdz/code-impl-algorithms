/* Exemplo de um programa que envia mensagens atraves de uma fila de mensagens.   */
/* As facilidades de comunicacao sao providenciadas pela biblioteca ipc.h.        */
/* A funcao int msgget ( key_t key, int msgflg) retorna o identificador da fila   */
/* de mensagens associado  ao valor da chave argumento.                           */
/* msgflag sao os bits indicando as permissoes de acesso a fila.                  */
/* A funcao int msgsnd(int msqid, struct msgbuf *msgp, size_t msgsz, int msgflg)  */
/* enfileira uma copia da mensagem apontada pelo argumento msqp na fila de        */
/* mensagens especificada por msqid. O argumento msgsz especifica o tamanho       */
/* maximo de bytes para o campo mtext da estrutura apontada pelo argumento msgp.  */
/* O argumento  msgtyp  especifica o tipo de mensagem enviada.                    */
/* Para compilar no Linux, gcc sender.c -o sender.exe                                 */
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAMMSG     128

typedef struct msgbuf {     // Estrutura de uma mensagem
  long    tipoMsg;          // Poderia estar em um arquivo .h
  char    textoMsg[TAMMSG]; // para ser comum para todos processos
} CaixaMsg;

void main(){
  int idMsg;
  int msgflg = IPC_CREAT | 0666;
  key_t idFilaMsg;
  CaixaMsg CaixaSaida;
  size_t tamanhoCaixaMsg;


  char str[100];
  int i;

  printf( "Enter a value :");
  scanf("%s %d", str, &i);



  idFilaMsg = 1234;         // Identificador da fila de mensagens
  if ((idMsg = msgget(idFilaMsg, msgflg )) < 0) {
    printf("Erro: nao conseguiu criar fila de mensagens");
    exit(1);
  }

  CaixaSaida.tipoMsg = 1; // Enviara mensagem do tipo 1
  // sprintf(CaixaSaida.textoMsg,"Este mensagem %s foi enviada pelo processo %d\n",getpid(), read_message);
  sprintf(CaixaSaida.textoMsg, "You entered: %s %d ", str, i);


  tamanhoCaixaMsg = strlen(CaixaSaida.textoMsg) + 1 ;

  if (msgsnd(idMsg, &CaixaSaida, tamanhoCaixaMsg, IPC_NOWAIT) < 0) { // Tenta enviar mensagem
    printf ("%d, %li, %s, %li#include <stdio.h>\n", idMsg, CaixaSaida.tipoMsg, CaixaSaida.textoMsg, tamanhoCaixaMsg);
    printf("Erro: nao conseguiu enviar mensagem");
    exit(1);
  }
  else
      printf("Mensagem: \"%s\" enviada\n", CaixaSaida.textoMsg);
  exit(0);
}
