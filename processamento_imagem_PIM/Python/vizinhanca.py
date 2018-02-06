import scipy.misc
import numpy as np

path = "imagens/"

def AdicionaBorda(imagem,lvl):
	size = imagem.shape
	matriz = []
	matriz.append([np.array([lvl,lvl,lvl],dtype=np.uint8) for x in range(0,size[1]+2)])
	for L in range(0,size[0]):
		linha = [np.array([lvl,lvl,lvl],dtype=np.uint8)]
		for C in range(0,size[1]):
			linha.append(imagem[L][C])
		linha.append(np.array([lvl,lvl,lvl],dtype=np.uint8))
		matriz.append(linha)
	matriz.append([np.array([lvl,lvl,lvl],dtype=np.uint8) for x in range(0,size[1]+2)])
	return matriz

def TestaPixelIsolado(matriz,L,C):
	if matriz[L][C][0] != 0:
		return False
	if L-1 >= 0:
		if matriz[L-1][C][0] != 255:
			return False
	if L+1 < matriz.shape[0]:
		if matriz[L+1][C][0] != 255:
			return False
	if C-1 >= 0:
		if matriz[L][C-1][0] != 255:
			return False
	if C+1 < matriz.shape[1]:
		if matriz[L][C+1][0] != 255:
			return False
	return True
	
# --------------------------------------------------------------------------------------------------------------------
	
def ContaPixel4(inputFile,outputFile):
	image = scipy.misc.imread(inputFile)
	size = image.shape
	
	npixels = 0
	
	for L in range(0,size[0]):
		for C in range(0,size[1]):
			if TestaPixelIsolado(image,L,C):
				npixels = npixels + 1
				image[L][C] = [255,0,0] #substitui o pixel por vermelho
	
	scipy.misc.imsave(outputFile,image)
	return npixels
	
# ==================================================================================================================

print "Foram encontrados ", ContaPixel4(path+"teste.png", path+"resultado.png"), " pixels isolados"
