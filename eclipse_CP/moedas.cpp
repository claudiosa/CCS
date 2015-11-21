#include <cstdio>
#define MAXN 101
#define MAXM 50001
#define INF MAXM*2

int valor[MAXN], mem[MAXM];

int main() {
    int m, n;
    
    while(true) {
        scanf("%d %d", &m, &n);
        if(!m) break;
        
        for(int i = 0; i < n; ++i)
            scanf("%d", &valor[i]);
        
        mem[0] = 0;
        
        for(int v = 1; v <= m; ++v) {
            mem[v] = INF;
            
            for(int i = 0; i < n; ++i) {
                int aux = valor[i];
                if( aux <= v && mem[v-aux]+1 < mem[v] )
                    mem[v] = mem[v-aux]+1;
            }
        }
        
        if(mem[m] >= INF)
            printf("Impossivel\n");
        else
            printf("%d\n", mem[m]);
    }
    
    return 0;
}
