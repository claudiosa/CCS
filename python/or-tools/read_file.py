import sys

INP_FILE = sys.argv[1]   #### formatted ...

def get_matrix():
    matrix = []
    with open(INP_FILE, 'r') as file:
        for line in file.readlines():
            matrix.append( [ int(x) for x in line.split()] )
        #print("\n read it: ", matrix)

    file.close()   
    return(matrix)

if __name__ == '__main__':

    m =  get_matrix()
    n = len(m[0]) #  number of nodes ( n x n matrix)
    print("Num of nodes: ", n, " ==> number of lines from input file")
    L_NODES = list(range(n)) ### 0...(n-1)
    # print(f'L_NODES (RANGE) :' ,  L_NODES )
    for i in range(n):
        print(f'  %i' % ((i+1)%10), end =  '')

    for i in range(n): 
        print(f'\n %i: '  %(i+1) , end =  '' )
        for j in range(n): 
            print(f'  %i' % ( m[i][j]), end =  '' )
    print("\n ====================== ")
