import numpy as np
import matplotlib.pyplot as plt
import scipy.misc

car = scipy.misc.imread("imagens/foto-escura.jpg")

histograma, intervalos = np.histogram(car, bins=np.arange(0,256))

# passo 1: calculo das probabilidades
npixels = car.shape[0] * car.shape[1] * 1.0 # usado para converter para float
probabilidades = histograma / npixels

FDP = np.zeros(256)
for i in range(256):
	# passo 2: calculo da FDP
	for j in range(i):
		FDP[i] = FDP[i] + probabilidades[j]
	
	# passo 3: arredondamento
	FDP[i] = round(FDP[i]*255)

# passo 4: agrupar os niveis de cinza
car1 = np.zeros(car.shape)	
for i in range(car.shape[0]):
	for j in range(car.shape[1]):
		car1[i][j] = int(FDP[car[i][j]])
		
scipy.misc.imsave("imagens/equaliza.png",car1)
