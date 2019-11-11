
###import sys ????

def fib_01 (n):
    a , b = 0 , 1
    while (a < n):
    	print(a, end = '->')
    	a , b = b , (a+b)     
    print () ## jump line ....
    return 

#### 
def fib_02 (n):
    a = 0
    b = 1
    print(a, end = '->')
    while (b < n):
    	previous = a
    	a = b ## update a ... AS FIB
    	b = a + previous   
    	print(a, end = '->')
    print () ## jump line ....
    return 
####  OK now
def fib_03 (n):
	if(n == 0):
		return (0)
	if(n == 1):
		return (1)
	
	return ( fib_03 (n-2) + fib_03 (n-1) )

### function as parameter ....
def n_calls(n, function):
    while (n >= 0):
        print ('This function in: ', n, ' \tis: ', function(n) )
        n = n - 1 
    return 


def main_X ():
    print (" \t ==> STARTING the MAIN <==")
    #print ('fatorial: ')  ,  print( fatorial(3) )
    fib_01(40)
    fib_02(40)
    print('\n RECURSIVE : ' , fib_03(6) )
    n_calls(10,fib_03)
    python_is ()
    print (" \t ==> END OF MAIN <==")

def python_is():
    print('\t Highly is permissive ....')
    print('\t Everything is allowed ....')
    return
### main is reserved ???
if __name__ == '__main__':
    main_X ()


