from PIL import Image
path = "Imagens/"
img = Image.open(path+'nature.jpg').convert('L')
img.save(path+'nature-PB.jpg')