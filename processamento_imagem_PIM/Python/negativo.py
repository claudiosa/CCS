import numpy as np
import scipy.misc
import matplotlib.pyplot as plt

path = "imagens/"
imagem = scipy.misc.imread(path+"mandril.jpg")
shape = imagem.shape

for L in range(shape[0]):
	for C in range(shape[1]):
		r,g,b = imagem[L][C]
		imagem[L][C] = [255-r,255-g,255-b]

scipy.misc.imsave(path+"mandril-neg.jpg", imagem)

plt.imshow(imagem)
plt.show()
