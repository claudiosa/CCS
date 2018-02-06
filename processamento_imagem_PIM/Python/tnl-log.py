import numpy as np
import scipy.misc

original = scipy.misc.imread( "imagens/lena.jpg" )
a = 255.0/np.log(256) # fmax + 1 = 255 + 1
transformada = np.log(original) * a
scipy.misc.imsave("imagens/lena-log.jpg", transformada)
