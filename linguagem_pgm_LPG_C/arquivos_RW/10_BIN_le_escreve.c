// leitura e escrita BINARIA
#include <stdio.h>

struct s
{
char name[50];
int height;
};

int main(void){
    struct s a[5],
             b[5];   
    FILE *fptr;
    int i;
    fptr=fopen("file2.txt","wb");
    for(i=0;i < 2 ; ++i)
    {
        fflush(stdin);
        printf("Enter name: ");
        scanf("%s" , a[i].name);
        printf("Enter height: "); 
        scanf("%d",&a[i].height); 
    }
    // escrevendo a estrutura TODA
    fwrite(a , sizeof(a),1,fptr);
    fclose(fptr);
     // lendo a estrutura TODA
    fptr=fopen("file2.txt","rb");
    fread(b ,sizeof(b),1,fptr);
    for(i=0;i<5;++i)
    {
        printf("Name: %s\nHeight: %d",b[i].name,b[i].height);
    }
    fclose(fptr);
}