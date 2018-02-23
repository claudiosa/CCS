import numpy as np
import scipy.misc
from PIL import Image

maskV = [[-1,2,-1],[-1,2,-1],[-1,2,-1]] #vertical
maskH = [[-1,-1,-1],[2,2,2],[-1,-1,-1]] #horizontal

path = "imagens/"

def Segmenta(imagem, mascara, T):
	shape = imagem.shape
	resultado = []
	for L in range(shape[0]):
		row = []
		for C in range(shape[1]):
			R = 0
			for y in range(-1,2):
				for x in range(-1,2):
					if L+y>=0 and L+y<shape[0] and C+x>=0 and C+x<shape[1]:
						R += imagem[L+y][C+x] * mascara[y+1][x+1]
			if abs(R) > T:			
				row.append(255)
			else:
				row.append(0)
		resultado.append(row)
	return np.array(resultado)

# ------------------------------
	
imagem = np.array(Image.open(path+'shapes.png').convert('L'))
resH = Segmenta(imagem,maskH,400)
resV = Segmenta(imagem,maskV,400)
#scipy.misc.imsave(path+"molduras-seg.png", resH)
scipy.misc.imsave(path+"shapes-seg.png", resH+resV)
