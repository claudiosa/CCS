#include <cstdio>
#include <cstring>
#include <set>
#include <algorithm>
#define MAXN 101
#define MAXP 101 * 450

using namespace std;

int peso[MAXN];
set<int> possivel[MAXP];

void mochila_binaria(int n, int p)
{
    for(int i = 0; i <= p; ++i) possivel[i].clear();
    
    possivel[0].insert(0);
    int soma = 0;
    
    set<int>::iterator it, end;
    
    for(int i = 0; i < n; ++i)
    {
        soma += peso[i];
        
        for(int j = soma; j >= 0; --j)
            if(!possivel[j].empty())
            {
                it = possivel[j].begin();
                end = possivel[j].end();
                
                for(; it != end; ++it)
                    possivel[j + peso[i]].insert(*it + 1);
            }
    }
}

int main()
{
    int t;
    scanf("%d", &t);
    
    for(int i = 0; i < t; ++i)
    {
        if(i > 0) printf("\n");
        int n, soma = 0;
        scanf("%d", &n);
        
        for(int j = 0; j < n; ++j)
        {
            scanf("%d", &peso[j]);
            soma += peso[j];
        }
        
        mochila_binaria(n, MAXP-1);
        
        int k, n1 = n / 2, n2;
        if(n % 2 == 0) n2 = n1; else n2 = n1 + 1;
        
        set<int>::iterator it, end;
        bool achou = false;
        
        for(k = soma / 2; !achou && k >= 0; --k)
        {
            it = possivel[k].begin();
            end = possivel[k].end();
            
            for(; it != end; ++it)
            {
                if(*it == n1 || *it == n2)
                {
                    printf("%d %d\n", k, soma - k);
                    achou = true;
                    break;
                }
            }           
        }
    }
    
    return 0;
}
