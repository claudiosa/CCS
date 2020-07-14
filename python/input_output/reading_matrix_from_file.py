import sys

INP_FILE = sys.argv[1]   #### list format ....38_XY.dat and 


def get_matrix():
   
    with open(INP_FILE, 'r') as file:
        matrix = file.read()
        print("\n read it: ", matrix)
   
    file.close()   
    ###print("1> Input format", coords)        
    return(matrix)



def main(argc : int, argv : list) -> int :
    if argc < 2:
        print('Usage: python3 %s inputFile' % (argv[0]))
        exit(1)

    try:

        with open(argv[1], 'r') as file:
            n = int(file.readline())
            graph = [list(map(int, line.split()))   for line   in file]

    except Exception:
        print('Error parsing file %s ' % (argv[1]))
        exit(1)
        
    print(n)
    print(*graph, sep='\n')
    #print(graph)
    
if __name__ == '__main__':
    main(len(sys.argv), sys.argv)
