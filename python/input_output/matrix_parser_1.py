matrix = []
rows = int(input())
for row in range(rows):
	matrix.append([int(cell) for cell in input().split()])
print(matrix)

