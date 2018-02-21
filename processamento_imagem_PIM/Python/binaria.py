import numpy as np
import scipy.misc
import matplotlib.pyplot as plt

def Binariza( imagem, threshold ):	
	shape = imagem.shape

	imagemBin = []
	for L in range( shape[0] ):
		row = []
		for C in range( shape[1] ):
			if( imagem[L][C] <= threshold ):
				row.append( [0, 0, 0] )
			else:
				row.append( [255, 255, 255] )
		imagemBin.append( row )
	return imagemBin

# ------------------------------------------------------------

imagem = scipy.misc.imread( "imagens/lena.jpg" )
scipy.misc.imsave( "imagens/lena-binaria.png", Binariza( imagem, 128 ) )

plt.imshow( scipy.misc.imread( "imagens/lena-binaria.png" ) )
plt.show()
