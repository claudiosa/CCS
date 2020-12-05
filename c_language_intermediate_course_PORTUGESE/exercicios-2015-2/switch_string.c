#include<stdio.h>

int main(){

    char name[20];

    printf("DIGITE: UDESC ");
    scanf("%s",name);
    switch(name[20]){
        case "UDESC" : 
        printf("hello .... FUNCIONOU");
        break;
    }
    printf("%s",name);
    getchar();
}
