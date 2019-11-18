
###import sys ????

def attrib_01 ():
    a , b ,c  = 0 , 1 , 2
    print('\t Before:', a, b, c, end = '\n')
    a +=10  
    b +=20 
    c +=30 
    print('\t After:', a, b, c, end = '\n')
#    print () ## jump line ....
    return 


def main_X ():
    print (" \t ==> STARTING the MAIN <==")
    attrib_01 ()
    python_is ()
    print (" \t ==> END OF MAIN <==")

def python_is():
    print('\t Highly is permissive ....')
    print('\t Everything is allowed ....')
    return
### main is reserved ???
if __name__ == '__main__':
    main_X ()


