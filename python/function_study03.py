
###import sys ????

def fib_01 (n):
    a , b = 0 , 1
    while (a < n):
    	print(a, end = '->')
    	a , b = b , (a+b)     
    print () ## jump line ....
    return 

#### NOT OK yet
def fib_02 (n):
    a = 0
    b = 1
    fib = a
    while (fib < n):
    	print(fib, end = '->')
#    	print(b, end = '->')
    	fib = a + b
    	a = b
    	b = fib     
    print () ## jump line ....
    return 
#### NOT OK yet
def fib_03 (n):
	if (n < 2 ):
		return (n)
	return ( fib_03 (n-2) + fib_03 (n-1) )

'''
  for (int k = 1; k < n; k++)
				  {	
					int t;
					t = i + j;
					i = j;
					j = t;
				  }

'''
def main_X ():
    print (" \t ==> STARTING the MAIN <==")
    #print ('fatorial: ')  ,  print( fatorial(3) )
    fib_01(40)
    fib_02(40)
    print('\n recursive : ' , fib_03(4) )
    python_is ()
    print (" \t ==> END OF MAIN <==")

def python_is():
    print('\t Highly is permissive ....')
    print('\t Everything is allowed ....')
    return
### main is reserved ???
if __name__ == '__main__':
    main_X ()


