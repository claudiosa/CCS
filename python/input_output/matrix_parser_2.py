matrix = []
while True:
	try:
		matrix.append([int(cell) for cell in input().split()])
	except EOFError:	
		print(matrix)
		break
