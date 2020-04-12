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

############################
def print_matrix(game):
    """Pretty print of a matrix."""
    rows = len(game)
    cols = len(game[0])
    for i in range(rows):
        line = ''
        for j in range(cols):
            if game[i][j] == 0:
                line += '  .'
            else:
                line += '% 3s' % game[i][j]
        print(line)
############################

print_matrix(matrix)
