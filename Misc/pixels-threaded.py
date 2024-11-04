from PIL import Image # Pillow Library https://python-pillow.org/
import threading # import threading library

#img = Image.new(mode = "RGB", size = (1,1))
#pixels = img.load() # Creates the pixel map

def thread_process(start, end):
    img = Image.new(mode = "RGB", size = (1,1))
    pixels = img.load() # Creates the pixel map

    for x in range(start, end):
        for y in range(start, end):
            for z in range (start, end):
                pixels[0,0] = (x,y,z)
                name = str(x).rjust(3,'0')+'_'+str(y).rjust(3,'0')+'_'+str(z).rjust(3,'0')+'.png'
                img.save(format='PNG', fp=name)

t0 = threading.Thread(target=thread_process, args=(0, 32))
t1 = threading.Thread(target=thread_process, args=(32, 64))
t2 = threading.Thread(target=thread_process, args=(64, 96))
t3 = threading.Thread(target=thread_process, args=(96, 128))
t4 = threading.Thread(target=thread_process, args=(128, 160))
t5 = threading.Thread(target=thread_process, args=(160, 192))
t6 = threading.Thread(target=thread_process, args=(192, 224))
t7 = threading.Thread(target=thread_process, args=(224, 256))

t0.start()
t1.start()
t2.start()
t3.start()
t4.start()
t5.start()
t6.start()
t7.start()

t0.join()
t1.join()
t2.join()
t3.join()
t4.join()
t5.join()
t5.join()
t6.join()
t7.join()