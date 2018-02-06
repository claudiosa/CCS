import scipy.misc
import matplotlib.pyplot as plt
import numpy as np

path = "imagens/"
logo = scipy.misc.imread(path+"python.png")

logo1 = np.array(logo*0.15, dtype=np.uint8)

print logo1

plt.imshow(logo1)
plt.show()
