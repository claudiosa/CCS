matrix = [ 
    [0, 20, 30, 10,  0],
    [0,  0, 40,  0, 30],
    [0,  0,  0, 10, 20],
    [0,  0,  5,  0, 20],
    [0,  0,  0,  0,  0]
    ]

#print(max(max(d)))
maior = max(map(max, matrix))
print(maior)