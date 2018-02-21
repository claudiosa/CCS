import scipy.misc

path = "imagens/"

def pseudocor(filename, fatiamento):
	imagem = scipy.misc.imread(filename)
	H,W = imagem.shape
	
	resultado = []
	for i in range(H):
		row = []
		for j in range(W):
			for fatia in fatiamento:
				if imagem[i][j] <= fatia[0]:
					row.append(fatia[1])
					break
		resultado.append(row)
		
	scipy.misc.imsave(path+"r-x-color.png",resultado)	
	
# ---------------------------------------------------------

pseudocor(path+"r-x.jpg", [(20,[0,0,0]), (128, [255,0,0]), (230, [255,255,0]), (255, [0,255,0])])	
