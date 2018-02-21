import scipy.misc
import matplotlib.pyplot as plt

path = "imagens/"

def GeraNivel(input, T, output):

	imagemIN = scipy.misc.imread(input)
	W,H = imagemIN.shape
	
	data = []
	for i in range(0,H,T):
		row = []
		for j in range(0,W,T):
			lvl = imagemIN[i][j]
			row.append([lvl,lvl,lvl])
		data.append(row)
	
	scipy.misc.imsave(output,data)

# ===========================================================================================

input = path + "lena.jpg"
output = path + "piramide.png"

GeraNivel(input, 8, output)

resultado = scipy.misc.imread(output)
plt.imshow(resultado)
plt.show()
