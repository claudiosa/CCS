import scipy.misc
import matplotlib.pyplot as plt
path = "imagens/"
image = scipy.misc.imread(path+'python.png')
plt.imshow(image)
plt.show()

