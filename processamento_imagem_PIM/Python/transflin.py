import numpy as np
import scipy.misc
import matplotlib.pyplot as plt
	
def TransfLin( imagem, A, B ):	
	shape = imagem.shape
	imagemBin = []
	for L in range( shape[0] ):
		row = []
		for C in range( shape[1] ):
			lvl = int(imagem[L][C]* A + B)
			if lvl > 255: 
				lvl = 255
			row.append( [lvl,lvl,lvl] )
		imagemBin.append( row )
	return imagemBin

# ------------------------------------------------------------

imagem = scipy.misc.imread( "imagens/menina-poisson.png" )
scipy.misc.imsave( "imagens/poisson-transformada.png", TransfLin( imagem, 1, 20 ) )

plt.imshow( scipy.misc.imread( "imagens/poisson-transformada.png" ) )
plt.show()
