

## all  except ...
'''
k1 = [x for x in range(90) if ((x != 5) and x < 19)]
for i in k1:
    print(f'-> %i' %i)
'''
## 5 e 15 não inclusos
k2 = [x for x in range(20) if ((x != 5) and (x != 15)) ]    
for i in k2:
    print(f'-> %i' %i)

v = [3,4,5]
print(len(v))