
X = [
        [0, 0, 1, 0],
        [0, 0, 0, 1],
        [0, 1, 0, 0],
        [0, 0, 0, 0]
]

cur = 0
while True:
    try:
        print('Current node: ', cur)
        cur = X[cur].index(1)
    except ValueError:
        break


## from graph INACABADO
x = [3,4,2]
start = 1

# algorithm
i = 0
k = 1
#v = [range(len(x)+1)]
v = []
v.append(start)
#v[0] = start
#for i in range (len(v) ):
#print(v[i]) 

while (k < 4):
    
    next = x[i]
    v.append(next)
    i = next % (len(x) -1)
    k = k+1

print(v)    
