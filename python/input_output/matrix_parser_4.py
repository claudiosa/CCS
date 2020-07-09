matrix = []
with open("in_2","r") as in_file:
	for row in in_file:
		matrix.append([int(cell) for cell in row.split()])
in_file.close()
with open("out_2","w") as out_file:
	out_file.write(str(matrix))
out_file.close()
