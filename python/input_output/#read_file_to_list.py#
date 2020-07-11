# USAGE $ python read_file_to_list.py 38_XY.dat

import sys, ast
# input file in list of tuples format
INP_FILE = sys.argv[1]

with open(INP_FILE, 'r') as file:
            #data = file.read()
            mylist = ast.literal_eval(file.read())
            #print(mylist)
            #print(data)
            file.close()

for elem in mylist:
    print(":", elem, end="")


#Using dictionary comprehension
my_dictionary = { i: mylist[i] for i in range(0, len(mylist)) }
### the index must be 0

#print(my_dictionary)              
print("\nOnly the keys: ", my_dictionary.keys(), end="")
print("\nOnly the values: ", my_dictionary.values(), end="")

### printing the dictionary by element
for elem in  my_dictionary:              
    print("||",elem+1,":", my_dictionary[elem], end="")

#  listOfItems = dictOfElements.items()    TODOS

print("\n Sucess")            
