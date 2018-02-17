from PIL import Image
path = "imagens/"
img = Image.open(path+'nature.jpg').convert('L')
img.save(path+'nature-PB.jpg')
