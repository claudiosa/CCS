import numpy as np
import scipy.misc
import matplotlib.pyplot as plt

path = "imagens/"
imagem = scipy.misc.imread(path+"car1.png")

# gera o histograma e seus intervalos
histograma, intervalos = np.histogram(imagem,bins=np.arange(0,256))

#print histograma
#print intervalos

# determina o valor do centro dos intervalos
#center = (intervalos[:-1] + intervalos[1:])/2
#print center

# exibe o histograma
plt.bar(intervalos[:-1],histograma,1)
plt.show()
