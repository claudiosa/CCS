
### import convert_data_distance
### from  convert_data_distance import *
import tsplib95

from typing import Union, Sequence
def special(start: Sequence, end: Sequence) -> Union[float,int]:
    pass

### HERE PUT THE FILE WISHED TO CONVERT
## Example $ python convert_data_TSP_to_matrix_distance.py > matrix_qa194.txt
problem = tsplib95.load('dj38.tsp') # read the data
# problem = tsplib95.load('qa194.tsp') # read the data

all_nodes = list(problem.get_nodes()) ## all_nodes in a list
first_node = all_nodes[0]
last_node = len(all_nodes)
#dist_i_j = problem.get_weight(i, j)
#print(f'NUMBER of NODES: %i \n' % (last_node))
print(f'%i ' % (last_node))
for i in range(last_node-1):
    print("[", end='')
    for j in range(last_node-1):
        #print(f' %i' % (problem.get_weight(i+1, j+1) ), end='')
        print( problem.get_weight(i+1, j+1),"," , end='')
    print("],") # ONE LINE ONLY

#print("=========DONE=========")

# problem = tsplib95.load('dj38.tsp', special=get_distance)
# problem.special = get_distance
# problem = tsplib95.load('dj38.tsp', special=driving_distance)
# print(problem.render())
# problem.save('output38.txt')
