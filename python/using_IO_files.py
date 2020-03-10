# TO USE DIRECTLY:  $python lessons.py input.json .... CCS
	
import sys ## ADDED .... CCS


# input file in JSON format
##INP_FILE = "input_FEB_01.json"
INP_FILE = str(sys.argv[1])
# to use directly $python lessons.py input.json

# output file (also JSON)
OUT_FILE = str(sys.argv[2])
	
	# main function, to exemplify the usage
if __name__ == '__main__':
	
    with open(INP_FILE, 'r') as f1:
        print('Nome do arquivo de entrada:', INP_FILE)
        ## ADD a read HERE

    with open(OUT_FILE, 'w') as f2:
        print('Nome do arquivo de saída:', OUT_FILE)
        ## ADD a write HERE
        
linhas = 0
while linhas < 100:
#	try:
		x = f1.readlines()
		f2.write(x)
		linhas = linhas + 1
		
#	except	ValueError:
#		print(" FIM DE ARQUIVO")
	
        
f1.close()
f2.close()
	
