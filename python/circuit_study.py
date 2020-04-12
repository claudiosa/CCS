



def eh_circuito_de_i(x,i):
    n = len(x)
    step = 0
    v = []
    v = [0  for i in range(n)]    
    v[i] = 1 ## marca 1 em i
    
    while (step < n):
        next = x[i]
        v[next] = 1
        i = next
        step = step + 1
        print(f'i: %i \t next: %i \t step: %i v: %s ' %(i, next, step, v))
        
    if ( sum(v) == n ):
        print('eh ciclo')
        print(v)
    else:
        print("nao")
        print(v)


def is_a_circuit(x):
    n = len(x)
    step, i = 0 , 0 ### any position
    v = []
    v = [0  for i in range(n)]    
    v[i] = 1 ## mark sequentially
    
    while (step < n):
        next = x[i]
        v[next] = 1
        i = next
        step = step + 1
        #print(f'i: %i \t next: %i \t step: %i v: %s ' %(i, next, step, v))
        
    if ( sum(v) == n ):
        return True
    else:
        return False


Y1 =   [1, 3, 0, 2]
### OK
print('Y quantas linhas ',  len(Y1))    
#print('Y quantas colunas ',  len(Y[0]))    
eh_circuito_de_i(Y1,0)

Y2 =   [1, 3, 0, 2, 5,6,4]
eh_circuito_de_i(Y2,4)

print("is circuit", is_a_circuit(Y1))
print("is circuit", is_a_circuit(Y2))