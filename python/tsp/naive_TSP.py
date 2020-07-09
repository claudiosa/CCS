# Python3 program to implement traveling salesman 
# problem using naive approach. 

# to RUN python naive_TSP.py some_input_here.txt 
import sys
from sys import maxsize 

INP_FILE = str(sys.argv[1])

def read_file_to_matrix(INP_FILE):
### reading a file as input and transform in a matrix
    # file = open(INP_FILE ,"r") ### OR
    with open(INP_FILE, 'r') as file:
        input_lines = int(file.readline())
        graph = [list(map(int, line.split()))   for line   in file]
               
    file.close()
    print("Number of nodes", input_lines) ### number of vertex
    #print(*graph, sep='\n')
   
    print("Input file read OK") 
    return(graph)

# implementation of traveling Salesman Problem 
def travellingSalesmanProblem(graph, s): 
  
    # store all vertex apart from source vertex 
    vertex = []
    V = len(graph[0]) 
    print("\n Vertices: ", V)
    for i in range(V): 
        if i != s: 
            vertex.append(i) 
  
    # store minimum weight Hamiltonian Cycle 
    min_path = maxsize 
  
    while True: 
  
        # store current Path weight(cost) 
        current_pathweight = 0
  
        # compute current path weight 
        k = s 
        for i in range(len(vertex)): 
            current_pathweight += graph[k][vertex[i]] 
            k = vertex[i] 
        current_pathweight += graph[k][s] 
  
        # update minimum 
        if (current_pathweight < min_path):
            min_path = current_pathweight
            latest_path = vertex
            print("Latest->  Cost:", min_path, "\t Permutation: ", latest_path  )
            
        #min_path = min(min_path, current_pathweight) 
  
        if not next_permutation(vertex): 
            ### print("Final ->  Cost:", min_path, "\t Permutation: ", latest_path  )
            break
  
    # print(f'\n The sequence is: [%i]' %(vertex))
    # print(latest_path)
    # print(*vertex, sep='\n')
    return min_path 
  
# next_permutation implementation 
## to be improved
def next_permutation(L): 
  
    n = len(L) 
  
    i = n - 2
    while i >= 0 and L[i] >= L[i + 1]: 
        i -= 1
  
    if i == -1: 
        return False
  
    j = i + 1
    while j < n and L[j] > L[i]: 
        j += 1
    j -= 1
  
    L[i], L[j] = L[j], L[i] 
  
    left = i + 1
    right = n - 1
  
    while left < right: 
        L[left], L[right] = L[right], L[left] 
        left += 1
        right -= 1
  
    return True
  
# Driver Code 
if __name__ == "__main__": 
  
    ## 
    graph = read_file_to_matrix( INP_FILE )
    # matrix representation of graph 
    print(*graph, sep='\n')
    '''
    graph = [[0, 10, 15, 20], [10, 0, 35, 25],  
             [15, 35, 0, 30], [20, 25, 30, 0]] 
    '''             
    s = 0
    print(travellingSalesmanProblem(graph, s)) 
    
# #######################