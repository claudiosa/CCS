import numpy as np
import scipy.misc
from PIL import Image
path = "imagens/"

# === elementos estruturantes ===
#  *
# ***
#  *
elemento1 = [(-1,0),(0,0),(1,0),(0,1),(0,-1)] 

# *****
elemento2 = [(-2,0),(-1,0),(0,0),(1,0),(2,0)]

#   *
# *   *
#   *
elemento3 = [(-2,0),(2,0),(0,2),(0,-2)] 

def Descricao(imagem):
	shape = imagem.shape
	conjunto = []
	for L in range(shape[0]):
		for C in range(shape[1]):
			if imagem[L][C] == 0:
				conjunto.append((C,L))
	return conjunto

#----------------------------------------------------------------

def Dilata(conjunto, elemento):
	resultado = []
	for value in conjunto:
		for elem in elemento:
			temp = (value[0] + elem[0], value[1] + elem[1])
			if temp not in resultado:
				resultado.append(temp)
	return resultado

#----------------------------------------------------------------

def GeraImagem(conjunto,shape):
	resultado = np.ones(shape)*255
	for value in conjunto:
		resultado[value[1]][value[0]] = 0
	return resultado

# ===============================================================
	
imagem = np.array(Image.open(path+'base-dilatacao.png').convert('L'))
conjunto = Descricao(imagem)
res1 = GeraImagem(Dilata(conjunto,elemento1),imagem.shape)
scipy.misc.imsave(path+"dilatacao-1.png", res1)

res2 = GeraImagem(Dilata(conjunto,elemento2),imagem.shape)
scipy.misc.imsave(path+"dilatacao-2.png", res2)

res3 = GeraImagem(Dilata(conjunto,elemento3),imagem.shape)
scipy.misc.imsave(path+"dilatacao-3.png", res3)

print 'done'
