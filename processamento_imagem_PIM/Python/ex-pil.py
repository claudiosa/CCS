from PIL import Image
path = "imagens/"
image = Image.open(path+'python.png')
image.show()
r,g,b = image.getpixel( (x,y) )
image.save(path+'saida.png')