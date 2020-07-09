with open("in_1","r") as in_file:
	matrix = []
	rows = int(in_file.readline())
	for row in range(rows):
		matrix.append([int(cell) for cell in in_file.readline().split()])
	print(matrix)
in_file.close()

with open("out_1","w") as out_file:
	out_file.write(str(matrix))
out_file.close()
