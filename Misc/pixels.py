from PIL import Image # Pillow Library https://python-pillow.org/

img = Image.new(mode = "RGB", size = (1,1))
pixels = img.load() # Creates the pixel map

for x in range(256):
    for y in range(256):
        for z in range (256):
            pixels[0,0] = (x,y,z)
            name = str(x).rjust(3,'0')+'_'+str(y).rjust(3,'0')+'_'+str(z).rjust(3,'0')+'.png'
            img.save(format='PNG', fp=name)
