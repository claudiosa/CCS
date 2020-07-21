def is_a_circuit_from_i(x,i):
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
        print('It is a cicle')
        print(v)
    else:
        print("NO")
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
# print('Y quantas linhas ',  len(Y1))    
# print('Y quantas colunas ',  len(Y[0]))    
is_a_circuit_from_i(Y1,0)

Y2 =   [1, 3, 0, 2, 5,6,4]
is_a_circuit_from_i(Y2,4)
Y3 = [3, 5, 4, 2, 1, 0]
is_a_circuit_from_i(Y3,0)

Y4 = [1, 3, 4, 2, 12, 8, 5, 19, 7, 0, 11, 6, 14, 9, 23, 10, 15, 16, 17, 24, 13, 27, 21, 18, 25, 22, 30, 26, 20, 28, 35, 29, 37, 32, 31, 33, 34, 36]
is_a_circuit_from_i(Y4,0)

print("Y1: is circuit", is_a_circuit(Y1))
print("Y2: is circuit", is_a_circuit(Y2))
print("Y3: is circuit", is_a_circuit(Y3))
print("Y4: is circuit", is_a_circuit(Y4))
