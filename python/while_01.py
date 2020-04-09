
X = [
        [0, 0, 1, 0],
        [0, 0, 0, 1],
        [0, 1, 0, 0],
        [0, 0, 0, 0]
]

Y = [
        [9, 0, 1, 0],
        [0, 0, 0, 0]
]

### OK
print('Y quantas linhas ',  len(Y))    
print('Y quantas colunas ',  len(Y[0]))    

v = []

cur = 0
while True:
    try:
        print('Current node: ', cur)
        v.append(cur)
        cur = X[cur].index(1)

    except ValueError:
        break

print("\n Sequencia " , v)

## from graph INACABADO
'''
# start = 1

# algorithm
# v = [range(len(x)+1)]
v = []
v.append(start)
#v[0] = start
#for i in range (len(v) ):
print('antes', v) 

for i in range (len(X)) :
    j = 0
    while (j < (len(X[0])) ):
        if( X[v[i]][j] != 1 ):
            print('v[i] X[v[i]][j] --->', v[i], X[v[i]][j] )
            j = j+1
            print('j --->', j)
            
        else:
            #v.append( X[v[i]] [j] ) #### next 
            next = j
            v.append( j ) #### next 
            j = 0
            break

    #i = next % (len(x) -1)
    #k = k+1

print('depois', v) 
'''