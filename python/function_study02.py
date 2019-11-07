
###import sys ????

def fatorial(n):
    if (n == 0 or n == 1):
            return (1)
    temp = 1
    while (n > 1):
        temp = temp * n
        n = n - 1 
    return (temp) 

def n_calls_fat(n):
    while (n > 0):
        print ('The fatorial of: ', n, ' \tis: ', fatorial(n) )
        n = n - 1 
    return 

def main_X():
    print (" \t ==> STARTING the MAIN <==")
    #print ('fatorial: ')  ,  print( fatorial(3) )
    n_calls_fat(4)
    python_is()
    print (" \t ==> END OF MAIN <==")

def python_is():
    print('\t Highly is permissive ....')
    print('\t Everything is allowed ....')
    return
### main is reserved ???
if __name__ == '__main__':
    main_X()


