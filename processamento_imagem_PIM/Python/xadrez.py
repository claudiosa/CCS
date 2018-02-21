import scipy.misc
import matplotlib.pyplot as plt

path = "imagens/"

def GeraTabuleiro(W, H, T, filename):
	data = []
	for i in range(0,H):
		row = []
		for j in range(0,W):
			lvl = 0
			if (j/T) % 2 == 0: 
				if (i/T) % 2 == 0:
					lvl = 0
				else:
					lvl = 255
			else:
				if (i/T) % 2 == 0:
					lvl = 255
				else:
					lvl = 0
			row.append([lvl,lvl,lvl])
		data.append(row)
	
	scipy.misc.imsave(filename,data)

# ===========================================================================================
filename = path + "xadrez.png"

GeraTabuleiro(256, 256, 64, filename)

resultado = scipy.misc.imread(filename)
plt.imshow(resultado)
plt.show()
