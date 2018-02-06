import numpy as np
import scipy.misc
from PIL import Image
path = "imagens/"

# === elementos estruturantes ===
#  *
# ***
#  *
elemento1 = [(-1,0),(0,0),(1,0),(0,1),(0,-1)] 

# ***
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

def Erode(conjunto, elemento):
	etapas = []
	for elem in elemento:
		etapa = []
		for value in conjunto:
			temp = (value[0] - elem[0], value[1] - elem[1])
			etapa.append(temp)
		etapas.append(etapa)
	
	resultado = []
	for value in etapas[0]:
		insere = True
		for index in range(len(etapas)):
			if value not in etapas[index]:
				insere = False
		if insere:
			resultado.append(value)
	
	return resultado

#----------------------------------------------------------------

def GeraImagem(conjunto,shape):
	resultado = np.ones(shape)*255
	for value in conjunto:
		resultado[value[1]][value[0]] = 0
	return resultado

# ===============================================================

imagem = np.array(Image.open(path+'base-erosao.png').convert('L'))
conjunto = Descricao(imagem)
res1 = GeraImagem(Erode(conjunto,elemento1),imagem.shape)
scipy.misc.imsave(path+"erosao-1.png", res1)

res2 = GeraImagem(Erode(conjunto,elemento2),imagem.shape)
scipy.misc.imsave(path+"erosao-2.png", res2)

res3 = GeraImagem(Erode(conjunto,elemento3),imagem.shape)
scipy.misc.imsave(path+"erosao-3.png", res3)

print 'done'