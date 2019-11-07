

def funcao01():
    print ('I am in funcao_01')
    return 999

def funcao02(x, y):
    print ('I am in funcao_02')
    return (x+y)

def main_X():
	print ('Output 01:', funcao01() ) ### take care HERE   
	print( funcao01() ) 
	print ('Output 02: ')  ,  print(funcao02(2,3))
	python_is()
	print (" \t ==> END OF MAIN <==")

def python_is():
	print('\tHighly is permissive ....')
	print('\tEverything is allowed ....')
	return
### main is reserved ???
if __name__ == '__main__':
    main_X()


