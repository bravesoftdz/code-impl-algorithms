#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>
/* Exemplo de comunicação entre processo pai e filho via pipe. O pipe é unidirecional. */
/* Assim, quem escreve no pipe não pode também ler; quem lê do pipe não pode escrever. */
/* No exemplo, filho escreve, pai lê.                                                  */
/* Para compilar no Linux, gcc pipe.c -o pipe.exe                                      */
int main(void)
{
        int     fd[2], nbytes; // fd[0]: descritor para leitura do pipe; fd[1]: descritor para escrita no pipe;
        pid_t   childpid;
        char    string[] = "Hello, world!\n";
        char    readbuffer[80];

        pipe(fd);
        
        if((childpid = fork()) == -1)
        {
                perror("fork");
                exit(1);
        }

        if(childpid == 0)
        {
                /* Processo filho fecha descritor de leitura do pipe do seu lado*/
                close(fd[0]);

                /* Envia um string pela saída do pipe */
                write(fd[1], string, (strlen(string)+1));
                exit(0);
        }
        else
        {
                 /* Processo  fecha descritor de escrita do pipe do seu lado*/
                close(fd[1]);

                /* Lê um string do pipe */
                nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
                printf("Received string: %s", readbuffer);
        }
        
        return(0);
}
