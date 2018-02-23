v1 = v2 = [4,1,0,-2,10,5]
v3 = v1 + v2
v3.sort()
print v3

v4 = [x + y for x, y in zip(v1,v2)]